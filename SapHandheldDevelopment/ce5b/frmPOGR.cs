using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Reflection;
using ce5b.SAPGateway;
using System.IO;
using System.Runtime.InteropServices;

namespace ce5b
{
    /// <summary>
    /// This is the form for Goods Receipt of Purchase Orders
    /// The user enter a PO number and a SOAP call is forwarded
    /// via NISAPWIRELESS to SAP to get the data using BAPI_PO_GETDETAIL
    ///
    /// Data is loaded into an editable grid (the complex bit is the fact that on the CF the
    /// grid is not editable - hence we have to overlay textboxes and dropdowns for the editable
    /// fields.
    ///
    /// Serial Numbers are entered via a similar data grid
    ///
    /// The data is posted on SAP via a SOAP call forwarded by NISAPWIRELESS to the goods movement create  BAPI
    ///
    /// </summary>

    public partial class frmPOGR : Form
    {
        #region Constants
        private const string MOVEMENT_TYPE = "101";
        private const int RECEIVE_COLUMN = 1;
        private const string STORAGE_LOCATION_NOT_APPLICABLE = "N/A";
        private const string PRINTING_NOT_APPLICABLE = "N/A";
        private const string ALREADY_COMPLETE = "DONE";
        private const string PRODUCTION_PO = "ZPRO";
        #endregion
        #region Data grid column numbers
        private int SLOC_COLUMN = 0;
        private int SERNR_COLUMN = 0;
        private int EBELP_COLUMN = 0;
        private int OUTSTANDING_COLUMN = 0;
        private int PRINT_LABELS_COLUMN = 0;
        private int DESCR_COLUMN = 0;
        #endregion
        #region Data Grid scroll bar, current cells etc.
        private VScrollBar vsb;
        private HScrollBar hsb;
        private VScrollBar vsb2;
        private HScrollBar hsb2;
        private DataGridCell currentCell;
        private DataGridCell currentSernrCell;
        #endregion
        #region General
        private SAPGateway.POFunctions oSAPGateway;			//SOAP Services provided by the gateway server
        private bool bStorageLocation = false;					//Any need to show storage location?
        private bool bPrintLabels = false;						//Any need to print labels?
        private bool bSernr = false;							//Any need for serial numbers??
        private bool bRefreshSernr = false;						//Flag to refresh the serail number tag
        private bool bStickOnLine = false;						//Stick on current line rather than jump to next when scanning
        private bool bChanges = false;							//Any changes made - for exit warning
        private DataSet ds;										//Data set - stores data tables for grids
        private System.Data.DataTable oPOItems;					//PO Items table
        private System.Data.DataTable oPOItemsText;				//PO Items Long Text table
        private System.Data.DataTable oSernr;					//Serial numbers table
        private string SernrXML;								//XML string containing info on items with serial numbers
        private string SerialNumberStore = "<serial></serial>";	//Serial numbers entered XML string
        private string[] aDefaultQty;							//Array containing the default quantites to be received
        private XmlNodeList xmlSloc;							//XML node list of storage locations for materials
        private char ScanMode = 'S';							//Scanning or manual entry?
        public frmStart frmParent;								//parent form
        //private frmShowLog ShowLog;

        frmStart frmStart = new frmStart();

        
        #endregion

        public frmPOGR(frmStart frmParent)
        {
            #region Start Logger
            logger mylog = new logger();

            //kill log
            if (File.Exists("logfile.txt"))
            {
                File.Delete("logfile.txt");
            }

            mylog.makelog("Starting PMGM");
            #endregion

            InitializeComponent();
            this.frmParent = frmParent;

/*            this.lblStatusBar.Text = frmParent.lblStatusBar.Text;

                        if (frmStart.debug != false)//TRUE
            {
                this.mnuiDebugOn.Enabled = true;
                this.mnuiDebugOn.Text = "Debug Off";
            }
            else
            {
                this.mnuiDebugOn.Enabled = true;
                this.mnuiDebugOn.Text = "Debug On";
            }
 */
        }

        #region Main Events
        /// <summary>
        /// PO number entered- can be scanned and therefore submitted automatically
        /// also after 10 char input submit automatically
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtPO_TextChanged(object sender, System.EventArgs e)
        {
            this.txtPO = frmStart.RemoveScanSuffix(this.txtPO);
            if (this.txtPO.TextLength >= 10) this.GetPOFromSAP();
            this.frmParent.UpdateLastDidSomethingAt();
        }

        private void txtPO_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            //If enter pressed when in the PO number field, treat it as though the user
            //has clicked on the OK button.
            if (e.KeyChar == (char)13)
            {
                this.cmdGetPO_Click(this, new EventArgs());
            }
        }

        private void frmPOGR_Load(object sender, System.EventArgs e)
        {
            this.BuildGrid();											//Setup the main items grid
            this.txtEdit.Font = this.gridPOItems.Font;					//Set font for text edit and combo that overlay the items grid
            this.comboSloc.Font = this.gridPOItems.Font;
            this.txtPO.Focus();
            //Set status bar text - take from start form
            //this.statusBar1.Text = this.frmParent.statusBar1.Text;

            if (this.frmParent.SAPPword != "" & this.frmParent.SAPUname != "")
            {
                this.mnuiLogoff.Enabled = true;
                this.mnuiLogon.Enabled = false;
            }
            else
            {
                this.mnuiLogoff.Enabled = false;
                this.mnuiLogon.Enabled = true;
            }
            //Delegate for search image click - manual as not in designer
            this.imgSearch.Click += new System.EventHandler(this.imgSearch_Click);
            Cursor.Current = Cursors.Default;
            this.cmdGetPO.BackColor = System.Drawing.Color.LightGreen;
            this.cmdGR.BackColor = System.Drawing.Color.LightGreen;
            //Setup SAP call
            this.RefreshSAPGateway();
        }

        private void cmdGetPO_Click(object sender, System.EventArgs e)
        {
            this.GetPOFromSAP();
            this.frmParent.UpdateLastDidSomethingAt();
        }

        /// <summary>
        /// Adjust menu when the tab page is changed
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tabControl1_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.txtEdit.Visible = false;
            if (this.txtSernrEdit != null) this.txtSernrEdit.Visible = false;
            this.frmParent.UpdateLastDidSomethingAt();
            if (this.tabControl1.SelectedIndex != 1) this.mnuiQty.Enabled = false;
            else this.mnuiQty.Enabled = true;
            if (this.tabControl1.SelectedIndex != 0) this.mnuiPO.Enabled = false;
            else this.mnuiPO.Enabled = true;
            if (this.tabControl1.SelectedIndex != 2) this.mnuiSerial.Enabled = false;
            else this.mnuiSerial.Enabled = true;

            if (this.tabControl1.SelectedIndex == 1) this.txtDelNote.Focus();

            if (this.tabControl1.SelectedIndex == 2 && this.bRefreshSernr) this.RefreshSernrTab();
            if (this.tabControl1.SelectedIndex == 2)
            {
                this.gridPOItems.CurrentCell = new DataGridCell(0, 2);
                this.gridPOItems_Click(this, new EventArgs());
            }
        }
        /// <summary>
        /// Post Goods receipt clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdGR_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            if (this.bRefreshSernr) this.RefreshSernrTab();
            if (!this.CheckStorageLocation()) return;
            if (!this.CheckSerialNumbers())
            {
                this.tabControl1.SelectedIndex = 2;
                return;
            }

            if (MessageBox.Show("Please confirm you wish to proceed.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel, MessageBoxIcon.Asterisk, MessageBoxDefaultButton.Button2)
                == DialogResult.OK)
            {
                this.PostGoodsReceipt();
            }
        }
        private void imgSearch_Click(object sender, System.EventArgs e)
        {
            this.imgSearch.Enabled = false;
            this.panelImageHoldSearch.BackColor = System.Drawing.Color.Black;
            this.panelImageHoldSearch.Refresh();
            this.LaunchSearch();
            this.panelImageHoldSearch.BackColor = System.Drawing.Color.White;
            this.imgSearch.Enabled = true;
        }
        private void txtDelNote_TextChanged(object sender, System.EventArgs e)
        {
            bool bScan = false;
            this.txtDelNote = frmStart.RemoveScanSuffix(this.txtDelNote, out bScan);
            this.bChanges = true;
            //Data was scanned so move to the next field
            if (bScan) this.txtScanDoc.Focus();
        }

        private void txtScanDoc_TextChanged(object sender, System.EventArgs e)
        {
            this.txtScanDoc = frmStart.RemoveScanSuffix(this.txtScanDoc);
            this.bChanges = true;
        }
        /// <summary>
        /// Text box used to overlay text input fields on the items grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtEdit_TextChanged(object sender, System.EventArgs e)
        {
            this.HandleTextInput();
            this.bChanges = true;
        }
        /// <summary>
        /// Warning if changes not saved when exiting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void frmPOGR_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (this.bChanges)
            {
                if (MessageBox.Show("Warning: unsaved changes will be lost.\nClick OK to exit.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel,
                    MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1) != DialogResult.OK)
                    e.Cancel = true;
            }
        }

        #endregion
        #region Main Grid
        private void gridPOItems_Click(object sender, System.EventArgs e)
        {
            //Get the value of the cell clicked on
            string sVal = "";
            if (this.oPOItems == null || this.oPOItems.Rows.Count <= 0) return;

            try
            {
                sVal = (string)this.gridPOItems[this.gridPOItems.CurrentCell.RowNumber, this.gridPOItems.CurrentCell.ColumnNumber];
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }

            //Dealing with storage locations
            if (this.bStorageLocation)
            {
                //Only the following are valid input fields
                if (this.gridPOItems.CurrentCell.ColumnNumber != RECEIVE_COLUMN &&
                    this.gridPOItems.CurrentCell.ColumnNumber != SLOC_COLUMN &&
                    this.gridPOItems.CurrentCell.ColumnNumber != PRINT_LABELS_COLUMN &&
                    this.gridPOItems.CurrentCell.ColumnNumber != DESCR_COLUMN)
                {
                    this.txtEdit.Visible = false;
                    this.comboSloc.Visible = false;
                    return;
                }
            }
            //Check the field clicked on is a valid input field
            if ((this.gridPOItems.CurrentCell.ColumnNumber == RECEIVE_COLUMN && sVal == ALREADY_COMPLETE)
                || ((this.gridPOItems.CurrentCell.ColumnNumber == SLOC_COLUMN && this.bStorageLocation) && sVal == STORAGE_LOCATION_NOT_APPLICABLE)
                || ((this.gridPOItems.CurrentCell.ColumnNumber == PRINT_LABELS_COLUMN && this.bPrintLabels) && sVal == PRINTING_NOT_APPLICABLE))
            {
                this.txtEdit.Visible = false;
                this.comboSloc.Visible = false;
                return;
            }

            try
            {
                this.currentCell = this.gridPOItems.CurrentCell;
                // Get click event position (screen) and convert to grid position
//               Point pt = this.gridPOItems.PointToClient(Control.MousePosition);
                // Get information about click position (type, row/col)
//                DataGrid.HitTestInfo hti = this.gridPOItems.HitTest(pt.X, pt.Y);
                // If we are not in editing mode and currentCell is the one clicked onto,
                // edit its contents
                //if (hti.Row == currentCell.RowNumber && hti.Column == currentCell.ColumnNumber ){

                // Make sure the cell we want to edit is visible
                this.EnsureRowVisible(this.gridPOItems, this.currentCell.RowNumber);
                // Resize and reposition TextBox to match current cell bounds
     
                Rectangle rc = this.gridPOItems.GetCellBounds(this.gridPOItems.CurrentCell.RowNumber,this.gridPOItems.CurrentCell.ColumnNumber);
                
                if (this.currentCell.ColumnNumber == RECEIVE_COLUMN
                    || (this.bPrintLabels && this.currentCell.ColumnNumber == PRINT_LABELS_COLUMN))
                {
                    this.txtEdit.Bounds = this.RectangleToClient(this.gridPOItems.RectangleToScreen(rc));
                    this.txtEdit.Location = new Point(rc.Location.X, (this.gridPOItems.Location.Y + rc.Location.Y));

                    // Bring the focus to it
                    this.txtEdit.Focus();
                    //Adjust its value to match current cell value
                    this.txtEdit.Text = this.gridPOItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber].ToString();
                    // If the value is zero, show a blank
                    if (this.txtEdit.Text.CompareTo("0") == 0)
                    {
                        this.txtEdit.Text = "";
                    }
                    // Finally, show the textBox
                    this.txtEdit.Visible = true;
                    this.comboSloc.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == SLOC_COLUMN)
                {
                    this.BuildSLocCombo();
                    this.comboSloc.Bounds = this.RectangleToClient(this.gridPOItems.RectangleToScreen(rc));

                    this.comboSloc.Location = new Point(rc.Location.X, (this.gridPOItems.Location.Y + rc.Location.Y));
                    
                    
                    // Bring the focus to it
                    this.comboSloc.Focus();
                    //Adjust its value to match current cell value
                    this.comboSloc.Text = this.gridPOItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber].ToString();
                    // Finally, show the textBox
                    this.comboSloc.Visible = true;
                    this.txtEdit.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == DESCR_COLUMN)
                {
                    // Show the PO Item long text if it exists.
                    string sLongText = "";
                    foreach (DataRow oTextRow in this.oPOItemsText.Rows)
                    {
                        if (oTextRow["ebelp"].ToString().CompareTo(this.gridPOItems[this.currentCell.RowNumber, EBELP_COLUMN].ToString()) == 0)
                        {
                            sLongText += oTextRow["tdline"].ToString() + "\n";
                        }
                    }
                    if (sLongText.CompareTo("") != 0)
                    {
                        MessageBox.Show(sLongText, "Material PO Item text");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, frmStart.MESSAGE_BOX_TITLE);
            }
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
        private void BuildGrid()
        {
            // Create data set
            this.ds = new DataSet("Dataset");
            // Add a table

            //Set up PO items data table
            this.oPOItems = this.ds.Tables.Add("POItems");
            //Description
            this.oPOItems.Columns.Add("descr", typeof(string));
            //Qty to receive
            this.oPOItems.Columns.Add("receive", typeof(string));
            //Qty of labels to print
            if (this.bPrintLabels) this.oPOItems.Columns.Add("print", typeof(string));
            //Storage location
            if (this.bStorageLocation) this.oPOItems.Columns.Add("lgort", typeof(string));
            //Ordered qty
            this.oPOItems.Columns.Add("order", typeof(string));
            //Qty received
            this.oPOItems.Columns.Add("recvd", typeof(string));
            //PO item
            this.oPOItems.Columns.Add("ebelp", typeof(string));
            //Serial number profile
            this.oPOItems.Columns.Add("sernr", typeof(string));
            //Qty outstanding
            this.oPOItems.Columns.Add("outstanding", typeof(string));

            //Set up PO Item Text data table
            this.oPOItemsText = this.ds.Tables.Add("POItemsText");
            this.oPOItemsText.Columns.Add("ebelp", typeof(string));
            this.oPOItemsText.Columns.Add("seq", typeof(string));
            this.oPOItemsText.Columns.Add("tdline", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "POItems";
            //Set up column widths and headers etc.
            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Item";
            cs.MappingName = "descr";
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Receive";
            cs.MappingName = "receive"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            //Columns are dynamic- ie for some POs storage location will
            //not be required,print labels qty etc.
            if (this.bPrintLabels)
            {
                cs = new DataGridTextBoxColumn();
                cs.HeaderText = "Labels";
                cs.MappingName = "print"; // Data column name
                cs.Width = 50;
                ts.GridColumnStyles.Add(cs);
                OUTSTANDING_COLUMN = 7;
                SERNR_COLUMN = 6;
                EBELP_COLUMN = 5;
                PRINT_LABELS_COLUMN = 2;
            }
            else
            {
                OUTSTANDING_COLUMN = 6;
                SERNR_COLUMN = 5;
                EBELP_COLUMN = 4;
                PRINT_LABELS_COLUMN = -1;
            }
            if (this.bStorageLocation)
            {
                cs = new DataGridTextBoxColumn();
                cs.HeaderText = "S Loc";
                cs.MappingName = "lgort"; // Data column name
                cs.Width = 50;
                ts.GridColumnStyles.Add(cs);
                OUTSTANDING_COLUMN++;
                SERNR_COLUMN++;
                EBELP_COLUMN++;
                if (this.bPrintLabels) SLOC_COLUMN = 3;
                else SLOC_COLUMN = 2;
            }
            else { SLOC_COLUMN = -1; }

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Order";
            cs.MappingName = "order"; // Data column name
            cs.Width = 50;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Rcvd";
            cs.MappingName = "recvd"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "ebelp"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "sernr"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "outstanding"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            this.gridPOItems.TableStyles.Add(ts);
            this.gridPOItems.DataSource = this.oPOItems;


            // Get the grid scrollbars
            this.vsb = (VScrollBar)this.gridPOItems.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.gridPOItems);
            this.hsb = (HScrollBar)gridPOItems.GetType().GetField("m_sbHorz", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.gridPOItems);
            this.hsb.ValueChanged += new System.EventHandler(this.POScroll_Click);
            this.vsb.ValueChanged += new System.EventHandler(this.POScroll_Click);
        }

        private void POScroll_Click(object sender, System.EventArgs e)
        {
            this.txtEdit.Visible = false;
            this.comboSloc.Visible = false;
        }
        private void txtEdit_LostFocus(object sender, System.EventArgs e)
        {

        }
        private void comboSloc_LostFocus(object sender, System.EventArgs e)
        {
            this.oPOItems.Rows[this.currentCell.RowNumber][SLOC_COLUMN] = this.comboSloc.Text;
        }
        #endregion
        #region Talk to SAP
        /// <summary>
        /// SOAP call to NISAPWIRESS which in turns gets the data for the PO from SAP via SOAP RFC
        /// See PMWebServices to see where the call is made and the  results returned as XML here
        /// </summary>
        private void  GetPOFromSAP()
        {
            string POXML = "";
            XmlDocument oXML = new XmlDocument();  //Results from call passed as XML
            XmlNodeList oItems;
            XmlNodeList oLongText;
            DataRow oTableRow;
            int i = 0;
            string sAccountTy = "";					//Account type - determines whether or not storage location required
            bool bBuildGrid = false;

            //Refresh Current
            this.bChanges = false;
            this.oPOItems.Rows.Clear();
            this.oPOItemsText.Rows.Clear();
            this.txtEdit.Text = "";
            this.SerialNumberStore = "<serial></serial>";
            this.txtEdit.Visible = false;
            this.comboSloc.Items.Clear();
            this.comboSloc.Visible = false;
            this.bSernr = false;
            this.SernrXML = "<sernr>";

            if (this.txtPO.Text == "")
            {
                MessageBox.Show("Please enter a PO number");
                return;
            }

            //Show progress bar
//            this.statusBar1.Visible = false;
//            this.pbGetPO.Visible = true;
//            this.pbGetPO.Value = 50;
            this.lblCurrentPO.Text = "Retrieving PO data from SAP...";
            this.lblCurrentPO.Update();
            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                this.txtPO.Text = this.txtPO.Text.ToUpper();
                //Try call to SAP- retry twice if fail
                for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                {
                    try
                    {
                        POXML = this.oSAPGateway.GetPOData(this.txtPO.Text);
                        break;
                    }
                    catch (Exception ex)
                    {
                        //Connection - give message
                        if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                            frmStart.HandleException(ex, false);
                        else this.RefreshSAPGateway();
                    }
                }

                Cursor.Current = Cursors.Default;
                oXML.LoadXml(POXML);
                //Get the item XML
                oItems = oXML.GetElementsByTagName("item");
                this.xmlSloc = oXML.GetElementsByTagName("lgort");
                //Storage location needs to be added to the grid?
                if (this.xmlSloc.Count > 0)
                {
                    if (!this.bStorageLocation)
                    {
                        this.bStorageLocation = true;
                        bBuildGrid = true;
                    }
                }
                else
                {
                    this.bStorageLocation = false;
                    bBuildGrid = true;
                }
                //PO type - determines whether print labels are required
                if (oXML.GetElementsByTagName("bsart").Item(0).InnerText.Trim() == PRODUCTION_PO)
                {
                    if (!this.bPrintLabels) bBuildGrid = true;
                    this.bPrintLabels = true;
                }
                else
                {
                    if (this.bPrintLabels) bBuildGrid = true;
                    this.bPrintLabels = false;
                }

                //Refresh of grid build required if different column format
                if (bBuildGrid)
                {
                    this.gridPOItems.TableStyles.RemoveAt(0);
                    this.BuildGrid();
                }

                //Store an array of the default quantities to receive
                if (oItems.Count > 0)
                {
                    this.aDefaultQty = new string[oItems.Count];
                }

                //Build item table
                foreach (XmlElement oNode in oItems)
                {
                    this.aDefaultQty[i] = oNode.GetAttribute("outstand").ToString().Trim();
                    i++;
                    oTableRow = this.oPOItems.NewRow();

                    //Description
                    oTableRow["descr"] = oNode.GetAttribute("descr").ToString();
                    //Order qty
                    oTableRow["order"] = oNode.GetAttribute("order").ToString() + " " + oNode.GetAttribute("uom").ToString();
                    //Storage location
                    if (bStorageLocation) oTableRow["lgort"] = oNode.GetAttribute("lgort").ToString();
                    //Already received
                    oTableRow["recvd"] = oNode.GetAttribute("recvd").ToString();
                    //PO item
                    oTableRow["ebelp"] = oNode.GetAttribute("ebelp").ToString();
                    //Serial number
                    oTableRow["sernr"] = oNode.GetAttribute("sernr").ToString();
                    //Qty outstanding
                    oTableRow["outstanding"] = oNode.GetAttribute("outstand").ToString();
                    //Print labels and already complete indicator
                    if (double.Parse(oNode.GetAttribute("receive").ToString()) == 0)
                    {
                        oTableRow["receive"] = ALREADY_COMPLETE;
                        if (this.bPrintLabels) oTableRow["print"] = PRINTING_NOT_APPLICABLE;
                    }
                    else
                    {
                        oTableRow["receive"] = oNode.GetAttribute("outstand").ToString().Trim();
                        if (this.bPrintLabels) oTableRow["print"] = oTableRow["receive"];
                    }

                    //Storage location combo required for at least one item?
                    if (this.bStorageLocation)
                    {
                        sAccountTy = oNode.GetAttribute("knttp").ToString().Trim();
                        if (sAccountTy != "")
                        {
                            oTableRow["lgort"] = STORAGE_LOCATION_NOT_APPLICABLE;
                        }
                    }
                    this.oPOItems.Rows.Add(oTableRow);

                    //Store details of items with serial numbers in an xml string
                    if (oNode.GetAttribute("sernr").ToString().Trim() != ""
                        && double.Parse(oNode.GetAttribute("receive").ToString()) > 0)
                    {
                        this.bSernr = true;
                        this.SernrXML += "<item";
                        this.SernrXML += " descr='" + oNode.GetAttribute("descr").ToString() + "' ";
                        this.SernrXML += " ebelp='" + oNode.GetAttribute("ebelp").ToString() + "' ";
                        this.SernrXML += " griditem='" + i + "' ";
                        this.SernrXML += "></item>";
                    }

                    //Store any long text for the item.
                    oLongText = oNode.GetElementsByTagName("longtext");
                    foreach (XmlElement oTextLine in oLongText)
                    {
                        DataRow oTextRow = this.oPOItemsText.NewRow();
                        oTextRow["ebelp"] = oNode.GetAttribute("ebelp").ToString();
                        oTextRow["seq"] = oTextLine.GetAttribute("seq").ToString();
                        oTextRow["tdline"] = oTextLine.InnerText;
                        this.oPOItemsText.Rows.Add(oTextRow);
                    }
                }
                this.SernrXML += "</sernr>";
                //Remove messages tab
                if (this.tabControl1.TabPages.Count > 2) this.tabControl1.TabPages.RemoveAt(2);
                //Add serial numbers tab if serial numbers are required
                if (this.bSernr) this.AddSernrTab();

                //Fill out header text fields
                if (oItems.Count > 0)
                {
                    this.txtSupplier.Text = oXML.GetElementsByTagName("supp").Item(0).InnerText;
                    this.txtRequisitioner.Text = oXML.GetElementsByTagName("fname").Item(0).InnerText
                        + " " + oXML.GetElementsByTagName("lname").Item(0).InnerText;
                    this.txtDelDate.Text = oXML.GetElementsByTagName("bedat").Item(0).InnerText.Substring(8, 2);
                    this.txtDelDate.Text += "." + oXML.GetElementsByTagName("bedat").Item(0).InnerText.Substring(5, 2);
                    this.txtDelDate.Text += "." + oXML.GetElementsByTagName("bedat").Item(0).InnerText.Substring(0, 4);

                    this.lblCurrentPO.Text = "Current Order is " + this.txtPO.Text + ".\n" + "There are " + oItems.Count + " items." + "\nPress the PO Items tab to view the items and post goods receipt.";
                }
                else
                {
                    //Nothing found
                    this.lblCurrentPO.Text = "No Purchase Order selected";
                    this.txtSupplier.Text = "";
                    this.txtRequisitioner.Text = "";
                    this.txtDelDate.Text = "";
                    MessageBox.Show("No purchase order found.", frmStart.MESSAGE_BOX_TITLE);
                }
            }
            catch (Exception ex) { MessageBox.Show(ex.Message, frmStart.MESSAGE_BOX_TITLE); }
            finally
            {
//                this.pbGetPO.Value = 100;
//                this.pbGetPO.Visible = false;
//               this.statusBar1.Visible = true;
//                this.statusBar1.Visible = false;
                Cursor.Current = Cursors.Default;
            }
        }

        /// <summary>
        /// Post GR on SAP
        /// </summary>
        private void PostGoodsReceipt()
        {
            string sGRXml = "<gr>";				//XML string with GR details as parameter in SOAP call
            string sEbelp = "";					//PO item number
            string sMessage = "";				//message from post
            string sLoginError = "";			//login error message
            bool bDoSomething = false;			//post is required?
            double dReceive;					//qty received for a PO item
            string sLgort = "";					//storage location
            string sPrintXML = "<print>";		//XML string with label print details as parameter in SOAP call
            string sPrintMessage = "";

            //Get SAP Login details
            this.frmParent.UpdateLastDidSomethingAt();
            if (this.frmParent.SAPUname == "" || this.frmParent.SAPPword == "")
            {
                if (!this.frmParent.GetSAPConnection(ref sLoginError))
                {
                    MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
                    return;
                }
            }

            sGRXml += "<ebeln>" + this.txtPO.Text + "</ebeln>";			//PO number
            sGRXml += "<dnote>" + this.txtDelNote.Text + "</dnote>";		//Delivery note
            sGRXml += "<sdoc>" + this.txtScanDoc.Text + "</sdoc>";		//Scanning  doc
            sGRXml += "<mtype>" + MOVEMENT_TYPE + "</mtype>";		//Movement type
            sGRXml += "<i>";
            //Iterate through the items
            foreach (DataRow rowItems in this.oPOItems.Rows)
            {
                //Get the qty to receive
                dReceive = 0;
                if (((string)rowItems["receive"]) != ALREADY_COMPLETE)
                {
                    try
                    {
                        dReceive = Double.Parse(((string)rowItems["receive"]));
                    }
                    catch (Exception ex)
                    {
                        frmStart.HandleException(ex, true);
                        dReceive = 0;
                    }
                }

                if (dReceive > 0)
                {
                    bDoSomething = true;
                    sEbelp = ((string)rowItems["ebelp"]);
                    if (this.bStorageLocation) sLgort = (string)rowItems["lgort"];
                    else sLgort = "";
                    if (sLgort == STORAGE_LOCATION_NOT_APPLICABLE) sLgort = "";
                    sGRXml += "<item n='" + sEbelp + "' qty='" + dReceive + "' sloc='" + sLgort + "'>";
                    sGRXml += "</item>";
                    //Print details XML as string (i.e. how many labels)
                    if (this.bPrintLabels && ((string)rowItems["print"]) != PRINTING_NOT_APPLICABLE)
                    {
                        sPrintXML += "<p n='" + sEbelp + "' qty='" + ((string)rowItems["print"]) + "'/>";
                    }
                }
            }
            sGRXml += "</i>";
            //Build serial item data as XML string
            if (this.oSernr != null)
            {
                foreach (DataRow rowSerial in this.oSernr.Rows)
                {
                    sGRXml += "<s n='" + ((string)rowSerial["ebelp"]) + "'>" + rowSerial["sernr"] + "</s>";
                }
            }
            sGRXml += "</gr>";
            sPrintXML += "</print>";
            if (bDoSomething)
            {
                try
                {
                    Cursor.Current = Cursors.WaitCursor;
                    Cursor.Show();
                    //retry up to 3 times
                    for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                    {
                        try
                        {
                            //POST
                            bool bOK = this.oSAPGateway.PostGoodsReceipt(sGRXml, sPrintXML, this.frmParent.SAPUname, this.frmParent.SAPPword, out sMessage, out sPrintMessage);
                            if (!bOK) MessageBox.Show(sMessage, frmStart.MESSAGE_BOX_TITLE);
                            else
                            {
                                MessageBox.Show("Goods receipt has been posted successfully on SAP.", frmStart.MESSAGE_BOX_TITLE);
                                if (sPrintMessage.Trim() != "") MessageBox.Show(sPrintMessage, frmStart.MESSAGE_BOX_TITLE);
                                this.RefreshScreens();
                            }
                            break;
                        }
                        catch (Exception ex)
                        {
                            //Message if connection error
                            if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                                frmStart.HandleException(ex, false);
                            else this.RefreshSAPGateway();
                        }
                    }
                }
                catch (Exception Ex)
                {
                    MessageBox.Show(Ex.Message, frmStart.MESSAGE_BOX_TITLE);
                }
                finally
                {
                    Cursor.Current = Cursors.Default;
                }
            }
            else MessageBox.Show("No quantities have been entered for receipt", frmStart.MESSAGE_BOX_TITLE);
        }
        /// <summary>
        /// Refresh global web services variable
        /// </summary>
        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }
        #endregion
        #region Menu
        private void mnuiSearch_Click(object sender, System.EventArgs e)
        {
            this.LaunchSearch();
        }
        private void mnuiExit_Click(object sender, System.EventArgs e)
        {
            this.Close();
        }

        private void mnuiClear_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            this.txtPO.Text = "";
            this.lblCurrentPO.Text = "No Purchase Order selected";
            this.txtDelDate.Text = "";
            this.txtDelNote.Text = "";
            this.txtScanDoc.Text = "";
            this.txtSupplier.Text = "";
            this.txtRequisitioner.Text = "";
            this.oPOItems.Clear();
            if (this.oSernr != null) this.oSernr.Clear();
        }

        private void mnuiAllTo0_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            foreach (DataRow rowItems in this.oPOItems.Rows)
            {
                if (((string)rowItems["receive"]) != "DONE") rowItems["receive"] = "0";
            }
        }

        private void mnuiLogon_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            string sLoginError = "";
            if (!this.frmParent.GetSAPConnection(ref sLoginError))
            {
                MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
                this.mnuiLogoff.Enabled = false;
            }
            else
            {
                this.mnuiLogoff.Enabled = true;
                this.mnuiLogon.Enabled = false;
            }
        }

        private void mnuiLogoff_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            this.frmParent.LogoffSAP();
            this.mnuiLogon.Enabled = true;
            this.mnuiLogoff.Enabled = false;
        }

        private void mnuiResetDefault_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            int i = 0;
            foreach (DataRow rowItems in this.oPOItems.Rows)
            {
                if (this.aDefaultQty[i] == "0")
                {
                    rowItems["receive"] = "DONE";
                }
                else rowItems["receive"] = this.aDefaultQty[i];
                i++;
            }
        }

        private void mnuiClearSerial_Click(object sender, System.EventArgs e)
        {
            if (this.oSernr != null)
            {
                this.frmParent.UpdateLastDidSomethingAt();
                foreach (DataRow rowItems in this.oSernr.Rows)
                {
                    rowItems["sernr"] = "";
                }
                this.txtSernrEdit.Text = "";
            }
        }
        private void mnuiScan_Click(object sender, System.EventArgs e)
        {
            this.ScanMode = 'S';
            this.mnuiScan.Enabled = false;
            this.mnuiType.Enabled = true;
        }

        private void mnuiType_Click(object sender, System.EventArgs e)
        {
            this.ScanMode = 'T';
            this.mnuiScan.Enabled = true;
            this.mnuiType.Enabled = false;
        }
        #endregion
        #region General
        /// <summary>
        /// Clear down fields e.g. before a new PO is selected
        /// </summary>
        private void RefreshScreens()
        {
            this.bChanges = false;
            this.oPOItems.Clear();
            if (this.oSernr != null) this.oSernr.Clear();
            if (this.tabControl1.TabPages.Count > 2) this.tabControl1.TabPages.RemoveAt(2);
            this.txtScanDoc.Text = "";
            this.txtRequisitioner.Text = "";
            this.txtSupplier.Text = "";
            this.txtDelDate.Text = "";
            this.txtDelNote.Text = "";
            this.tabControl1.SelectedIndex = 0;
            this.comboSloc.Items.Clear();
            this.comboSloc.Visible = false;
        }
        /// <summary>
        /// Build the combo list for storage location - the allowable values in the
        /// storage location list for a particular material
        /// </summary>
        private void BuildSLocCombo()
        {
            string sEbelp = (string)this.oPOItems.Rows[this.currentCell.RowNumber][EBELP_COLUMN];
            sEbelp.Trim();

            this.comboSloc.Items.Clear();
            this.comboSloc.Items.Add(" ");
            foreach (XmlElement oNode in this.xmlSloc)
            {
                if (oNode.GetAttribute("ebelp").Trim() == sEbelp)
                {
                    this.comboSloc.Items.Add(oNode.InnerText);
                }
            }
        }
        /// <summary>
        /// Check storage location is entered where required
        /// </summary>
        /// <returns></returns>
        private bool CheckStorageLocation()
        {
            string sSloc = "";

            if (!this.bStorageLocation) return true;

            foreach (DataRow oRow in this.oPOItems.Rows)
            {
                if (oRow["receive"].ToString() != "0" && oRow["receive"].ToString() != "DONE")
                {
                    sSloc = (string)oRow["lgort"];
                    sSloc.Trim();
                    if (sSloc == "")
                    {
                        MessageBox.Show("Please enter all storage locations where applicable.", frmStart.MESSAGE_BOX_TITLE);
                        return false;
                    }
                }
            }
            return true;
        }
        /// <summary>
        /// launch the PO search screen
        /// </summary>
        private void LaunchSearch()
        {
            this.frmParent.UpdateLastDidSomethingAt();
            frmSearch frmPOSearch = new frmSearch(this);
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            frmPOSearch.ShowDialog();
            Cursor.Current = Cursors.Default;
        }
        /// <summary>
        /// handle text input for qty, print labels
        /// </summary>
        private void HandleTextInput()
        {
            double dQty = 0;
            double dOutstanding = 0;

            if (this.oPOItems.Rows.Count == 0) return;

            try
            {
                dOutstanding = Double.Parse(((string)this.oPOItems.Rows[this.currentCell.RowNumber][OUTSTANDING_COLUMN]));
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, frmStart.MESSAGE_BOX_TITLE);
            }

            try
            {
                if (this.txtEdit.Text.Trim() != "")
                {
                    if (this.currentCell.ColumnNumber == RECEIVE_COLUMN) dQty = Double.Parse(this.txtEdit.Text);
                    else dQty = int.Parse(this.txtEdit.Text);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Please enter a valid number  \n" + ex.Message, frmStart.MESSAGE_BOX_TITLE);
                this.txtEdit.Text = "0";
            }

            if (this.currentCell.ColumnNumber == RECEIVE_COLUMN)
            {
                if (dQty > dOutstanding)
                {
                    MessageBox.Show("You cannot receive more than the outstanding quantity.", frmStart.MESSAGE_BOX_TITLE);
                    this.txtEdit.Text = ((string)this.oPOItems.Rows[this.currentCell.RowNumber][OUTSTANDING_COLUMN]).Trim();
                }

                if (this.txtEdit.Text.Trim() == "")
                {
                    this.txtEdit.Text = "0";
                }
                this.oPOItems.Rows[this.currentCell.RowNumber][RECEIVE_COLUMN] = this.txtEdit.Text;
            }
            else if (this.currentCell.ColumnNumber == PRINT_LABELS_COLUMN && this.bPrintLabels)
            {
                if (this.txtEdit.Text.Trim() == "")
                {
                    this.txtEdit.Text = "0";
                }
                this.oPOItems.Rows[this.currentCell.RowNumber][PRINT_LABELS_COLUMN] = this.txtEdit.Text;
            }

            string sSernr = (string)this.gridPOItems[this.currentCell.RowNumber, SERNR_COLUMN];
            if (sSernr.Trim() != "")
            {
                this.StoreCurrentSernr();
                this.bRefreshSernr = true;
            }
        }
        #endregion
        #region Handle Serial Numbers
        private void txtSernrEdit_LostFocus(object sender, System.EventArgs e)
        {
            this.oSernr.Rows[this.currentSernrCell.RowNumber][this.currentSernrCell.ColumnNumber] = this.txtSernrEdit.Text.Replace(frmStart.BARCODE_END, "");
            this.frmParent.UpdateLastDidSomethingAt();
        }

        private void gridSernr_Click(object sender, System.EventArgs e)
        {
            if (this.gridSernr.CurrentCell.ColumnNumber != 2)
            {
                this.txtSernrEdit.Visible = false;
                return;
            }

            try
            {
                this.currentSernrCell = this.gridSernr.CurrentCell;

                // Get click event position (screen) and convert to grid position
                Point pt = this.gridSernr.PointToClient(Control.MousePosition);

                // If we are not in editing mode and currentCell is the one clicked onto,
                // edit its contents

                // Make sure the cell we want to edit is visible
                this.EnsureRowVisible(this.gridSernr, this.currentSernrCell.RowNumber);
                // Resize and reposition TextBox to match current cell bounds
                Rectangle rc = this.gridSernr.GetCellBounds(this.currentSernrCell.RowNumber, this.currentSernrCell.ColumnNumber);
                this.txtSernrEdit.Bounds = RectangleToClient(this.gridSernr.RectangleToScreen(rc));
                this.txtSernrEdit.Location = new Point(rc.Location.X, (this.gridSernr.Location.Y + rc.Location.Y));

                // Bring the focus to it
                this.txtSernrEdit.Focus();
                //Adjust its value to match current cell value
                this.bStickOnLine = true;
                this.txtSernrEdit.Text = this.gridSernr[this.currentSernrCell.RowNumber, this.currentSernrCell.ColumnNumber].ToString();
                // Finally, show the textBox
                this.bStickOnLine = false;
                this.txtSernrEdit.Visible = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Store the serial number data from the grid and XML string
        /// </summary>
        private void StoreCurrentSernr()
        {
            object[] aVal;
            string sSernr = "";
            string sItem = "";
            string sPrevItem = "";
            bool bClose = false;
            this.SerialNumberStore = "<serial>";

            foreach (DataRow oRow in this.oSernr.Rows)
            {
                aVal = oRow.ItemArray;
                sSernr = (string)aVal[2];

                if (sSernr.Trim().ToString() != "")
                {
                    sItem = (string)aVal[0];
                    if (sItem != sPrevItem)
                    {
                        if (bClose) this.SerialNumberStore += "</i" + sPrevItem + ">";
                        this.SerialNumberStore += "<i" + sItem + ">";
                        this.SerialNumberStore += "<s>" + sSernr + "</s>";
                        bClose = true;
                    }
                    else this.SerialNumberStore += "<s>" + sSernr + "</s>";
                    sPrevItem = sItem;
                }
            }

            if (bClose) this.SerialNumberStore += "</i" + sPrevItem + ">";
            this.SerialNumberStore += "</serial>";
        }
        /// <summary>
        /// Dynamically add the serial numbers tab if required
        /// </summary>
        private void AddSernrTab()
        {
            TabPage tabPage = new TabPage();

            tabPage.Text = "Serial Numbers";
            this.tabControl1.TabPages.Add(tabPage);
            this.gridSernr = new DataGrid();
            this.gridSernr.Top = 2;
            this.gridSernr.Height = tabPage.Height - 4;
            this.gridSernr.Left = 2;
            this.gridSernr.Width = tabPage.Width - 4;
            this.gridSernr.Click += new System.EventHandler(this.gridSernr_Click);
            this.txtSernrEdit = new TextBox();
            this.txtSernrEdit.LostFocus += new System.EventHandler(this.txtSernrEdit_LostFocus);
            this.txtSernrEdit.TextChanged += new System.EventHandler(this.txtSernrEdit_TextChanged);
            this.txtSernrEdit.Visible = false;
            this.txtSernrEdit.Font = gridSernr.Font;
            this.txtSernrEdit.AcceptsReturn = true;
            this.txtSernrEdit.AcceptsTab = true;
            tabPage.Controls.Add(this.txtSernrEdit);
            tabPage.Controls.Add(this.gridSernr);
            this.vsb2 = (VScrollBar)this.gridSernr.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.gridSernr);
            this.hsb2 = (HScrollBar)this.gridSernr.GetType().GetField("m_sbHorz", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.gridSernr);
            this.hsb2.ValueChanged += new System.EventHandler(this.sernrScroll_Click);
            this.vsb2.ValueChanged += new System.EventHandler(this.sernrScroll_Click);

            DataGridTableStyle ts;

            // Add a table
            if (!this.ds.Tables.Contains("Sernr"))
            {
                this.oSernr = this.ds.Tables.Add("Sernr");
                this.oSernr.Columns.Add("ebelp", typeof(string));
                this.oSernr.Columns.Add("descr", typeof(string));
                this.oSernr.Columns.Add("sernr", typeof(string));
            }
            ts = new DataGridTableStyle();

            ts.MappingName = "Sernr";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "ebelp"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Item";
            cs.MappingName = "descr";
            cs.Width = 100;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Serial";
            cs.MappingName = "sernr"; // Data column name
            cs.Width = 100;
            ts.GridColumnStyles.Add(cs);

            this.gridSernr.TableStyles.Add(ts);
            this.RefreshSernrTab();
            this.gridSernr.DataSource = this.oSernr;
        }
        /// <summary>
        /// Refresh the serial number grid - is redrawn as the user changes the received quantities
        /// for serialised items - i.e. a different number of serial numbers are required
        /// </summary>
        private void RefreshSernrTab()
        {
            this.bRefreshSernr = false;
            XmlDocument oXML = new XmlDocument();
            XmlDocument oSernrXML = new XmlDocument();
            XmlNodeList oItems;
            XmlNodeList oCurrentSerial;
            XmlNodeList oCurrentItem;
            DataRow oTableRow;
            double dQty;
            string sPrevItem = "";
            string sItem = "";
            //Clear serial grid
            this.oSernr.Clear();
            //Serialised items -details
            oXML.LoadXml(this.SernrXML);
            //Current serial numbers that have been enetered
            oSernrXML.LoadXml(this.SerialNumberStore);

            oItems = oXML.GetElementsByTagName("item");
            //Go through items, get qty, outout serial numbers that have been enetered and then
            //add blanks for those still required
            foreach (XmlElement oNode in oItems)
            {
                sItem = oNode.GetAttribute("ebelp").ToString();
                int i = int.Parse(oNode.GetAttribute("griditem").ToString());
                try
                {
                    dQty = Double.Parse(this.gridPOItems[(i - 1), 1].ToString());
                }
                catch (Exception ex)
                {
                    dQty = 0;
                    frmStart.HandleException(ex, true);
                }

                oCurrentItem = oSernrXML.GetElementsByTagName("i" + sItem);
                if (oCurrentItem.Count > 0) oCurrentSerial = oCurrentItem.Item(0).ChildNodes;
                else oCurrentSerial = null;
                for (int j = 1; j <= dQty; j++)
                {
                    oTableRow = this.oSernr.NewRow();
                    oTableRow[0] = sItem;
                    oTableRow[1] = oNode.GetAttribute("descr").ToString();
                    if (oCurrentSerial != null && oCurrentSerial.Count > (j - 1))
                    {
                        //Put in existing serial number if already entered
                        oTableRow[2] = oCurrentSerial.Item(j - 1).InnerText;
                    }
                    else oTableRow[2] = "";
                    this.oSernr.Rows.Add(oTableRow);
                }
                sPrevItem = oNode.GetAttribute("ebelp").ToString();
            }
        }
        /// <summary>
        /// Check All items that need serial numbers have them
        /// </summary>
        /// <returns></returns>
        private bool CheckSerialNumbers()
        {
            string sSernr = "";

            if (!bSernr) return true;

            foreach (DataRow oRow in this.oSernr.Rows)
            {
                sSernr = (string)oRow["sernr"];
                if (sSernr.Trim().ToString() == "")
                {
                    MessageBox.Show("Serial numbers must be entered for all items", frmStart.MESSAGE_BOX_TITLE);
                    return false;
                }
                int iCount = ((int)this.oSernr.Compute("COUNT(sernr)", "sernr='" + ((string)oRow["sernr"]) + "'"));
                if (iCount > 1)
                {
                    MessageBox.Show("Serial numbers must be unique. You have used " + sSernr + " " + iCount + " times.", frmStart.MESSAGE_BOX_TITLE);
                    return false;
                }
            }
            return true;
        }

        private void sernrScroll_Click(object sender, System.EventArgs e)
        {
            this.txtSernrEdit.Visible = false;
        }
        private void txtSernrEdit_TextChanged(object sender, System.EventArgs e)
        {
            if (this.ScanMode == 'S' && this.txtSernrEdit.Text != ""
                && !this.bStickOnLine && this.txtSernrEdit.Text.EndsWith(frmStart.BARCODE_END))
            {
                //jump to next
                this.oSernr.Rows[this.currentSernrCell.RowNumber][this.currentSernrCell.ColumnNumber] = this.txtSernrEdit.Text.Replace(frmStart.BARCODE_END, "");
                this.frmParent.UpdateLastDidSomethingAt();
                if ((this.oSernr.Rows.Count - 1) > this.currentSernrCell.RowNumber)
                {
                    this.gridSernr.CurrentRowIndex += 1;
                    this.currentSernrCell.RowNumber += 1;
                    this.gridSernr_Click(sender, e);
                }
                else
                {
                    // We're staying in the text edit box, so remove the scan suffix.
                    this.txtSernrEdit.Text = this.txtSernrEdit.Text.Replace(frmStart.BARCODE_END, "");
                }
            }
        }
        #endregion

        private void statusBar1_ParentChanged(object sender, EventArgs e)
        {

        }

        private void gridPOItems_CurrentCellChanged(object sender, EventArgs e)
        {

        }

    }
}


