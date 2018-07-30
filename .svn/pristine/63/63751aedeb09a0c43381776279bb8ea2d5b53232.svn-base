using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Reflection;
using ce5b.SAPGateway;
using System.Net;
using System.Threading;
using System.IO;

namespace ce5b
{
    /// <summary>
    /// This is the form for goods movement in plant maintenance.
    /// The code on SAP is split into RFC functions modules - 
    /// Z_PM_GET_FNLOC_HIERARCHY
    /// Z_PM_FNLOC_SEARCH_WEB
    /// Z_PM_WO_GET_RECIPIENT_LIST
    /// Z_PM_FNLOC_STRUCTURE
    /// Z_PM_WORK_ORDER_GET
    /// Z_PM_MATERIAL_STORAGE_LOC_LIST
    /// Z_PM_GET_ACTIVITY_TYPES
    /// Z_PM_GET_EQUNR
    /// Z_PM_CREATE_EQUNR
    /// Z_PM_EQUNR_SERNR_VALIDATE
    /// Z_PM_GOODS_ISSUE
    /// Z_PM_CHECK_FNLOC
    /// Z_PM_GET_DEFAULT_FNLOCS
    /// Z_PM_WO_LOCK_CHECK
    /// Z_PM_STOR_LOC_CHECK
    /// The SOAP web services reside on the NISAPWIRELESS cluster in PMWebServices
    /// - there is basically a method that wraps up each SAP call (via SOAP)
    /// 
    /// Data is loaded into an editable grid (the complex bit is the fact that on the CF the
    /// grid is not editable - hence we have to overlay textboxes and dropdowns for the editable
    /// fields.
    ///
    /// Also note that the overhead on the client against a direct HTTP call was 25% which when the system was running
    /// slowly was unacceptable for time critical calls.
    /// Hence the SOAP calls are overridden with direct HTTP for the following functions:
    ///		
    ///		WOGetDetail		-- get the details for a work order
    ///		GoodsMovement	-- Post goods movement for work order components
    ///		CheckLogin		-- Check user name and password are valid
    /// </summary>
    public partial class frmPMGM : Form
    {

        # region Constants
        private struct Columns
        {
            public static int matnr = 0;
            public static int material = 1;
            public static int qty = 2;
            public static int uom = 4;
            public static int sloc = 3;
            public static int serial = 5;
            public static int equipment = 6;
            public static int functional_location = 7;
            public static int activity_type = 8;
            public static int matnr0 = 9;
            public static int sernp = 10;
            public static int item = 11;
            public static int repair = 12;            
        }
        public static string BARCODE_END = "*-";
        private const string GOODS_ISSUE = "261";
        private const string GOODS_RETURN = "262";
        private const string DEFAULT_STORAGE_LOCATION = "PL01";
        #endregion
        #region Form data
        private frmStart frmParent;												//Parent form
        private SAPGateway.POFunctions oSAPGateway = new POFunctions();			//Sap gateway SOAP proxy
        //private DateTimePicker DTCpicker;										//Date time control
        private string sRecipientXML = "";										//Possible recipients list as XML string		
        private string sPlant = "";												//Current plant
        private string[] aMaterials;											//Array of material numbers 
        private string sSLocXML = "<list></list>";								//Storage locations for materials - full list as XML
        private string sUOMXml = "<units></units>";								//UOMsfor materials - full list as XML
        private string sOrderType = "";											//PM order type
        private string sAufnr = "";												//Order number
        private string sPrevValue = "";
        private DataGridCell currentCell;										//Current cell on main grid
        private ArrayList clnNewEquipment = new ArrayList();					//Equipment numbers created in this session
        private ArrayList aUnames = new ArrayList();
        bool bChanges = false;
        private bool bStores = false;
        private bool bGoodsReturn = false;
        private bool bScanRecipient = false;
        #endregion
        # region Grid Variables
        private DataSet ds;
        private System.Data.DataTable oItems;
        private System.Data.DataTable oMessages;
        private VScrollBar vsb;
        private HScrollBar hsb;
        #endregion

        public frmPMGM()
        {
            #region Start Logger
            logger mylog = new logger();

            mylog.makelog("Starting PMGM");
            #endregion

            InitializeComponent();
            this.oSAPGateway.Url = frmStart.SERVICE_URL;

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

        }

        #region Main Events triggered on form
        private void frmPMGM_Load(object sender, System.EventArgs e)
        {
            string sError = "";
            if (this.bStores == true)
            {
                this.Text = "WO Stores";
            }
            else if (this.bGoodsReturn == true)
            {
                this.Text = "WO Return";
            }
            else
            {
                this.Text = "WO Issue";
            }

            //Setup the date time control
            /*
            DTCpicker = new DateTimePicker();
            DTCpicker.Location = this.txt.Location;
            DTCpicker.Size = this.txt.Size;
            DTCpicker.Value = DateTime.Today;
            txt.Parent.Controls.Add(DTCpicker);
            txt.Parent.Controls.Remove(this.txt);
             */
            dateTimePicker1.Value = DateTime.Today;

            //Build movement type combo
            this.comboMvtType.Items.Add("Goods Issue");
            this.comboMvtType.Items.Add("Goods Return");
            if (this.bGoodsReturn == true)
            {
                this.comboMvtType.SelectedIndex = 1;
            }
            else
            {
                this.comboMvtType.SelectedIndex = 0;
            }
            this.dgItems.Height = this.tbpItems.Height - 10 - this.cmdPost.Height - 40;
            this.dgItems.Width = this.tbpItems.Width - 2;

            //Set up the data grids
            BuildItemsGrid(false, false, false, false);
            BuildMessagesGrid();

            //Setup the overlay controls for the datagrids
            this.txtEdit.Font = this.dgItems.Font;
            this.comboActype.Font = this.dgItems.Font;
            this.comboSloc.Font = this.dgItems.Font;

            //Status - logged on status
            this.lblStatusBar.Text = this.frmParent.lblStatusBar.Text;
            this.lblSaving.Text = this.frmParent.lblStatusBar.Text;

            Cursor.Current = Cursors.Default;
            Cursor.Show();

            //Username/ Password are required
            if (this.frmParent.SAPUname == "" || this.frmParent.SAPPword == "")
            {
                if (!this.frmParent.GetSAPConnection(ref sError)) MessageBox.Show(sError, frmStart.MESSAGE_BOX_TITLE);
            }
            this.lblStatusBar.Text = this.frmParent.lblStatusBar.Text;
            if (this.frmParent.SAPPword != "" & this.frmParent.SAPUname != "")
            {

                this.mnuiLogoff.Enabled = true;
                this.mnuiLogon.Enabled = false;
            }
            else
            {
                this.frmParent.SAPUname = "";
                this.mnuiLogoff.Enabled = false;
                this.mnuiLogon.Enabled = true;
            }
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.cmdGetWO.BackColor = System.Drawing.Color.LightGreen;
            this.cmdPost.BackColor = System.Drawing.Color.LightGreen;

            //Place the recipents button
            this.cmdGetRecipients.Left = this.comboRecipient.Left;
            this.cmdGetRecipients.Top = this.comboRecipient.Top;
            this.cmdGetRecipients.Width = this.comboRecipient.Width;
            this.comboRecipient.Visible = false;

            //Place the recipient text
            this.txtRecipient.Left = this.comboRecipient.Left;
            this.txtRecipient.Top = this.comboRecipient.Top;
            this.txtRecipient.Width = this.comboRecipient.Width;
            this.txtRecipient.Height = this.comboRecipient.Height;
            this.txtRecipient.Visible = false;

            //Set the default goods recipient
            DefaultRecipient();

            this.txtWO.Focus();
        }

        private void cmdGetWO_Click(object sender, System.EventArgs e)
        {
            this.GetWOFromSAP(sender, e);
        }

        private void cmdGetRecipients_Click(object sender, System.EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            PopulateRecipientList();
            if (this.bScanRecipient == true)
            {
                this.txtRecipient.Enabled = true;
                this.txtRecipient.Visible = true;
                this.txtRecipient.Focus();
            }
            else
            {
                this.comboRecipient.Visible = true;
                this.comboRecipient.Focus();
            }
            this.cmdGetRecipients.Visible = false;
            this.Refresh();
            Cursor.Current = Cursors.Default;
        }

        private void tabControl1_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.txtEdit.Visible = false;
            this.comboActype.Visible = false;
            this.comboLookUp.Visible = false;
            this.comboSloc.Visible = false;
            this.comboUOM.Visible = false;
            this.frmParent.UpdateLastDidSomethingAt();
            if (this.tabControl1.SelectedIndex != 0 && this.bStores == true)
            {
                if (!this.ValidateRecipient())
                {
                    MessageBox.Show("Please enter a valid recipient", "Error");
                    this.tabControl1.SelectedIndex = 0;
                    this.txtRecipient.Focus();
                }
            }
            if (this.tabControl1.SelectedIndex != 1) this.mnuiItems.Enabled = false;
            else this.mnuiItems.Enabled = true;

            //this.DTCpicker.CloseCalendar();
        }

        private void frmPMGM_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            //Unsaved changes warning
            if (this.txtDocHeader.Text != "") this.bChanges = true;
            if (this.bChanges)
            {
                if (MessageBox.Show("Warning: unsaved changes will be lost.\nClick OK to exit.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel,
                    MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1) != DialogResult.OK)
                    e.Cancel = true;
                else this.oSAPGateway = null;
            }
        }

        private void comboSloc_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.bChanges = true;
            this.oItems.Rows[this.currentCell.RowNumber][this.currentCell.ColumnNumber] = this.comboSloc.Text;
        }

        private void comboActype_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.bChanges = true;
        }

        private void imgDeleteItem_Click(object sender, System.EventArgs e)
        {
            this.imgDeleteItem.Enabled = false;
            System.Drawing.Color clrImage = this.pnlImageHoldDeleteItem.BackColor;
            this.pnlImageHoldDeleteItem.BackColor = System.Drawing.Color.Black;
            this.pnlImageHoldDeleteItem.Refresh();
            this.mnuiDelete_Click(sender, e);
            this.pnlImageHoldDeleteItem.BackColor = clrImage;
            this.imgDeleteItem.Enabled = true;
        }
        #endregion
        #region Data grid
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
        /// <summary>
        /// Set up the columns on the items grid
        /// </summary>
        /// <param name="bSernr">Serial number flag</param>
        /// <param name="bEqunr">Equipment number flag</param>
        /// <param name="bFloc">Functional location flag</param>
        /// <param name="bActype">activity type flag</param>
        private void BuildItemsGrid(bool bSernr, bool bEqunr, bool bFloc, bool bActype)
        {
            // Create data set
            this.ds = new DataSet("Dataset");
            // Add a table
            if (this.dgItems.TableStyles.Count > 0) this.dgItems.TableStyles.RemoveAt(0);

            this.oItems = this.ds.Tables.Add("Items");
            this.oItems.Columns.Add("matnr", typeof(string));
            this.oItems.Columns.Add("descr", typeof(string));
            this.oItems.Columns.Add("qty", typeof(string));
            this.oItems.Columns.Add("sloc", typeof(string));
            this.oItems.Columns.Add("uom", typeof(string));
            this.oItems.Columns.Add("serial", typeof(string));
            this.oItems.Columns.Add("equip", typeof(string));
            this.oItems.Columns.Add("fnloc", typeof(string));
            this.oItems.Columns.Add("actype", typeof(string));
            this.oItems.Columns.Add("matnr0", typeof(string));
            this.oItems.Columns.Add("sernp", typeof(string));
            this.oItems.Columns.Add("item", typeof(string));
            this.oItems.Columns.Add("repair", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "Items";


            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Material";
            cs.MappingName = "matnr";
            cs.Width = 50;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Description";
            cs.MappingName = "descr";
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Qty";
            cs.MappingName = "qty"; // Data column name
            cs.Width = 40;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Stor Loc";
            cs.MappingName = "sloc"; // Data column name
            cs.Width = 50;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "UOM";
            cs.MappingName = "uom"; // Data column name
            cs.Width = 50;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Serial";
            cs.MappingName = "serial"; // Data column name
            if (bSernr) cs.Width = 80;
            else cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Equip.";
            cs.MappingName = "equip"; // Data column name
            if (bEqunr) cs.Width = 60;
            else cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Fn Loc";
            cs.MappingName = "fnloc"; // Data column name
            if (bFloc) cs.Width = 160;
            else cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Act Typ";
            cs.MappingName = "actype"; // Data column name
            if (bActype) cs.Width = 130;
            else cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "matnr0"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "sernp"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "item"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.MappingName = "repair"; // Data column name
            cs.Width = 0;
            ts.GridColumnStyles.Add(cs);

            this.dgItems.TableStyles.Add(ts);
            this.dgItems.DataSource = this.oItems;

            // Get the grid scrollbars
            this.vsb = (VScrollBar)this.dgItems.GetType().GetField("m_sbVert", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgItems);
            this.hsb = (HScrollBar)this.dgItems.GetType().GetField("m_sbHorz", BindingFlags.NonPublic | BindingFlags.GetField | BindingFlags.Instance).GetValue(this.dgItems);
            this.hsb.ValueChanged += new System.EventHandler(this.ItemsScroll_Click);
            this.vsb.ValueChanged += new System.EventHandler(this.ItemsScroll_Click);
        }

        private void BuildMessagesGrid()
        {
            // Create data set
            this.ds = new DataSet("Dataset");

            this.oMessages = this.ds.Tables.Add("Messages");
            this.oMessages.Columns.Add("message", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "Messages";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Message";
            cs.MappingName = "message";
            cs.Width = 600;
            ts.GridColumnStyles.Add(cs);
            this.dgMessages.TableStyles.Add(ts);
            this.dgMessages.DataSource = this.oMessages;
        }

        private void ItemsScroll_Click(object sender, System.EventArgs e)
        {
            this.txtEdit.Visible = false;
            this.comboSloc.Visible = false;
            this.comboActype.Visible = false;
            this.comboLookUp.Visible = false;
            this.comboUOM.Visible = false;
        }

        private void dgItems_Click(object sender, System.EventArgs e)
        {
            //Exit if empty grid
            if (this.oItems == null || this.oItems.Rows.Count <= 0) return;

            bool bReturn = false;
            //Serial number profile
            string sSernp = (string)this.dgItems[this.dgItems.CurrentCell.RowNumber, Columns.sernp];
            //Item is repairable flag
            string sRepair = (string)this.dgItems[this.dgItems.CurrentCell.RowNumber, Columns.repair];

            sSernp = sSernp.Trim();
            //Material number not editable
            if (this.dgItems.CurrentCell.ColumnNumber == Columns.material) bReturn = true;
            //Equipment and serial number not editable if not serialized
            else if (this.dgItems.CurrentCell.ColumnNumber == Columns.equipment || this.dgItems.CurrentCell.ColumnNumber == Columns.serial)
            {
                if (((string)this.dgItems[this.dgItems.CurrentCell.RowNumber, Columns.sernp]) == "") bReturn = true;
            }
            //functional location editable for serialized but only when the equipment master is not newly created
            //and it is a goods issue
            else if (this.dgItems.CurrentCell.ColumnNumber == Columns.functional_location)
            {
                if (sSernp == "") return;

                string sEqunr = (string)this.dgItems[this.dgItems.CurrentCell.RowNumber, Columns.equipment];
                if (sEqunr != "")
                {
                    if (this.clnNewEquipment.Contains(sEqunr) && this.GetMovementType() == GOODS_RETURN) bReturn = true;
                }
            }
            //Activity type if goods return and item is repairable or serialised
            else if (this.dgItems.CurrentCell.ColumnNumber == Columns.activity_type)
            {
                if (this.GetMovementType() != GOODS_RETURN) bReturn = true;
                else if (sSernp == "" && sRepair == "") bReturn = true;
                else if (sRepair == "M") bReturn = true;
            }
            //serial number/ equip only editable is serialized
            else if (this.dgItems.CurrentCell.ColumnNumber == Columns.serial || this.dgItems.CurrentCell.ColumnNumber == Columns.equipment)
            {
                if (sSernp == "") bReturn = true;
            }
            //Qty can only be 1 if serialized or repairable
            else if (this.dgItems.CurrentCell.ColumnNumber == Columns.qty)
            {
                //if ( sSernp != "" || sRepair != "") bReturn = true; 
            }

            if (bReturn)
            {
                this.txtEdit.Visible = false;
                this.comboSloc.Visible = false;
                this.comboLookUp.Visible = false;
                this.comboActype.Visible = false;
                this.comboUOM.Visible = false;
                return;
            }

            try
            {
                this.currentCell = this.dgItems.CurrentCell;
                // Get click event position (screen) and convert to grid position
                Point pt = this.dgItems.PointToClient(Control.MousePosition);
                // Get information about click position (type, row/col)
                DataGrid.HitTestInfo hti = this.dgItems.HitTest(pt.X, pt.Y);

                // Make sure the cell we want to edit is visible
                EnsureRowVisible(this.dgItems, this.currentCell.RowNumber);
                // Resize and reposition TextBox to match current cell bounds
                Rectangle rc = this.dgItems.GetCellBounds(this.currentCell.RowNumber, this.currentCell.ColumnNumber);
                if (this.currentCell.ColumnNumber == Columns.serial
                    || this.currentCell.ColumnNumber == Columns.equipment
                    || this.currentCell.ColumnNumber == Columns.qty)
                {
                    this.txtEdit.Bounds = this.RectangleToClient(this.dgItems.RectangleToScreen(rc));
                    this.txtEdit.Location = new Point((this.dgItems.Location.X + rc.Location.X), (this.dgItems.Location.Y + rc.Location.Y));
                    // Bring the focus to it
                    this.txtEdit.Focus();
                    //Adjust its value to match current cell value
                    this.sPrevValue = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    this.txtEdit.Text = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    if (this.currentCell.ColumnNumber == Columns.qty && this.txtEdit.Text.CompareTo("0") == 0)
                    {
                        this.txtEdit.Text = "";
                    }
                    // Finally, show the textBox
                    this.txtEdit.Visible = true;
                    this.comboSloc.Visible = false;
                    this.comboLookUp.Visible = false;
                    this.comboActype.Visible = false;
                    this.comboUOM.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == Columns.functional_location)
                {
                    this.BuildComboLookUp((string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber]);
                    this.comboLookUp.Visible = true;
                    this.comboLookUp.Bounds = this.RectangleToClient(this.dgItems.RectangleToScreen(rc));
                    this.comboLookUp.Location = new Point((this.dgItems.Location.X + rc.Location.X), (this.dgItems.Location.Y + rc.Location.Y));
                    // Bring the focus to it
                    this.comboLookUp.Focus();
                    //Adjust its value to match current cell value
                    this.comboLookUp.Text = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    // Finally, show the textBox
                    this.comboLookUp.Visible = true;
                    this.comboSloc.Visible = false;
                    this.txtEdit.Visible = false;
                    this.comboActype.Visible = false;
                    this.comboUOM.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == Columns.sloc)
                {
                    this.BuildSLocCombo();
                    this.comboSloc.Bounds = this.RectangleToClient(this.dgItems.RectangleToScreen(rc));
                    this.comboSloc.Location = new Point((this.dgItems.Location.X + rc.Location.X), (this.dgItems.Location.Y + rc.Location.Y));
                    // Bring the focus to it
                    this.comboSloc.Focus();
                    //Adjust its value to match current cell value
                    this.comboSloc.Text = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    // Finally, show the textBox
                    this.comboSloc.Visible = true;
                    this.comboLookUp.Visible = false;
                    this.txtEdit.Visible = false;
                    this.comboActype.Visible = false;
                    this.comboUOM.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == Columns.activity_type)
                {
                    this.comboActype.Bounds = this.RectangleToClient(this.dgItems.RectangleToScreen(rc));
                    this.comboActype.Location = new Point((this.dgItems.Location.X + rc.Location.X), (this.dgItems.Location.Y + rc.Location.Y));
                    // Bring the focus to it
                    this.comboActype.Focus();
                    //Adjust its value to match current cell value
                    //					string sDlgItem = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    //					foreach(object oItem in this.comboActype.Items)
                    //					{
                    //						if (oItem.ToString() != "")
                    //						{
                    //							if (oItem.ToString().Substring(0,3) == sDlgItem.Substring(0,3))
                    //							{
                    //								this.comboActype.SelectedItem = oItem;
                    //								break;
                    //							}
                    //						}
                    //					}
                    this.comboActype.Text = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    // Finally, show the textBox
                    this.comboActype.Visible = true;
                    this.comboLookUp.Visible = false;
                    this.comboSloc.Visible = false;
                    this.txtEdit.Visible = false;
                    this.comboUOM.Visible = false;
                }
                else if (this.currentCell.ColumnNumber == Columns.uom)
                {
                    this.comboUOM.Bounds = this.RectangleToClient(this.dgItems.RectangleToScreen(rc));
                    this.comboUOM.Location = new Point((this.dgItems.Location.X + rc.Location.X), (this.dgItems.Location.Y + rc.Location.Y));

                    // Bring the focus to it
                    this.comboUOM.Focus();
                    //Adjust its value to match current cell value
                    this.comboUOM.Text = (string)this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber];
                    // Finally, show the textBox
                    this.comboActype.Visible = false;
                    this.comboLookUp.Visible = false;
                    this.comboSloc.Visible = false;
                    this.txtEdit.Visible = false;
                    this.BuildUOMCombo((string)this.oItems.Rows[this.currentCell.RowNumber][Columns.matnr0]);
                    this.comboUOM.Visible = true;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, frmStart.MESSAGE_BOX_TITLE);
            }
        }
        /// <summary>
        /// Build the combo box for storage location - the storage locations 
        /// a mterial is valid for
        /// sSLocXML contains the locations for all materials on the order and is populated when
        /// the order data is selected
        /// </summary>
        private void BuildSLocCombo()
        {
            XmlDocument oXML = new XmlDocument();
            oXML.LoadXml(sSLocXML);
            int i = 0;

            this.comboSloc.Items.Clear();
            string sMatnr = this.dgItems[this.currentCell.RowNumber, Columns.matnr0].ToString();
            XmlNodeList oMat = oXML.GetElementsByTagName("m" + sMatnr);
            if (oMat.Count > 0)
            {
                foreach (XmlNode oNode in oMat.Item(0).ChildNodes)
                {
                    this.comboSloc.Items.Add(oNode.InnerText);
                    if (oNode.InnerText.Trim() ==
                        this.dgItems[this.currentCell.RowNumber, Columns.sloc].ToString().Trim())
                    {
                        this.comboSloc.SelectedIndex = i;
                    }
                    i++;
                }
            }
        }
        /// <summary>
        /// Build the combo box for UOM - the UOMs valid for a material
        /// sUOMXML contains the UOMS for all materials on the order and is populated when
        /// the order data is selected
        /// </summary>
        /// <param name="sMatnr"></param>
        private void BuildUOMCombo(string sMatnr)
        {
            XmlDocument oXML = new XmlDocument();
            this.comboUOM.Items.Clear();
            int i = 0;
            try
            {
                oXML.LoadXml(sUOMXml);
                XmlNodeList oMatnrs = oXML.GetElementsByTagName("matnr");
                foreach (XmlNode oNode in oMatnrs)
                {
                    if (oNode.Attributes.GetNamedItem("id").InnerText == sMatnr)
                    {
                        foreach (XmlNode oUOM in oNode.ChildNodes)
                        {
                            this.comboUOM.Items.Add(oUOM.Attributes.GetNamedItem("ext").InnerText);
                            if (oUOM.Attributes.GetNamedItem("ext").InnerText ==
                                this.dgItems[this.currentCell.RowNumber, Columns.uom].ToString())
                            {
                                this.comboUOM.SelectedIndex = i;
                            }
                            i++;
                        }
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
        }
        private void txtWO_TextChanged(object sender, System.EventArgs e)
        {
            bool bReplaced = false;
            this.txtWO = frmStart.RemoveScanSuffix(this.txtWO, out bReplaced);
            if (bReplaced && this.comboMvtType.Text != "") this.GetWOFromSAP(sender, e);
            this.frmParent.UpdateLastDidSomethingAt();
        }

        private void txtWO_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            //If enter pressed when in the PO number field, treat it as though the user
            //has clicked on the OK button.
            if (e.KeyChar == (char)13)
            {
                this.cmdGetWO_Click(this, new EventArgs());
            }
        }

        /// <summary>
        /// Edit box for qty, serial number and equipment number
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtEdit_TextChanged(object sender, System.EventArgs e)
        {
            bool bReplaced;
            this.txtEdit = frmStart.RemoveScanSuffix(this.txtEdit, out bReplaced);
            double dQty = 0;
            this.bChanges = true;
            try
            {
                if (this.txtEdit.Text.Trim() != "")
                {
                    if (this.currentCell.ColumnNumber == Columns.qty) dQty = Double.Parse(this.txtEdit.Text);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Please enter a valid number \n" + ex.Message, frmStart.MESSAGE_BOX_TITLE);
                this.txtEdit.Text = "0";
            }
            this.oItems.Rows[this.currentCell.RowNumber][this.currentCell.ColumnNumber] = this.txtEdit.Text;
        }

        /// <summary>
        /// Combo box for functional location - blank, current value or a link that launches frmFnLoc
        /// </summary>
        /// <param name="sCurrVal"></param>
        private void BuildComboLookUp(string sCurrVal)
        {
            this.comboLookUp.Items.Clear();
            this.comboLookUp.Items.Add(sCurrVal);
            this.comboLookUp.Items.Add("Look up....");
            if (sCurrVal.Trim() != "") this.comboLookUp.Items.Add(" ");
        }

        private void comboLookUp_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.bChanges = true;
            if (this.comboLookUp.SelectedIndex == 1)
            {
                if (this.currentCell.ColumnNumber == Columns.functional_location)
                {
                    frmFnLoc frmLookup = new frmFnLoc();
                    frmLookup.sTopNode = (string)this.comboLookUp.Items[0];
                    frmLookup.sPlant = this.sPlant;
                    frmLookup.frmParent = this;
                    this.frmParent.UpdateLastDidSomethingAt();
                    frmLookup.ShowDialog();
                    this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber] = frmLookup.sTopNode;
                    this.comboLookUp.Items.Clear();
                    this.comboLookUp.Visible = false;
                }
            }
            else if (this.comboLookUp.Text.Trim() == "")
            {
                if (this.currentCell.ColumnNumber == Columns.functional_location)
                {
                    this.dgItems[this.currentCell.RowNumber, this.currentCell.ColumnNumber] = "";
                }
            }
        }

        private void comboMvtType_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            if (this.comboMvtType.Text != "" && this.txtWO.Text != "")
            {
                //WO information must be refreshed when the movement type is changed
                this.GetWOFromSAP(sender, e);
            }
        }

        private void txtEdit_LostFocus(object sender, System.EventArgs e)
        {
            string sMatnr;				//Material Number
            string sSernr;				//Serial Number
            string sEqunr = "";			//Equipment Number
            string sSloc = "";			//Storage location
            string sFloc = "";			//Functional location

            bool bNotChanged = false;
            //Has the value been changed?
            if (this.sPrevValue == this.txtEdit.Text) bNotChanged = true;
            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                this.frmParent.UpdateLastDidSomethingAt();

                //Text box is acting for SERIAL NUMBER input
                if (this.currentCell.ColumnNumber == Columns.serial)
                {
                    //Get material, serial number from grid
                    sMatnr = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.matnr0];
                    sSernr = this.oItems.Rows[this.currentCell.RowNumber][Columns.serial].ToString().Trim().ToUpper();
                    this.oItems.Rows[this.currentCell.RowNumber][Columns.serial] = sSernr;
                    for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                    {
                        //SOAP call tried up to 3 times
                        try
                        {
                            //Get the equipment master and functional location for the serial number
                            if (sSernr != "") sEqunr = this.oSAPGateway.GetEqunrAndFLoc(sSernr, sMatnr, ref sFloc, ref sSloc);
                            break;
                        }
                        catch (Exception ex)
                        {
                            if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                                frmStart.HandleException(ex, false);
                            else this.RefreshSAPGateway();
                        }
                    }

                    //Is storage location entered - if not use one brought back from GetEqunrAndFLoc
                    if ((string)this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc] != "") sSloc = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc];
                    else this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc] = sSloc;

                    //Is equipment installed at functional location
                    if (sFloc != "")
                    {
                        //If it is a goods return then populate the functional location field
                        if (this.GetMovementType() == GOODS_RETURN) this.oItems.Rows[this.currentCell.RowNumber][Columns.functional_location] = sFloc;
                        else if (sEqunr != "")
                        {
                            //Goods issue - cannot be issued if it is currently installed at a functional location
                            MessageBox.Show("The equipment is currently installed and cannot be issued from stores");
                            sEqunr = "";			//equipment number
                            sSernr = "";			//serial number
                        }
                    }
                    this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment] = sEqunr;

                    //No changes made - exit
                    if (bNotChanged && sEqunr != "")
                    {
                        Cursor.Current = Cursors.Default;
                        return;
                    }

                    //If serial number is populated but no equipment master created then create one (prompt)
                    if (sSernr != "" && sSloc != "")
                    {
                        if (sEqunr == "")
                        {
                            sEqunr = this.CreateEqunr(sMatnr, sSernr, sSloc);
                            this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment] = sEqunr;
                        }
                    }
                }
                //Text box is acting for EQUIPMENT NUMBER input
                else if (this.currentCell.ColumnNumber == Columns.equipment)
                {
                    if (bNotChanged)
                    {
                        Cursor.Current = Cursors.Default;
                        return;
                    }
                    //Get material, equipment number and serial number
                    sMatnr = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.matnr0];
                    sEqunr = this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment].ToString().Trim();
                    sSernr = this.oItems.Rows[this.currentCell.RowNumber][Columns.serial].ToString().Trim();
                    if (sEqunr != "")
                    {
                        //Validate the equipment number against the serial number/ material
                        //SOAP tries up to 3 times
                        for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                        {
                            try
                            {
                                sSernr = "";
                                if (!this.oSAPGateway.EqunrSernrValidateWithFloc(ref sSernr, sMatnr, sEqunr, out sFloc))
                                {
                                    //Invalid equipment number
                                    MessageBox.Show("Equipment number is not valid", frmStart.MESSAGE_BOX_TITLE);
                                    this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment] = "";
                                    this.txtEdit.Text = "";
                                }
                                else
                                {
                                    //If goods return and functional location is blank and they haven't just created the
                                    //equipment record then - error 
                                    if (sSernr.Trim() != "") this.oItems.Rows[this.currentCell.RowNumber][Columns.serial] = sSernr;
                                    this.oItems.Rows[this.currentCell.RowNumber][Columns.functional_location] = sFloc;
                                    if (sFloc.Trim() == "" && this.GetMovementType() == GOODS_RETURN && !this.clnNewEquipment.Contains(sEqunr))
                                    {
                                        MessageBox.Show("The equipment is not installed a functional location.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OK, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1);
                                    }
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
                //Text box is acting for QUANTITY input
                else if (this.currentCell.ColumnNumber == Columns.qty)
                {
                    if (bNotChanged)
                    {
                        Cursor.Current = Cursors.Default;
                        return;
                    }
                    try
                    {
                        if (this.txtEdit.Text.Trim() != "")
                        {
                            double dQty = Double.Parse(this.txtEdit.Text);
                        }
                        else
                        {
                            this.oItems.Rows[this.currentCell.RowNumber][Columns.qty] = "0";
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Please enter a valid number  \n" + ex.Message, frmStart.MESSAGE_BOX_TITLE);
                        this.oItems.Rows[this.currentCell.RowNumber][Columns.qty] = "0";
                    }
                }
                //Changes have been made - Check the storage location is valid for the movement, repair, blah blah
                if (!bNotChanged)
                {
                    string sSlocMessage = "";
                    sSloc = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc];
                    string sSernp = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.sernp];
                    string sRepFlag = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.repair];

                    sEqunr = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment];
                    if (!this.oSAPGateway.CheckStorageLocation(this.sAufnr, sEqunr, sSernp, this.GetMovementType(), sRepFlag, ref sSloc, out sSlocMessage))
                    {
                        MessageBox.Show(sSlocMessage, frmStart.MESSAGE_BOX_TITLE);
                    }
                    this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc] = sSloc;
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            Cursor.Current = Cursors.Default;
        }

        private void comboSloc_LostFocus(object sender, System.EventArgs e)
        {
            this.oItems.Rows[this.currentCell.RowNumber][Columns.sloc] = this.comboSloc.Text;
            this.frmParent.UpdateLastDidSomethingAt();
            if (this.comboSloc.Text != "")
            {
                string sSernr = this.oItems.Rows[this.currentCell.RowNumber][Columns.serial].ToString().Trim();
                if (sSernr != "")
                {
                    string sMatnr = (string)this.oItems.Rows[this.currentCell.RowNumber][Columns.matnr0];
                    string sEqunr = this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment].ToString().Trim();
                    if (sEqunr == "")
                    {
                        //Storage location changed  - prompt equipment create if serial number is not blank
                        //and there is no equipment master on the system
                        sEqunr = this.CreateEqunr(sMatnr, sSernr, this.comboSloc.Text);
                        this.oItems.Rows[this.currentCell.RowNumber][Columns.equipment] = sEqunr;
                    }
                }
                //Reset the activity type unless REPS storage location  
                if (this.comboSloc.Text != "REPS" && this.GetMovementType() == GOODS_RETURN)
                {
                    this.oItems.Rows[this.currentCell.RowNumber][Columns.activity_type] = "";
                }
            }
        }

        /// <summary>
        /// Activity type combo box 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void comboActype_LostFocus(object sender, System.EventArgs e)
        {
            this.oItems.Rows[this.currentCell.RowNumber][Columns.activity_type] = this.comboActype.Text;
            this.frmParent.UpdateLastDidSomethingAt();
        }
        /// <summary>
        /// UOM combo box
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void comboUOM_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.oItems.Rows[this.currentCell.RowNumber][Columns.uom] = this.comboUOM.Text;
            this.frmParent.UpdateLastDidSomethingAt();
        }
        #endregion
        #region Menu
        private void mnuiExit_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
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
                this.DefaultRecipient();
            }
        }

        private void mnuiLogoff_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            this.frmParent.LogoffSAP();
            this.mnuiLogon.Enabled = true;
            this.mnuiLogoff.Enabled = false;
        }
        private void mnuiDelete_Click(object sender, System.EventArgs e)
        {
            if (this.oItems == null || this.oItems.Rows.Count <= 0) return;
            if (this.dgItems.IsSelected(this.dgItems.CurrentRowIndex))
            {
                if (MessageBox.Show("Please confirm that you wish to delete the selected item.", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2)
                    == DialogResult.OK)
                    this.oItems.Rows.RemoveAt(this.dgItems.CurrentRowIndex);
                this.txtEdit.Visible = false;
                this.comboSloc.Visible = false;
                this.comboLookUp.Visible = false;
                this.comboActype.Visible = false;
                this.comboUOM.Visible = false;
            }
            else MessageBox.Show("The row needs to be selected first (button on left of row)", frmStart.MESSAGE_BOX_TITLE);
        }

        private void mnuiClear_Click(object sender, System.EventArgs e)
        {
            if (this.bChanges)
            {
                if (MessageBox.Show("Unsaved data will be lost. Continue?", frmStart.MESSAGE_BOX_TITLE, MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1)
                    == DialogResult.Cancel) return;

            }
            this.RefreshData();
            this.frmParent.UpdateLastDidSomethingAt();
        }
        private void mnuiZeroQtys_Click(object sender, System.EventArgs e)
        {
            for (int i = 0; i < this.oItems.Rows.Count; i++)
            {
                if (this.oItems.Rows[i][Columns.repair].ToString() == "")
                {
                    this.oItems.Rows[i][Columns.qty] = "0";
                }
            }
        }
        #endregion
        #region Communicate With SAP
        private void GetWOFromSAP(object sender, System.EventArgs e)
        {
            bool bSerial = false;				//At least one serialised item?
            bool bFloc = false;					//At least one fn loc required
            bool bEqunr = false;				//At least one equipment number?
            bool bActType = false;				//At least one activity type
            //Communicate via the HTTP interface 
            HTTPSAPGateway oSAP = new HTTPSAPGateway();
            string sXML = "";
            try
            {
                this.frmParent.UpdateLastDidSomethingAt();

                if (this.txtWO.Text.Trim() == "" || this.comboMvtType.Text == "")
                {
                    MessageBox.Show("Please enter a work order number and movement type", frmStart.MESSAGE_BOX_TITLE);
                }
                else
                {
                    if (!this.GetSAPConnection()) return;

//                    this.lblCurrentWO.Text = "Retrieving WO data from SAP...";
                    this.lblStatusBar.Text = "Retrieving WO data from SAP...";
                    //this.lblCurrentWO.Update();
                    this.lblStatusBar.Update();
                    //Clear existing
                    this.sOrderType = "";
                    this.oItems.Clear();
                    this.clnNewEquipment.Clear();

                    string sHtext = "";			//Header text
                    this.sUOMXml = "";				//UOMs for materials
                    Cursor.Current = Cursors.WaitCursor;

                    //Get the data
                    sXML = oSAP.WOGetDetail(this.frmParent.SAPUname, this.frmParent.SAPPword,
                                this.txtWO.Text, this.GetMovementType(), ref this.sPlant, ref sHtext, ref this.sUOMXml);

                    this.txtHeaderText.Text = sHtext;
                    XmlDocument oXML = new XmlDocument();
                    oXML.LoadXml(sXML);
                    //Components are <c> nodes
                    XmlNodeList oComponents = oXML.GetElementsByTagName("c");

                    int i = 0;
                    if (oComponents.Count > 0) this.aMaterials = new string[oComponents.Count];
                    else this.aMaterials = null;

                    foreach (XmlNode oItem in oComponents)
                    {
                        //Serialized?
                        if (oItem.ChildNodes.Item(9).InnerText != "")
                        {
                            bSerial = true;
                            bEqunr = true;
                            bFloc = true;
                        }
                        //Serialized or repairable?? - activty type combo if goods return
                        if (this.GetMovementType() == GOODS_RETURN && (oItem.ChildNodes.Item(9).InnerText != "" || oItem.ChildNodes.Item(11).InnerText != "")) bActType = true;
                    }

                    this.BuildItemsGrid(bSerial, bEqunr, bFloc, bActType);

                    this.sOrderType = oXML.GetElementsByTagName("type").Item(0).InnerText;
                    if (oComponents.Count > 0)
                    {
                        this.sAufnr = this.txtWO.Text.Trim();
//                        this.lblCurrentWO.Text = "Current Order is " + this.txtWO.Text + ".\n" + "There are " + oComponents.Count + " components." + "\nPress the Items tab to view and post goods movement.";
                        this.lblStatusBar.ForeColor = System.Drawing.Color.Black;
                        this.lblStatusBar.Text = "Current Order: " + this.txtWO.Text + ": " + oComponents.Count + " items";
                        this.sSLocXML = "<list></list>";

                        foreach (XmlNode oItem in oComponents)
                        {
                            this.aMaterials[i++] = oItem.ChildNodes.Item(0).InnerText.Trim();
                        }
                        this.GetStorageLocations();
                    }

                    i = 0;
                    foreach (XmlNode oItem in oComponents)
                    {
                        DataRow oRow = this.oItems.NewRow();
                        //Material number
                        oRow["matnr"] = this.FormatMatnr(oItem.ChildNodes.Item(0).InnerText);
                        //Description
                        oRow["descr"] = oItem.ChildNodes.Item(1).InnerText;
                        //Qty
                        oRow["qty"] = oItem.ChildNodes.Item(2).InnerText;
                        //UOM
                        oRow["uom"] = oItem.ChildNodes.Item(3).InnerText;
                        //Storage location
                        oRow["sloc"] = oItem.ChildNodes.Item(4).InnerText;
                        if ((string)oRow["sloc"] == "") oRow["sloc"] = DEFAULT_STORAGE_LOCATION;
                        //Serial profile
                        oRow["serial"] = oItem.ChildNodes.Item(5).InnerText;
                        //Equipment number
                        oRow["equip"] = oItem.ChildNodes.Item(6).InnerText;
                        //Functional location
                        oRow["fnloc"] = oItem.ChildNodes.Item(7).InnerText;
                        //Activity type
                        oRow["actype"] = oItem.ChildNodes.Item(8).InnerText;
                        // Get the full text for the activity type.
                        if (oRow["actype"].ToString() != "")
                        {
                            foreach (object oActItem in this.comboActype.Items)
                            {
                                if (oActItem.ToString() != "")
                                {
                                    if (oActItem.ToString().Substring(0, 3) == oRow["actype"].ToString().Substring(0, 3))
                                    {
                                        oRow["actype"] = oActItem.ToString();
                                    }
                                }
                            }
                        }
                        //material number with zeros
                        oRow["matnr0"] = oItem.ChildNodes.Item(0).InnerText;
                        //serial number profile
                        oRow["sernp"] = oItem.ChildNodes.Item(9).InnerText;
                        //item number
                        oRow["item"] = oItem.ChildNodes.Item(10).InnerText;
                        //repairable flag
                        oRow["repair"] = oItem.ChildNodes.Item(11).InnerText;

                        //Serial
                        if ((string)oRow["sernp"] != "")
                        {
                            //oRow["qty"] = "1";
                            bSerial = true;
                            bEqunr = true;
                        }

                        if (this.GetMovementType() == GOODS_RETURN && (string)oRow["repair"] == "" && (string)oRow["sernp"] == "")
                        {
                            // If doing a Goods Return to WO and the item
                            // isn't repairable, set the qty to zero.
                            oRow["qty"] = "0";
                        }

                        if (this.GetMovementType() == GOODS_RETURN && ((string)oRow["sernp"] != "" || (string)oRow["repair"] != ""))
                        {
                            bActType = true;
                        }
                        if ((string)oRow["sernp"] != "") bFloc = true;

                        this.oItems.Rows.Add(oRow);
                        this.aMaterials[i] = oItem.ChildNodes.Item(0).InnerText.Trim();

                        i++;
                    }

                    if (oComponents.Count > 0)
                    {
                        //Thread oThread = new Thread(new ThreadStart(this.GetStorageLocations));
                        //oThread.Start();
                        if (this.bStores == false)
                        {
                            this.tabControl1.SelectedIndex = 1;
                        }
                        if (this.GetMovementType() == GOODS_ISSUE)
                        {
                            this.cmdGetRecipients.Enabled = true;
                            this.comboRecipient.Enabled = true;
                            if (this.bStores == true)
                            {
                                // Instead of going to the items screen first, we want to 
                                // let them scan in the recipient first.
                                this.bScanRecipient = true;
                                this.cmdGetRecipients_Click(sender, e);
                            }
                        }
                        else
                        {
                            this.comboRecipient.Enabled = false;
                        }
                        this.cmdGetRecipients.BackColor = System.Drawing.Color.LightGreen;
                    }
                    else
                    {
//                        this.lblCurrentWO.Text = "No Work Order selected";

                        if (this.sOrderType.Trim() == "")
                        {
//                            MessageBox.Show("No work order found.", frmStart.MESSAGE_BOX_TITLE);
                            this.lblStatusBar.ForeColor = System.Drawing.Color.DarkRed;
                            this.lblStatusBar.Text = "No Work Order found";

                        }
                        else
                        {
//                            MessageBox.Show("The Work Order has no selectable items.", frmStart.MESSAGE_BOX_TITLE);
                            this.lblStatusBar.ForeColor = System.Drawing.Color.DarkRed;
                            this.lblStatusBar.Text = "No items on WO";
                        }
                        this.txtWO.Focus();
                    }

                    this.bChanges = false;
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            finally
            {
                Cursor.Current = Cursors.Default;
            }
        }

        private void comboRecipient_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            // If we are doing an issue to WO for Stores, program defaults to initially
            // entering the Recipient. Once this is done we want to go automatically to
            // the items screen, as the program does for a initially for a normal issue
            // to WO.
            if (this.bStores == true && this.txtWO.Text.CompareTo("") != 0 && this.comboRecipient.Text.CompareTo("") != 0)
            {
                this.tabControl1.SelectedIndex = 1;
            }
        }

        private bool ValidateRecipient()
        {
            int iSelected = 0;
            int i;
            for (i = 0; i < this.comboRecipient.Items.Count; i++)
            {
                if (this.aUnames[i].ToString().CompareTo(this.txtRecipient.Text) == 0)
                {
                    iSelected = i;
                    break;
                }
            }
            if (iSelected != i)
            {
                return false;
            }
            else
            {
                this.comboRecipient.SelectedIndex = iSelected;
                return true;
            }
        }

        private void cmdPost_Click(object sender, System.EventArgs e)
        {
            //change text on key instead of message string
            this.cmdPost.Text = "Saving..";
            this.cmdPost.BackColor = System.Drawing.Color.Red;
            this.cmdPost.Enabled = false;

            bool bItems = false;
            string sItemXML = "<post>";			//Items to post as XML string
            string sEqunrXML = "<new>";			//New equipment numbers as XML string
            string sRecipient = "";
            string sSernp = "";
            string sSerial = "";
            string sFnLoc = "";
            string sEqunr = "";
            string sPMAct = "";
            string sSloc = "";
            string sRepair = "";
            HTTPSAPGateway oHTTPSAPGateway = new HTTPSAPGateway();
            int i = 0;
            double dQty = 0;
            bool bOK = false;
            try
            {    
                this.frmParent.UpdateLastDidSomethingAt();
                if (!this.GetSAPConnection()) return;
                if (!this.CheckLock()) return;
                // if the recipient has been scanned in then the comborecipient will have been 
                // overlaid by txtrecipient box. This being the case move the scanned text
                if (this.bScanRecipient = true && this.txtRecipient.Text == "" && this.bStores == true)
                {
                    MessageBox.Show("Please enter a recipient", frmStart.MESSAGE_BOX_TITLE);
                    this.tabControl1.SelectedIndex = 0;
                    return;  
                }
                else
                {
                    if (this.bScanRecipient == false)
                    {
                        if (this.comboRecipient.Text == "" && this.GetMovementType() != GOODS_RETURN)
                        {
                            MessageBox.Show("Please enter a recipient", frmStart.MESSAGE_BOX_TITLE);
                            this.tabControl1.SelectedIndex = 0;
                            return;
                        }
                    }
                }

                
                if (this.oItems.Rows.Count == 0)
                {
                    MessageBox.Show("There are no items to post", frmStart.MESSAGE_BOX_TITLE);
                    return;
                }

                foreach (DataRow oRow in this.oItems.Rows)
                {
                    dQty = Double.Parse((string)oRow["qty"]);
                    if (dQty > 0)
                    {
                        bItems = true;

                        sSernp = (string)oRow["sernp"];
                        sEqunr = (string)oRow["equip"];
                        sFnLoc = (string)oRow["fnloc"];
                        sSloc = (string)oRow["sloc"];
                        sPMAct = (string)oRow["actype"];
                        sRepair = (string)oRow["repair"];
                        sSerial = (string)oRow["serial"];
                        sSernp = sSernp.Trim();
                        sFnLoc = sFnLoc.Trim();
                        sSloc = sSloc.Trim();
                        sPMAct = sPMAct.Trim();
                        sEqunr = sEqunr.Trim();
                        sSerial = sSerial.Trim();
                        string sSlocMessage = "";
                        Cursor.Current = Cursors.WaitCursor;
                        Cursor.Show();
                        //Check storage location is valid
                        if (!this.oSAPGateway.CheckStorageLocation(this.sAufnr, sEqunr, sSernp, this.GetMovementType(), sRepair, ref sSloc, out sSlocMessage))
                        {
                            MessageBox.Show(sSlocMessage, frmStart.MESSAGE_BOX_TITLE);
                            this.dgItems.CurrentCell = new DataGridCell(i, Columns.sloc);
                            this.dgItems_Click(this, new EventArgs());
                            Cursor.Current = Cursors.Default;
                            return;
                        }
                        Cursor.Current = Cursors.Default;
                        if (sSloc == "")
                        {
                            MessageBox.Show("Please enter a storage location for all items", frmStart.MESSAGE_BOX_TITLE);
                            this.dgItems.CurrentCell = new DataGridCell(i, Columns.sloc);
                            this.dgItems_Click(this, new EventArgs());
                            return;
                        }
                        //Serial number and equipment necessary??
                        if (sSernp != "")
                        {
                            if (sEqunr == "" || sSerial == "")
                            {
                                MessageBox.Show("Please enter equipment number and serial number for serialized items - " + (string)oRow["descr"], frmStart.MESSAGE_BOX_TITLE);
                                if (sSerial == "") this.dgItems.CurrentCell = new DataGridCell(i, Columns.serial);
                                else this.dgItems.CurrentCell = new DataGridCell(i, Columns.equipment);
                                this.dgItems_Click(this, new EventArgs());
                                return;
                            }

                            if (dQty > 1)
                            {
                                MessageBox.Show("Serialised: Quantity cannot be greater than 1", frmStart.MESSAGE_BOX_TITLE);
                                this.dgItems.CurrentCell = new DataGridCell(i, Columns.qty);
                                this.dgItems_Click(this, new EventArgs());
                                return;
                            }
                        }
                        //Functional location required if equipment master not new and it is goods issue
                        if (sEqunr != "" && sFnLoc == "")
                        {
                            if (this.GetMovementType() != GOODS_RETURN ||
                                this.clnNewEquipment.Contains(sEqunr) == false)
                            {

                                MessageBox.Show("Please enter a functional location for component: " + (string)oRow["descr"], frmStart.MESSAGE_BOX_TITLE);
                                this.dgItems.CurrentCell = new DataGridCell(i, Columns.functional_location);
                                this.dgItems_Click(this, new EventArgs());
                                return;
                            }
                        }

                        if (this.GetMovementType() == GOODS_RETURN && sSloc == "REPS")
                        {
                            //Activity type required for REPS/goods return for serialized or repairable
                            //BUT, not to be entered for multiple repairable items.
                            if (sRepair == "M" && sPMAct != "")
                            {
                                MessageBox.Show("Please do not enter an activity type", frmStart.MESSAGE_BOX_TITLE);
                                this.dgItems.CurrentCell = new DataGridCell(i, Columns.activity_type);
                                this.dgItems_Click(this, new EventArgs());
                                return;
                            }
                            else
                            {
                                if (sSernp != "" || (sRepair != "" && sRepair != "M"))
                                {
                                    if (dQty > 1)
                                    {
                                        MessageBox.Show("Repairable: Quantity cannot be greater than 1", frmStart.MESSAGE_BOX_TITLE);
                                        this.dgItems.CurrentCell = new DataGridCell(i, Columns.qty);
                                        this.dgItems_Click(this, new EventArgs());
                                        return;
                                    }

                                    if (sPMAct == "")
                                    {
                                        MessageBox.Show("Please enter an activity type", frmStart.MESSAGE_BOX_TITLE);
                                        this.dgItems.CurrentCell = new DataGridCell(i, Columns.activity_type);
                                        this.dgItems_Click(this, new EventArgs());
                                        return;
                                    }
                                }
                            }
                        }

                        string sActType = (string)oRow["actype"];
                        if (sActType.Length >= 3) sActType = sActType.Trim().Substring(0, 3);
                        sItemXML += "<comp ";
                        sItemXML += " matnr='" + (string)oRow["matnr0"] + "'";
                        sItemXML += " qty='" + (string)oRow["qty"] + "'";
                        sItemXML += " uom='" + (string)oRow["uom"] + "'";
                        sItemXML += " sloc='" + (string)oRow["sloc"] + "'";
                        sItemXML += " serial='" + (string)oRow["serial"] + "'";
                        sItemXML += " equip='" + (string)oRow["equip"] + "'";
                        sItemXML += " fnloc='" + (string)oRow["fnloc"] + "'";
                        sItemXML += " actype='" + sActType + "'";
                        sItemXML += " item='" + (string)oRow["item"] + "'";
                        sItemXML += " />";
                    }
                    i++;
                }

                //Get the Recipient  
                //if (this.bScanRecipient = true)
                if (this.bScanRecipient = true && this.txtRecipient.Text != "" && this.bStores == true)
                {
                    sRecipient = this.txtRecipient.Text;
                }
                else
                {
                    if (this.aUnames.Count == 0)
                    {
                        sRecipient = this.comboRecipient.Text.ToUpper();
                    }
                    else
                    {
                        sRecipient = (string)this.aUnames[comboRecipient.SelectedIndex];
                    }
                }

                //Date in SAP format
                string sDate = this.dateTimePicker1.Value.Year.ToString();
                sDate += (this.dateTimePicker1.Value.Month.ToString().Length == 1) ? "0" + this.dateTimePicker1.Value.Month.ToString() : dateTimePicker1.Value.Month.ToString();
                sDate += (this.dateTimePicker1.Value.Day.ToString().Length == 1) ? "0" + this.dateTimePicker1.Value.Day.ToString() : dateTimePicker1.Value.Day.ToString();

                if (!bItems)
                {
                    MessageBox.Show("You have not entered a quantity for any of the items", frmStart.MESSAGE_BOX_TITLE);
                    return;
                }

                sItemXML += "</post>";
                //New equipment number XML				 
                foreach (string sEquip in this.clnNewEquipment)
                {
                    sEqunrXML += "<eq>" + (string)sEquip + "</eq>";
                }
                sEqunrXML += "</new>";
                //Clear Message tab
                this.oMessages.Clear();

                //Post
                string sMessageXML = "";
                this.dgItems.Visible = false;
                this.cmdPost.Enabled = false;
                this.cmdGetWO.Enabled = false;
                this.txtEdit.Visible = false;
                this.comboSloc.Visible = false;
                this.comboLookUp.Visible = false;
                this.comboActype.Visible = false;
                this.comboUOM.Visible = false;
                this.tbpItems.Refresh();
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                string sSuccess = "";
                bOK = oHTTPSAPGateway.GoodsMovement(this.frmParent.SAPUname, this.frmParent.SAPPword,
                    this.sAufnr, sDate, this.txtDocHeader.Text, this.GetMovementType(), sRecipient,
                    sItemXML, sEqunrXML, ref sMessageXML, out sSuccess);

                if (bOK)
                {
                    this.RefreshData();
                    MessageBox.Show("All documents were posted successfully", frmStart.MESSAGE_BOX_TITLE);
                    this.tabControl1.SelectedIndex = 0;

                    //string sMessage = "";
                    //this.frmParent.GetSAPConnection(ref sMessage);
                    this.DefaultRecipient();
                    this.txtWO.Focus();
                }
                else
                {
                    // Remove any successful items
                    XmlDocument oXML = new XmlDocument();
                    oXML.LoadXml(sSuccess);
                    XmlNodeList oSuccessfulItems = oXML.GetElementsByTagName("i");
                    int iIndex = 0;

                    foreach (XmlNode oItem in oSuccessfulItems)
                    {
                        iIndex = 0;
                        foreach (DataRow oRow in oItems.Rows)
                        {
                            if ((string)oRow["item"] == oItem.InnerText.Trim())
                            {
                                oItems.Rows.RemoveAt(iIndex);
                                break;
                            }
                            iIndex++;
                        }

                    }

                    //Fill Message Tab
                    oXML.LoadXml(sMessageXML);
                    int iLevel = 0;
                    string sLevel = "";
                    string sMess = "";
                    XmlNodeList oMessageList = oXML.GetElementsByTagName("m");
                    foreach (XmlNode oNode in oMessageList)
                    {
                        sLevel = oNode.Attributes.GetNamedItem("level").InnerText.Trim();
                        if (sLevel == "") sLevel = "1";
                        try
                        {
                            iLevel = int.Parse(sLevel);
                        }
                        catch (Exception ex)
                        {
                            frmStart.HandleException(ex, true);
                            iLevel = 1;
                        }
                        sMess = "|-";
                        for (int j = 2; j <= iLevel; j++)
                        {
                            sMess += "--";
                        }
                        sMess += oNode.InnerText;
                        DataRow oRow = oMessages.NewRow();
                        oRow["message"] = sMess;
                        this.oMessages.Rows.Add(oRow);
                    }
                    this.tabControl1.SelectedIndex = 2;
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            finally
            {
                Cursor.Current = Cursors.Default;
                this.dgItems.Visible = true;
                this.cmdPost.Text = "Post";
                this.cmdPost.BackColor = System.Drawing.Color.LightGreen;
                this.cmdPost.Enabled = true;
                this.cmdGetWO.Enabled = true;
            }
        }
        /// <summary>
        /// Create new equipment master record
        /// </summary>
        /// <param name="sMatnr">Material number</param>
        /// <param name="sSernr">Serial number</param>
        /// <param name="sSloc">Storage location</param>
        /// <returns></returns>
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
                            if (!this.oSAPGateway.CreateEqunr(this.frmParent.SAPUname, this.frmParent.SAPPword,
                                sMatnr, sSernr, this.sPlant, sSloc,
                                this.GetMovementType(), ref sEqunr, ref sMessage))
                            {
                                MessageBox.Show(sMessage, frmStart.MESSAGE_BOX_TITLE);
                            }
                            else
                            {
                                this.clnNewEquipment.Add(sEqunr);
                                if (this.GetMovementType() == GOODS_RETURN) this.oItems.Rows[this.currentCell.RowNumber][Columns.functional_location] = "";
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
        /// <summary>
        /// Setup the connection and object for the SOAP calls
        /// </summary>
        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }

        /// <summary>
        /// Get the SAP login details from the parent form
        /// </summary>
        /// <returns></returns>
        private bool GetSAPConnection()
        {
            string sLoginError = "";
            if (this.frmParent.SAPUname == "" || this.frmParent.SAPPword == "")
            {
                if (!this.frmParent.GetSAPConnection(ref sLoginError))
                {
                    MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
                    return false;
                }
            }
            return true;
        }

        private void GetStorageLocations()
        {
            try
            {
                for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                {
                    try
                    {
                        sSLocXML = this.oSAPGateway.MaterialStorageLocationsList(this.sPlant, this.aMaterials);
                        break;
                    }
                    catch (Exception ex)
                    {
                        if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                            frmStart.HandleException(ex, false);
                        else this.RefreshSAPGateway();
                    }
                }

                this.GetActivityTypes();
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }

        }
        private void GetActivityTypes()
        {
            this.comboActype.Items.Clear();
            try
            {
                XmlDocument oXML = new XmlDocument();
                for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                {
                    try
                    {
                        oXML.LoadXml(this.oSAPGateway.GetActivityTypes(this.sOrderType));
                        break;
                    }
                    catch (Exception ex)
                    {
                        if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                            frmStart.HandleException(ex, false);
                        else this.RefreshSAPGateway();
                    }
                }

                XmlNodeList oList = oXML.GetElementsByTagName("at");
                this.comboActype.Items.Add("");
                foreach (XmlNode oNode in oList)
                {
                    this.comboActype.Items.Add(oNode.Attributes["id"].Value + " - " + oNode.InnerText);
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
        }

        private void PopulateRecipientList()
        {
            XmlDocument oDoc = new XmlDocument();
            XmlNodeList oPeople;

            int i = 0;

            try
            {
                for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                {
                    try
                    {
                        this.sRecipientXML = this.oSAPGateway.RecipientList(this.sPlant);
                        break;
                    }
                    catch (Exception ex)
                    {
                        if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                            frmStart.HandleException(ex, false);
                        else this.RefreshSAPGateway();
                    }
                }

                oDoc.LoadXml(this.sRecipientXML);
                oPeople = oDoc.GetElementsByTagName("p");
                this.comboRecipient.Items.Clear();
                this.aUnames.Clear();
                if (oPeople != null)
                {
                    foreach (XmlNode oPerson in oPeople)
                    {
                        this.comboRecipient.Items.Add(oPerson.ChildNodes[1].InnerText);
                        this.aUnames.Add(oPerson.ChildNodes[0].InnerText);
                        if (this.frmParent.SAPUname.Trim().ToUpper() == oPerson.ChildNodes[0].InnerText.Trim().ToUpper() && this.bStores == false)
                        {
                            this.comboRecipient.SelectedIndex = i;
                        }
                        i++;
                    }
                }

            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }

        }
        /// <summary>
        /// Check whether or not the order is locked on SAP by another user
        /// </summary>
        /// <returns></returns>
        private bool CheckLock()
        {

            string sLockedBy = "";
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();

            if (this.oSAPGateway.WOCheckLock(this.sAufnr, ref sLockedBy))
            {
                Cursor.Current = Cursors.Default;
                return true;
            }
            else
            {
                MessageBox.Show("The Order is currently locked by " + sLockedBy + " on SAP and cannot be processed.");
                Cursor.Current = Cursors.Default;
                return false;
            }
        }
        #endregion
        #region General Routines
        public void SetParent(frmStart pfrmParent)
        {
            this.frmParent = pfrmParent;
        }

        public void SetToStores()
        {
            this.bStores = true;
        }

        public void SetToReturn()
        {
            this.bGoodsReturn = true;
        }

        private string GetMovementType()
        {
            if (this.comboMvtType.SelectedIndex == 0) return GOODS_ISSUE;
            else if (this.comboMvtType.SelectedIndex == 1) return GOODS_RETURN;
            else return "";
        }
        /// <summary>
        /// Remove leading zeros from a material number
        /// </summary>
        /// <param name="sMatnr"></param>
        /// <returns></returns>
        private string FormatMatnr(string sMatnr)
        {
            try
            {
                return int.Parse(sMatnr).ToString();
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
                return sMatnr;
            }
        }


        /// <summary>
        /// Clear all for current work order
        /// </summary>
        private void RefreshData()
        {
            this.oItems.Clear();
            this.clnNewEquipment.Clear();
            this.txtWO.Text = "";
            this.txtDocHeader.Text = "";
//            this.lblCurrentWO.Text = "No Work Order selected";
            this.lblStatusBar.Text = "No Work Order selected";
            this.txtRecipient.Text = "";
            this.comboRecipient.Items.Clear();
            this.DefaultRecipient();
            //			this.comboMvtType.SelectedIndex = 0; AJA 03/10/05 - ensure chosen goods mvt remains on selection screen
            this.comboMvtType.Enabled = true;
            this.txtHeaderText.Text = "";
            this.bChanges = false;
            this.comboRecipient.Visible = false;
            this.cmdGetRecipients.Visible = true;
            this.cmdGetRecipients.Enabled = false;
            this.txtWO.Focus();
            this.cmdGetRecipients.BackColor = System.Drawing.Color.LightGray;

            this.dateTimePicker1.Value = DateTime.Today;
        }

        /// <summary>
        /// Default in the recipient as the current user
        /// </summary>
        private void DefaultRecipient()
        {
            if (this.comboRecipient.Items.Count == 0)
            {
                if (this.frmParent.SAPUname != "")
                {
                    this.comboRecipient.Items.Add(this.frmParent.SAPUname);
                    this.comboRecipient.SelectedIndex = 0;
                }
            }
        }
        #endregion		
        #region Menu Routines
        private void mnuiShowLog_Click(object sender, EventArgs e)
        {

/// Display a form with a multiline textbox as dialog to show contents of log file
/// 
            ShowLog = new frmShowLog();

            ShowLog.ShowDialog();
            
        }

        private void mnuiDebugOn_Click(object sender, EventArgs e)
        {
            logger mylog = new logger();
            mylog.makelog("Debug Toggle");

            if (this.mnuiDebugOn.Text == "Debug On")
            {
                if (frmStart.debug == false)
                {
                    frmStart.debug = true;
                    this.mnuiDebugOn.Text = "Debug Off";
                    mylog.makelog("Debug On");
                }
            }
            else
            {
                //debug off

                if (frmStart.debug == true)
                {
                    frmStart.debug = false;
                    this.mnuiDebugOn.Text = "Debug On";
                    mylog.makelog("Debug Off");
                }
            }

        }
        #endregion
        #region Help Links
        private void frmPMGM_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("pmgm");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("pmgm");
        }
        #endregion

        

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void imgDeleteItem_Click_1(object sender, EventArgs e)
        {

        }

        private void txtRecipient_TextChanged(object sender, EventArgs e)
        {
            //bool bReplaced = false;
            this.txtRecipient = frmStart.RemoveScanSuffix(this.txtRecipient);
            this.frmParent.UpdateLastDidSomethingAt();


        }

        
       
    }
}