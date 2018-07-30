using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using System.Reflection;
using System.Xml;
using ce5b.SAPGateway;

namespace ce5b
{
    /// <summary>
    /// Main Stock count form
    /// XML string with the materials is passed in via constructor from frmStockCountStart
    /// PMWWebservices has a method PostInventoryCount which calls the RFC Z_PM_POST_STOCK_COUNT
    /// The 5 tabs are:
    /// Current item in count
    /// Serial numbers for current item
    /// All - overview of the whole count (qty field is editable
    /// Variance - when the user clicks post a variance with the SAP stock figure is shown here and the 
    /// user presses confirm to pos
    /// Alerts - error messages from the count
    /// </summary>

    public partial class frmBlindStockPost : Form
    {
        private frmBlindCount frmParent;
        private SAPGateway.POFunctions oSAPGateway;
        private DataSet ds;
        private DataTable otabOverview;		    //Overview
        private DataTable otabVariance;			//Variance
        private DataTable otabSernr;			//Current item serial numbers
        private DataTable otabAlert;			//Error messages
        private DataGridCell currentCell;			//Current cell on the main grid
        private DataGridCell currentSernrCell;		//Current cell on the serial number grid
        private VScrollBar vsb;						//Scroll bars main grid
        private HScrollBar hsb;
        private VScrollBar vsb2;					//Scroll bars serial number grid
        private HScrollBar hsb2;
        private string sPlant = "";				//Plant
        //private string sIBLNR = "";				//Count document number
        private bool gbDataChanged = false;			//Changes have been made?
        private int iPreviousTab = 0;				//Previous tab shown
        private int iIndex = 0;						//Index of current item in overview array
        //Hastable - serial number/ equipment number mapping array for items
        private Hashtable htSernr = new Hashtable();
        private frmBlindCount frmBlind;
        //private new frmStockCountStart Parent;

    

        #region variables
          private string textqty = null;
          private string textmatnr = null;
          private string textsloc = null;
          char[] seperator = { ':' };
          string con1 = null;
          string con2 = null;
          string con3 = null;
          string con4 = null;
          string ptext = null;
          string ltext = null;
          string Plantno = null;
          string Sloc = null;
          
        #endregion

        #region Structures
        private struct TabPageIndexes
        {
              public static int ALL = 0;
              public static int VARIANCE = 1;
              public static int ALERTS = 2;
              public static int SERIAL = 3;
        }
        // Serial and equipment mapping - objects are stored in an array, array is in a hashtable
        // indexed by the item number (note this is not the item number on document but the item 
        // number in the count list starting from zero)
        private struct SerialEquipment
        {
            public string sernr;
            public string equnr;
            public SerialEquipment(string pSernr, string pEqunr)
            {
                sernr = pSernr;
                equnr = pEqunr;
            }
        }
        #endregion

        public frmBlindStockPost(frmBlindCount pfrmParent,string Plantno,string Sloc, string Ptext, string Ltext)
        {
            #region Start Logger
            logger mylog = new logger();

            mylog.makelog("Starting Stock Count Main");
            #endregion
            InitializeComponent();

            this.frmParent = pfrmParent;
            this.ptext = Ptext;
            this.ltext = Ltext;
            this.txtEdit.Font = this.dgOverview.Font;
            this.txtSernrEdit.Font = this.dgSerial.Font;
            this.cmdPost.BackColor = System.Drawing.Color.LightGreen;
            this.BuildGrid();
            this.BuildVarianceGrid();
            this.BuildSernrTab();
            this.LoadData();
            this.RefreshSAPGateway();
            this.Plantno = Plantno;
            this.Sloc = Sloc;
            
            

        }
        #region Grids
        private void BuildGrid()
        {
            // Create data set
            this.ds = new DataSet("Dataset");

            // Add a table
            if (this.dgOverview.TableStyles.Count > 0) this.dgOverview.TableStyles.RemoveAt(0);

            this.otabOverview = this.ds.Tables.Add("Overview");

            // Add a table
            this.otabOverview.Columns.Add("sloc", typeof(string));
            this.otabOverview.Columns.Add("bin", typeof(string));
            this.otabOverview.Columns.Add("matnr", typeof(string));
            this.otabOverview.Columns.Add("descr", typeof(string));
            this.otabOverview.Columns.Add("qty", typeof(string));
            this.otabOverview.Columns.Add("uom", typeof(string));
            this.otabOverview.Columns.Add("oldmat", typeof(string));
            this.otabOverview.Columns.Add("stock", typeof(string));
            this.otabOverview.Columns.Add("item", typeof(string));
            this.otabOverview.Columns.Add("sernr", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "Overview";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "S Loc";
            cs.MappingName = "sloc";
            cs.Width = 30;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Bin";
            cs.MappingName = "bin"; // Data column name
            cs.Width = 45;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Mat Nr";
            cs.MappingName = "matnr"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Descr.";
            cs.MappingName = "descr"; // Data column name
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Count";
            cs.MappingName = "qty"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "UOM";
            cs.MappingName = "uom"; // Data column name
            cs.Width = 25;
            ts.GridColumnStyles.Add(cs);

            

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Item";
            cs.MappingName = "item"; // Data column name
            cs.Width = 20;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Old Mat";
            cs.MappingName = "oldmat"; // Data column name
            cs.Width = 60;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "stock"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "sernr"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            this.dgOverview.TableStyles.Add(ts);
            this.dgOverview.DataSource = this.otabOverview;


            // Get the grid scrollbars
            this.vsb = (VScrollBar)this.dgOverview.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgOverview);
            this.hsb = (HScrollBar)this.dgOverview.GetType().GetField("m_sbHorz", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgOverview);
            this.hsb.ValueChanged += new System.EventHandler(this.OverviewScroll_Click);
            this.vsb.ValueChanged += new System.EventHandler(this.OverviewScroll_Click);
        }

        private void BuildVarianceGrid()
        {
            this.otabVariance = this.ds.Tables.Add("Variance");

            // Add a table
            this.otabVariance.Columns.Add("sloc", typeof(string));
            this.otabVariance.Columns.Add("bin", typeof(string));
            this.otabVariance.Columns.Add("matnr", typeof(string));
            this.otabVariance.Columns.Add("descr", typeof(string));
            this.otabVariance.Columns.Add("qty", typeof(string));
            this.otabVariance.Columns.Add("stock", typeof(string));
            this.otabVariance.Columns.Add("var", typeof(string));
            this.otabVariance.Columns.Add("uom", typeof(string));
            this.otabVariance.Columns.Add("oldmat", typeof(string));
            this.otabVariance.Columns.Add("item", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "Variance";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "S Loc";
            cs.MappingName = "sloc";
            cs.Width = 30;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Bin";
            cs.MappingName = "bin"; // Data column name
            cs.Width = 45;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Mat Nr";
            cs.MappingName = "matnr"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Descr.";
            cs.MappingName = "descr"; // Data column name
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Qty";
            cs.MappingName = "qty"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "SAP";
            cs.MappingName = "stock"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Var.";
            cs.MappingName = "var"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "UOM";
            cs.MappingName = "uom"; // Data column name
            cs.Width = 25;
            ts.GridColumnStyles.Add(cs);

           

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "item"; // Data column name
            cs.Width = 0;

            ts.GridColumnStyles.Add(cs);

            this.dgVariance.TableStyles.Add(ts);
            this.dgVariance.DataSource = this.otabVariance;
        }

        private void OverviewScroll_Click(object sender, System.EventArgs e)
        {
            this.txtEdit.Visible = false;
        }

        private void GridClick(object sender, System.EventArgs e,
            ref DataGrid dgGrid,
            ref DataGridCell cell,
            ref TextBox txtBox,
            ref DataTable oTable,
            bool bSernr)
        {
            if (oTable == null || oTable.Rows.Count <= 0) return;

            try
            {
                cell = dgGrid.CurrentCell;
                if (!bSernr) if (cell.ColumnNumber != 4) return;
                // Get click event position (screen) and convert to grid position
                Point pt = dgGrid.PointToClient(Control.MousePosition);
                // Get information about click position (type, row/col)
                DataGrid.HitTestInfo hti = dgGrid.HitTest(pt.X, pt.Y);

                // Make sure the cell we want to edit is visible
                this.EnsureRowVisible(dgGrid, cell.RowNumber);
                // Resize and reposition TextBox to match current cell bounds
                Rectangle rc = dgGrid.GetCellBounds(cell.RowNumber, cell.ColumnNumber);

                txtBox.Bounds = this.RectangleToClient(dgGrid.RectangleToScreen(rc));
                txtBox.Location = new Point((rc.Location.X + dgGrid.Location.X), (rc.Location.Y + dgGrid.Location.Y));
                // Bring the focus to it
                txtBox.Focus();
                //Adjust its value to match current cell value
                txtBox.Text = dgGrid[cell.RowNumber, cell.ColumnNumber].ToString();
                if (txtBox.Text.CompareTo("0") == 0)
                {
                    txtBox.Text = "";
                }
                // Finally, show the textBox
                txtBox.Visible = true;
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
        }

        private void BuildSernrTab()
        {
            this.vsb2 = (VScrollBar)this.dgSerial.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgSerial);
            this.hsb2 = (HScrollBar)this.dgSerial.GetType().GetField("m_sbHorz", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgSerial);
            this.hsb2.ValueChanged += new System.EventHandler(this.sernrScroll_Click);
            this.vsb2.ValueChanged += new System.EventHandler(this.sernrScroll_Click);

            DataGridTableStyle ts;

            // Add a table

            this.otabSernr = this.ds.Tables.Add("Sernr");
            this.otabSernr.Columns.Add("sernr", typeof(string));
            this.otabSernr.Columns.Add("equnr", typeof(string));

            ts = new DataGridTableStyle();

            ts.MappingName = "Sernr";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Serial";
            cs.MappingName = "sernr"; // Data column name
            cs.Width = 100;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Equip.";
            cs.MappingName = "equnr"; // Data column name
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            this.dgSerial.TableStyles.Add(ts);
            this.dgSerial.DataSource = this.otabSernr;
        }
        /// <summary>
        /// Rebuild serial number data grid for the current item
        /// </summary>
        private void RefreshSerialTab()
        {
            int iAdded = 0;
            int iToDo = 0;
            int iQty = int.Parse(textqty);
            ArrayList aSernr = null;

            this.txtSernrEdit.Visible = false;
            this.otabSernr.Clear();
            if (((string)this.otabOverview.Rows[iIndex]["sernr"]) != "X") return;

            DataRow oRow;
            //Anything stored in hastable for current item in array? - using the index for current item
            //in overview array as key
            if (this.htSernr != null && this.htSernr.ContainsKey(this.iIndex.ToString()))
            {
                //get the array of serial numbers for current item
                IDictionaryEnumerator enumSerial = this.htSernr.GetEnumerator();
                while (enumSerial.MoveNext())
                {
                    if (this.iIndex.ToString() == (string)enumSerial.Key)
                    {
                        aSernr = (ArrayList)enumSerial.Value;
                        break;
                    }
                }
                if (aSernr != null)
                {
                    //Output stored serial numbers on grid
                    foreach (SerialEquipment oSernr in aSernr)
                    {
                        oRow = this.otabSernr.NewRow();
                        oRow["sernr"] = oSernr.sernr;
                        oRow["equnr"] = oSernr.equnr;
                        this.otabSernr.Rows.Add(oRow);
                        if (iAdded == iQty) break;
                    }
                    iAdded = aSernr.Count;
                }
            }
            iToDo = (iQty - iAdded);
            //Output remaining blank serial numbers on grid
            for (int i = 1; i <= iToDo; i++)
            {
                oRow = this.otabSernr.NewRow();
                oRow["sernr"] = "";
                oRow["equnr"] = "";
                this.otabSernr.Rows.Add(oRow);
            }
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); }catch { }
        }

        private void dgOverview_Click(object sender, System.EventArgs e)
        {
            this.GridClick(sender, e, ref this.dgOverview, ref this.currentCell, ref this.txtEdit, ref this.otabOverview, false);
        }

        private void EnsureRowVisible(DataGrid grd, int Row)
        {
            // Obtain first and last visible rows via reflection
            int FirstVisibleRow = (int)grd.GetType().GetField("m_irowVisibleFirst", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(grd);
            int LastVisibleRow = (int)grd.GetType().GetField("m_irowVisibleLast", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(grd);

            // If our row is outside visible range, scroll to it
            if (Row < FirstVisibleRow || Row > LastVisibleRow)
            {
                // Grid's vertical scrollbar has step one and Maximum set to grid's number of rows
                // This means that setting its value to a particular row number either brings that row to 
                // the top of the grid, or at least makes sure it is visible
                // This could be somewhat modified to intelligently calculate to which row one needs to scroll
                // minimizing the amount of scrolling
                VScrollBar lvsb = (VScrollBar)grd.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(grd);
                lvsb.Value = Row;
            }
        }

        private void dgSerial_Click(object sender, System.EventArgs e)
        {
            this.GridClick(sender, e, ref this.dgSerial, ref this.currentSernrCell, ref this.txtSernrEdit, ref this.otabSernr, true);
        }

        private void HandleSerialNumberEntry()
        {
            string sSernr = "";
            string sEqunr = "";
            string sFloc = "";
            string sSloc = "";
            try
            {
                frmStart.RemoveScanSuffix(txtSernrEdit);
                this.otabSernr.Rows[this.currentSernrCell.RowNumber][this.currentSernrCell.ColumnNumber] =
                this.txtSernrEdit.Text;
                this.frmParent.frmParent.UpdateLastDidSomethingAt();

           //Equipment number entered - get serial number
                if (this.currentSernrCell.ColumnNumber == 1 && this.txtSernrEdit.Text.Trim() != "")
                {
                    if (this.oSAPGateway.EqunrSernrValidate(ref sSernr, textmatnr, this.txtSernrEdit.Text))
                    { this.otabSernr.Rows[this.currentSernrCell.RowNumber][0] = sSernr; }
                    else
                    {
                        sSernr = (string)otabSernr.Rows[this.currentSernrCell.RowNumber][0];
                        sSernr.Trim();
                        if (sSernr != "")
                        {
                            sEqunr = this.CreateEqunr(textmatnr, sSernr, sSloc);
                            if (sEqunr == "")
                            {
                                this.txtSernrEdit.Text = "";
                                this.otabSernr.Rows[this.currentSernrCell.RowNumber][0] = "";
                            }
                        }
                        else
                        {
                            MessageBox.Show("Equipment master does not have a serial number", frmStart.MESSAGE_BOX_TITLE);
                            this.otabSernr.Rows[this.currentSernrCell.RowNumber][this.currentSernrCell.ColumnNumber] = "";
                        }
                    }
                }
           //Serial number entered - get equipment
                else
                {
                    sSloc = textsloc;
                    sEqunr = this.oSAPGateway.GetEqunrAndFLoc(this.txtSernrEdit.Text, textmatnr, ref sFloc, ref sSloc);
                    if (sEqunr.Trim() == "" && this.txtSernrEdit.Text.Trim() != "")
                    {
                        sEqunr = this.CreateEqunr(textmatnr, this.txtSernrEdit.Text,textsloc);
                        this.otabSernr.Rows[this.currentSernrCell.RowNumber][1] = sEqunr;
                        if (sEqunr == "") this.txtSernrEdit.Text = "";
                    }
                    this.otabSernr.Rows[this.currentSernrCell.RowNumber][1] = sEqunr;
                }
                this.gbDataChanged = true;
            }
            catch (Exception ex)
            {
               frmStart.HandleException(ex, false);
            }
        }

        private void txtEdit_TextChanged(object sender, System.EventArgs e)
        {
            if (this.txtEdit.Text.Trim() == "")
            {
                return;
            }

            try
            {
                Double.Parse(this.txtEdit.Text.Trim());
            }
            catch (FormatException)
            {
                this.txtEdit.Text = "0";
                MessageBox.Show("Please enter a valid number");
            }

            this.otabOverview.Rows[this.currentCell.RowNumber][this.currentCell.ColumnNumber] = this.txtEdit.Text;
            this.gbDataChanged = true;
            this.cmdConfirm.Visible = false;
            if (this.currentCell.RowNumber == this.iIndex)
            {
  //              this.txtQty.Text = this.txtEdit.Text;
            }
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); } catch { }
        }
        private void txtSernrEdit_LostFocus(object sender, System.EventArgs e)
        {

        }
        private void txtSernrEdit_Validated(object sender, System.EventArgs e)
        {
            this.HandleSerialNumberEntry();
        }

        private void sernrScroll_Click(object sender, System.EventArgs e)
        {
            this.txtSernrEdit.Visible = false;
        }
        #endregion
        #region Windows events
        private void frmStockCountMain_Load(object sender, System.EventArgs e)
        {
            this.cmdConfirm.BackColor = System.Drawing.Color.LightGreen;
            this.cmdPost.BackColor = System.Drawing.Color.LightGreen;
            this.cmdGoto.BackColor = System.Drawing.Color.LightCyan;
        }

        private void cmdNext_Click(object sender, System.EventArgs e)
        {
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
            this.Navigate(1, false);
            
        }

        private void Navigate(int iWhere, bool bLocation)
        {
            int iRow = 0;
           
            if (bLocation) iRow = iWhere;
            else
            {
                iRow = iIndex + iWhere;
            }
            DataRow oItem;

//goto frmBlindCount and show line details

            if (this.otabOverview.Rows.Count > iRow && iRow >= 0)
            {
                iIndex = iRow;
                oItem = this.otabOverview.Rows[iRow];
                textmatnr = (string)oItem["matnr"];
                textsloc = (string)oItem["sloc"];          
                textqty = (string)oItem["qty"];
                if (textqty.CompareTo("0") == 0)
                {
                    textqty = null;
                }
                string isernr = null;
                if (oItem["sernr"] != null) isernr = oItem["sernr"].ToString();

                if (isernr == "X")
                {
                    this.StoreSerialNumbers();
                    this.RefreshSerialTab();
                }
                else
                {
                    this.txtSernrEdit.Text = "";
                    this.txtSernrEdit.Visible = false;
                    this.otabSernr.Clear();
                }

            }
            else
            {
                if (this.otabOverview.Rows.Count <= iRow)
                {
                    //Was the last item, go to the All tab.
                    this.tabControl1.SelectedIndex = TabPageIndexes.ALL;
                }
            }
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); } catch { }
        }

        private void cmdPrev_Click(object sender, System.EventArgs e)
        {
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
            this.Navigate(-1, false);
        }

        private void tabControl1_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); }catch { }
            if (this.iPreviousTab == TabPageIndexes.SERIAL) this.StoreSerialNumbers();
            this.iPreviousTab = this.tabControl1.SelectedIndex;
            if (this.tabControl1.SelectedIndex == TabPageIndexes.SERIAL)
            {
                this.iIndex = 0;
                this.Navigate(this.currentCell.RowNumber, false);
            }
        }

        private void cmdGoto_Click(object sender, System.EventArgs e)
        {
// goto material entry screen and display line details
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); } catch { }
            if (this.dgOverview.IsSelected(this.dgOverview.CurrentRowIndex))
            {
                this.Navigate(this.dgOverview.CurrentRowIndex, true);
                this.tabControl1.SelectedIndex = TabPageIndexes.ALL;
// display the line details on the entry screen allowing for empty fields    
                DataRow oItem;
                oItem = this.otabOverview.Rows[this.dgOverview.CurrentRowIndex];
                try { con1 = this.ptext + seperator[0] + this.ltext; } catch {}
                try { con2 = (string)oItem["matnr"];} catch { }
                try { con2 = con2 + seperator[0] + (string)oItem["uom"];}catch { }
                try { con3 = (string)oItem["descr"]; } catch { }
                try { con3 = con3 + seperator[0] + (string)oItem["sernr"];} catch { }
                try { con4 = (string)oItem["qty"] ; } catch { }
                try { con4 = con4 + seperator[0] + (string)oItem["bin"]; } catch { }
                this.frmBlind = new frmBlindCount(this.frmParent.frmParent, con1, con2, con3, con4, "X");
                this.frmBlind.ShowDialog();
            }
        }

        private void chkZero_Click(object sender, System.EventArgs e)
        {
            if (this.chkZero.Checked)
            {
                MessageBox.Show("Any items where you have not entered a quantity will be counted as zero on SAP.", frmStart.MESSAGE_BOX_TITLE);
            }
        }

        private void frmStockCountMain_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (this.gbDataChanged)
            {
                if (MessageBox.Show("Warning: unsaved changes will be lost.\nClick OK to exit.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel,
                    MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1) != DialogResult.OK)
                    e.Cancel = true;
            }
        }

        private void cmdPost_Click(object sender, System.EventArgs e)
        {
//            this.frmParent.UpdateLastDidSomethingAt();
            this.StoreSerialNumbers();
            if (this.CheckSerialNumbers())
            {
                if (!this.CheckVariance())


                {
/// Check if the SAP connection has timed out - if so prompt to log in again and then post document   

                    //long iSubtracted = this.frmParent.frmParent.frmParent.frmParent.SAPlogontime.Ticks;

                    //iSubs2 = iSubtracted / System.TimeSpan.TicksPerSecond;

                    //long iElapsed = ((DateTime.UtcNow.Ticks - this.frmParent.frmParent.frmParent.frmParent.SAPlogontime.Ticks) / System.TimeSpan.TicksPerSecond);
                                                         
                    long iElapsed = ((DateTime.UtcNow.Ticks - this.frmParent.frmParent.frmParent.frmParent.SAPlogontime.Ticks) / System.TimeSpan.TicksPerSecond);
                    if (iElapsed > this.frmParent.frmParent.frmParent.frmParent.TIMEOUT_FOR_SAP_LOGIN)
                    {
                        try { GetSAPConnection(); } catch { }
                    }
                    this.PostBlindCount();
                }
            }
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); }catch { }
        }
        private void cmdConfirm_Click(object sender, System.EventArgs e)
        {
/// Check if the SAP connection has timed out - if so prompt to log in again and then post document   
            long iElapsed = ((DateTime.UtcNow.Ticks - this.frmParent.frmParent.frmParent.frmParent.SAPlogontime.Ticks) / System.TimeSpan.TicksPerSecond);
            if (iElapsed > this.frmParent.frmParent.frmParent.frmParent.TIMEOUT_FOR_SAP_LOGIN)
            {
                try { GetSAPConnection(); } catch { }
            }
            this.PostBlindCount();
            try { this.frmParent.frmParent.UpdateLastDidSomethingAt(); } catch { }
        }

        #endregion
        #region General

        private void LoadData()
        {
            DataRow oRow;
            int iSernrCount = 0;
            int rowcount = 0;
            int colcount = 0;
            int item = 1;
            int c = 0;
            int r = 0;
   
            colcount = this.frmParent.countdoc.GetLength(1);
            rowcount = this.frmParent.stockcount;

            for (c = 0; c < rowcount; c++)
            {

                oRow = this.otabOverview.NewRow();
                oRow["item"] = item;
                for (r = 0; r <= colcount; r++)
                {
                    switch (r)
                    {
                        case 0:
                            break;
                        case 1:
                            oRow["sLoc"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 2:
                            oRow["matnr"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 3:
                            oRow["descr"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 4:
                            oRow["qty"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 5:
                            oRow["uom"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 6:
                            oRow["oldmat"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 7:
                            oRow["bin"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                        case 8:
                            oRow["sernr"] = this.frmParent.countdoc.GetValue(c, r);
                            if ((string)this.frmParent.countdoc.GetValue(c, r) == "X")
                            {
                                iSernrCount++;
                            }
                            break;
                        case 9:
                            oRow["stock"] = this.frmParent.countdoc.GetValue(c, r);
                            break;
                    }

                }

                if (oRow["matnr"] != null)
                {
                    this.otabOverview.Rows.Add(oRow);
                    item++;
                }
                

            }
              if (rowcount > 0) this.Navigate(0, false);
              if (iSernrCount > 0) this.htSernr = new Hashtable(iSernrCount);              
        }

        private void StoreSerialNumbers()
        {
            string sSernr = "";
            string sEqunr = "";
            //string message = null;
            bool bError = false;
            ArrayList aCheck = new ArrayList();

            if (this.otabSernr.Rows.Count > 0)
            {
                ArrayList aSernr = new ArrayList();
                foreach (DataRow oRow in this.otabSernr.Rows)
                {
                    sSernr = (string)oRow["sernr"];
                    sEqunr = (string)oRow["equnr"];
                    if (sSernr.Trim() != "")
                    {
                        if (aCheck.Contains(sSernr)) bError = true;
                        else
                        {
                            aSernr.Add(new SerialEquipment(sSernr, sEqunr));
                            aCheck.Add(sSernr);
                        }
                    }
                }
                if (this.htSernr.ContainsKey(this.iIndex.ToString())) this.htSernr.Remove(this.iIndex.ToString());
                this.htSernr.Add(this.iIndex.ToString(), aSernr);
                if (bError)
                    MessageBox.Show("Serial numbers must be unique. Duplicate serial numbers will be cleared.", frmStart.MESSAGE_BOX_TITLE);
            }
            else
            {
//                if (this.htSernr.ContainsKey(this.iIndex.ToString())) this.htSernr.Remove(this.iIndex.ToString());
            }
        }

        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }

        private bool CheckSerialNumbers()
        {
            int iQty = 0;
            int iCount = 0;
            string sIsSerialised = "";
            int iSerialCount = 0;
            bool bError = false;
            
            foreach (DataRow oRow in this.otabOverview.Rows)
            {
                if (oRow["sernr"].ToString() == "") goto finish;
                    

                sIsSerialised = ((string)oRow["sernr"]).Trim();
                iQty = int.Parse(((string)oRow["qty"]).Trim());
                if (sIsSerialised != "" && iQty > 0)
                {
                    ArrayList aSernr = null;
                    if (this.htSernr.ContainsKey(iCount.ToString()))
                    {
                        IDictionaryEnumerator enumSerial = this.htSernr.GetEnumerator();
                        while (enumSerial.MoveNext())
                        {
                            if (iCount.ToString() == (string)enumSerial.Key)
                            {
                                aSernr = (ArrayList)enumSerial.Value;
                                break;
                            }
                        }
                        if (aSernr != null)
                        {
                            foreach (SerialEquipment oSernr in aSernr)
                            {
                                if (oSernr.sernr.Trim() != "") iSerialCount++;
                            }
                        }
                        if (iSerialCount < iQty) bError = true;
                    }
                    else bError = true;
                }
                if (bError) break;

                iCount++;

            finish:
                break;
            }
            if (bError)
            {
                MessageBox.Show("Please enter serial numbers for all serialized items", frmStart.MESSAGE_BOX_TITLE);
                this.Navigate(iCount, true);
                this.tabControl1.SelectedIndex = TabPageIndexes.SERIAL;
                return false;
            }
            else return true;
        }

        private bool CheckVariance()
        {
            double dStock = 0;
            double dCountedQty = 0;
            double dVariance = 0;
            bool bVariance = false;
            DataRow oVarRow;

            if (this.otabVariance.Rows.Count == 0)
            {
                return false;
            }
            this.otabVariance.Rows.Clear();
            

            foreach (DataRow oRow in this.otabOverview.Rows)
            {
                try
                {
                    dStock = double.Parse((string)oRow["stock"]);
                    dCountedQty = double.Parse((string)oRow["qty"]);
                    dVariance = dCountedQty - dStock;
                    if (dCountedQty == 0 && this.chkZero.Checked == false) dVariance = 0;
                    if (dVariance != 0)
                    {
                        oVarRow = this.otabVariance.NewRow();
                        oVarRow["sloc"] = oRow["sloc"];
                        oVarRow["bin"] = oRow["bin"];
                        oVarRow["descr"] = oRow["descr"];
                        oVarRow["qty"] = oRow["qty"];
                        oVarRow["uom"] = oRow["uom"];
                        oVarRow["matnr"] = oRow["matnr"];
                        oVarRow["oldmat"] = oRow["oldmat"];
                        oVarRow["item"] = oRow["item"];
                        oVarRow["stock"] = oRow["stock"];
                        oVarRow["var"] = dVariance.ToString();

                        this.otabVariance.Rows.Add(oVarRow);
                        bVariance = true;
                    }
                }
                catch (FormatException) { }

            }
            if (bVariance)
            {
                MessageBox.Show("There is a variance with the stock figure on SAP. Please confirm you wish to Post this data.");
                this.tabControl1.SelectedIndex = TabPageIndexes.VARIANCE;
                this.cmdConfirm.Visible = true;
            }
            return bVariance;
        }

        #endregion
        #region SAP
        private string CreateEqunr(string sMatnr, string sSernr, string sSloc)
        {
            string sEqunr = "";
            string sMessage = "";
            try
            {
                if (MessageBox.Show("No equipment master exists for serial number " + sSernr + ". Do you wish to create one?", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2)
                    == DialogResult.Yes)
                {
                    if (!this.GetSAPConnection()) return "";

                    for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                    {
                        try
                        {
                            if (!this.oSAPGateway.CreateEqunr(this.frmParent.frmParent.frmParent.frmParent.SAPUname,this.frmParent.frmParent.frmParent.frmParent.SAPPword,
                                                        sMatnr, sSernr, this.sPlant, sSloc,
                                                        "261", ref sEqunr, ref sMessage))
                            {
                                MessageBox.Show(sMessage, frmStart.MESSAGE_BOX_TITLE);
                            }
                            break;
                        }
                        catch (Exception ex)
                        {
                            if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                                frmStart.HandleException(ex, false);
                            else this.RefreshSAPGateway();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            return sEqunr;
        }
        private bool GetSAPConnection()
        {
            string sLoginError = "";
            if (this.frmParent.frmParent.frmParent.frmParent.SAPUname == "" || this.frmParent.frmParent.frmParent.frmParent.SAPPword== "")
            {
                if (!this.frmParent.frmParent.frmParent.frmParent.GetSAPConnection(ref sLoginError))
                {
                    MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
                    return false;
                }
            }
            return true;
        }

        private void PostBlindCount()
        {
            string sItemXML = "<items>";
            string sSernrXML = "<serial>";
            double dQty = 0;
            string sUOM = "";
            string sMatnr = "";
            string sItem = "";
            string sMessXML = "";
            string sBMessage = null;
            int iCount = 0;
            bool bExit = false;
            string sIBLNR = null;

 //first create the inventory count doc and then post using PostInventoryCount if successful

            try
            {
                foreach (DataRow oRow in this.otabOverview.Rows)
                {
                    sUOM = (string)oRow["uom"];
                    sMatnr = (string)oRow["matnr"];
                    sItem = (string)oRow["item"];

                    try { dQty = double.Parse((string)oRow["qty"]); }
                    catch { }

                    if (dQty > 0 || this.chkZero.Checked == true)
                    {
                        sItemXML += "<i matnr='" + sMatnr + "' ";
                        sItemXML += "item='" + sItem + "' ";
                        sItemXML += "qty='" + dQty.ToString() + "' ";
                        sItemXML += "uom='" + sUOM + "'></i>";

                        ArrayList aSernr = null;
                        if (this.htSernr.ContainsKey(iCount.ToString()))
                        {
                            IDictionaryEnumerator enumSerial = this.htSernr.GetEnumerator();
                            while (enumSerial.MoveNext())
                            {
                                if (iCount.ToString() == (string)enumSerial.Key)
                                {
                                    aSernr = (ArrayList)enumSerial.Value;
                                    break;
                                }
                            }
                            if (aSernr != null)
                            {
                                foreach (SerialEquipment oSernr in aSernr)
                                {
                                    sSernrXML += "<i item='" + sItem + "' ";
                                    sSernrXML += "sernr='" + oSernr.sernr.Trim() + "'></i>";
                                }
                            }
                        }
                    }
                    iCount++;
                }
                sItemXML += "</items>";
                sSernrXML += "</serial>";
                this.cmdConfirm.Enabled = false;
                this.cmdPost.Enabled = false;
                Cursor.Current = Cursors.WaitCursor;
//check if login active before post 
                try { GetSAPConnection(); }catch { }
                sMessXML = this.oSAPGateway.BlindStockCount(sItemXML,this.Plantno,this.Sloc, 
                                           this.frmParent.frmParent.frmParent.frmParent.SAPUname,
                                           this.frmParent.frmParent.frmParent.frmParent.SAPPword,
                                           ref sIBLNR);
                 
                XmlDocument oXML = new XmlDocument();
                oXML.LoadXml(sMessXML);
                XmlNodeList oErrors = oXML.GetElementsByTagName("e");
                if (oErrors.Count > 0)
                {
                    DataRow oAlert;
                    if (this.otabAlert == null)
                    {
                        this.otabAlert = this.ds.Tables.Add("Alerts");
                        this.otabAlert.Columns.Add("message", typeof(string));
                        this.dgAlert.DataSource = this.otabAlert;
                     }
                    else this.otabAlert.Rows.Clear();

                    foreach (XmlNode oNode in oErrors)
                    {
                        oAlert = this.otabAlert.NewRow();
                        oAlert["message"] = oNode.InnerText;
                        this.otabAlert.Rows.Add(oAlert);
                    }
                    MessageBox.Show("Errors occured - please review", frmStart.MESSAGE_BOX_TITLE);
                    this.tabControl1.SelectedIndex = 2;

                }
                else
                {
//post the count to the created document
                    PostCount(sMessXML, sItemXML, sSernrXML, oErrors, sBMessage, ref bExit, sIBLNR);
                }
                this.cmdConfirm.Visible = false;
                
            }
            catch (Exception ex)
            {

                frmStart.HandleException(ex, false);
            }

           finally
            {
                Cursor.Current = Cursors.Default;
                this.cmdConfirm.Enabled = true;
                this.cmdPost.Enabled = true;
                if (bExit)
                {
                    Array.Clear(this.frmParent.countdoc,0,10);
                    con1 = null; con2 = null; con3 = null; con4 = null;
                    con1 = this.Plantno; con3 = this.Sloc;
                    con2 = this.ptext; con4 = this.ltext;
                    this.frmBlind = new frmBlindCount(this.frmParent.frmParent, con1, con2, con3, con4, " ");
                    this.Close();
                    this.frmBlind.ShowDialog();
                 }
                        
            }
            
        }
        #endregion

        private void PostCount(string sMessXML, string sItemXML, string sSernrXML,
                               XmlNodeList oErrors, string sBMessage, ref bool bExit, string sIBLNR)
        {

            {
                try { GetSAPConnection(); }
                catch { }
                sMessXML = this.oSAPGateway.PostInventoryCount(sIBLNR, sItemXML, sSernrXML,
                           this.frmParent.frmParent.frmParent.frmParent.SAPUname, this.frmParent.frmParent.frmParent.frmParent.SAPPword);

                XmlDocument aXML = new XmlDocument();
                aXML.LoadXml(sMessXML);
                XmlNodeList aErrors = aXML.GetElementsByTagName("e");
                if (aErrors.Count > 0)
                {
                    DataRow oAlert;
                    if (this.otabAlert == null)
                    {
                        this.otabAlert = this.ds.Tables.Add("Alerts");
                        this.otabAlert.Columns.Add("message", typeof(string));
                        this.dgAlert.DataSource = this.otabAlert;

                    }
                    else this.otabAlert.Rows.Clear();

                    foreach (XmlNode oNode in aErrors)
                    {
                        oAlert = this.otabAlert.NewRow();
                        oAlert["message"] = oNode.InnerText;
                        this.otabAlert.Rows.Add(oAlert);
                    }
                    MessageBox.Show("Errors occured - please review", frmStart.MESSAGE_BOX_TITLE);
                    this.tabControl1.SelectedIndex = 2;

                }
                else
                {
                    sBMessage = "Count " + sIBLNR + " has been posted successfully.";
                    MessageBox.Show(sBMessage, frmStart.MESSAGE_BOX_TITLE);
                    this.gbDataChanged = false;
                    Cursor.Current = Cursors.Default;
                    bExit = true;
                }
            }
        }


        private void txtMaterial_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPlant_TextChanged(object sender, EventArgs e)
        {

        }

        private void lblPlant_ParentChanged(object sender, EventArgs e)
        {

        }

        private void dgOverview_CurrentCellChanged(object sender, EventArgs e)
        {

        }

        private void dgSerial_CurrentCellChanged(object sender, EventArgs e)
        {

        }

        private void tbpOverview_Click(object sender, EventArgs e)
        {

        }

        private void statusBar1_ParentChanged(object sender, EventArgs e)
        {

        }

        private void chkZero_CheckStateChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

            if (this.dgOverview.IsSelected(this.dgOverview.CurrentRowIndex))
            {
//delete the current selected line item
                this.tabControl1.SelectedIndex = TabPageIndexes.ALL;
                 this.otabOverview.Rows[this.dgOverview.CurrentRowIndex].Delete();
            }
        }

    }
}