using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
//using DateTimePickerControl;
using ce5b.SAPGateway;
using System.Xml;
using System.Threading;
using System.Data;
using System.IO;

namespace ce5b
{
    public partial class frmSearch : Form
    {
        public frmPOGR frmParent;
        private SAPGateway.POFunctions oSAPGateway;
        private frmShowLog ShowLog;                         //Debug logging

        public frmSearch()
        {
            #region Start Logger
            logger mylog = new logger();

            //kill log
            if (File.Exists("logfile.txt"))
            {
                File.Delete("logfile.txt");
            }

            mylog.makelog("Starting PO Search");
            #endregion

            InitializeComponent();
        }

        public frmSearch(frmPOGR lfrmParent)
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

            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();
            //
            // TODO: Add any constructor code after InitializeComponent call
            //
            this.frmParent = lfrmParent;
        }

        #region Form events
        private void frmSearch_Load(object sender, System.EventArgs e)
        {
            //set default dates
            
//            this.DateFrom.CustomFormat = "dd/mm/yy";
            this.DateFrom.Value = DateTime.Today.AddDays(-30);
            
//            this.DateTo.CustomFormat = "dd/mm/yy";
            this.DateTo.Value = DateTime.Today;
     
            // Set the Format type and the CustomFormat string.
            
            this.Text = "PO Search";

            //this.labelInfo.Text = "Select the date range (delivery due date).\nAND\\OR Enter the supplier number (look this up using the Look Up button)\n" +
            //                 "AND\\OR Enter the PO number- part thereof or range. * is a wildcard.";
            this.imgCompress.Click += new System.EventHandler(this.imgCompress_Click);
            this.imgExpand.Click += new System.EventHandler(this.imgExpress_Click);

            this.treeResults.Top = 10;
            this.treeResults.Left = 2;
            this.treeResults.Width = this.Width - 4;
            this.treeResults.Height = this.Height - this.treeResults.Top - 5;
             

            System.Drawing.Font oFont = new Font("Courier New", float.Parse("9"), System.Drawing.FontStyle.Regular);

            this.treeResults.Font = oFont;
            this.imgExpand.Left = this.imgCompress.Left;
            this.imgExpand.Top = this.imgCompress.Top;
            Cursor.Current = Cursors.Default;
            Cursor.Show();
            this.RefreshSAPGateway();
//            Thread oThread = new Thread(new ThreadStart(GetPlants));
//            oThread.Start();
            this.GetPlants();
            //this.DTCpicker2.Enabled = true;
            this.cmdSearch.BackColor = System.Drawing.Color.LightGreen;
        }

        private void cmdSearch_Click(object sender, System.EventArgs e)
        {
            XmlDocument xmlPOs = new XmlDocument();
            XmlNodeList xmlItems;

            string sDateFrom = this.DateFrom.Value.Year.ToString();
            //string sDateFrom = this.DateFrom.Value.ToString();
            string sDateTo = this.DateTo.Value.Year.ToString();
            //string sDateTo = this.DateTo.Value.ToString();
            string sLast = "";
            TreeNode oHead = null;

            if (this.comboPlant.Text == "")
            {
                MessageBox.Show("Please select a plant", frmStart.MESSAGE_BOX_TITLE);
                return;
            }
            sDateFrom += (this.DateFrom.Value.Month.ToString().Length == 1) ? "0" + this.DateFrom.Value.Month.ToString() : DateFrom.Value.Month.ToString();
            sDateFrom += (this.DateFrom.Value.Day.ToString().Length == 1) ? "0" + this.DateFrom.Value.Day.ToString() : DateFrom.Value.Day.ToString();

            sDateTo += (this.DateTo.Value.Month.ToString().Length == 1) ? "0" + this.DateTo.Value.Month.ToString() : DateTo.Value.Month.ToString();
            sDateTo += (this.DateTo.Value.Day.ToString().Length == 1) ? "0" + this.DateTo.Value.Day.ToString() : DateTo.Value.Day.ToString();

            if (sDateFrom.CompareTo(sDateTo) > 0)
            {
                MessageBox.Show("Please enter a valid date range", frmStart.MESSAGE_BOX_TITLE);
                return;
            }

            this.HideSearch();
            this.treeResults.Visible = false;
            this.Refresh();
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            string sPlant = (string)this.comboPlant.SelectedValue.ToString();
            sPlant = sPlant.Substring(0, 4);
            string sXML = "";
            for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
            {
                try
                {
                   sXML = this.oSAPGateway.POSearch(sDateFrom, sDateTo, this.txtSupplier.Text.Trim(),
                                this.txtPOFrom.Text.Trim(), this.txtPOTo.Text.Trim(), sPlant);
                    break;
                }
                catch (Exception ex)
                {
                    if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                        frmStart.HandleException(ex, false);
                    else this.RefreshSAPGateway();
                }
            }
            Cursor.Current = Cursors.Default;

            this.treeResults.Nodes.Clear();
            try
            {
                xmlPOs.LoadXml(sXML);
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message, "Error");
            }
            xmlItems = xmlPOs.GetElementsByTagName("po");
            if (xmlItems.Count > 0)
            {
                foreach (XmlElement oNode in xmlItems)
                {
                    if (sLast != oNode.GetAttribute("ebeln"))
                    {
                        if (oHead != null) this.treeResults.Nodes.Add(oHead);
                        oHead = new TreeNode(oNode.GetAttribute("ebeln") + " "
                            + oNode.GetAttribute("name1") + " " + oNode.GetAttribute("bedat"));
                    }

                    oHead.Nodes.Add(oNode.GetAttribute("menge_ch")
                        + " " + oNode.GetAttribute("meins")
                        + " " + oNode.GetAttribute("txz01"));

                    sLast = oNode.GetAttribute("ebeln");
                }
                if (oHead != null) this.treeResults.Nodes.Add(oHead);
                this.treeResults.ExpandAll();
                this.treeResults.Visible = true;
            }
            else
            {
                MessageBox.Show("No Matching POs found", frmStart.MESSAGE_BOX_TITLE);
                this.ShowSearch();
            }

            this.pnlTreeView.Visible = true;
            this.treeResults.ExpandAll();
            this.treeResults.Visible = true;

            this.frmParent.frmParent.UpdateLastDidSomethingAt();

            Cursor.Current = Cursors.Default;
            Cursor.Show();


        }
        private void imgCompress_Click(object sender, System.EventArgs e)
        {
            this.HideSearch();
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        private void imgExpress_Click(object sender, System.EventArgs e)
        {
            this.ShowSearch();
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        private void treeResults_AfterSelect(object sender, System.Windows.Forms.TreeViewEventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            if (this.treeResults != null)
            {
                TreeNode oNode = this.treeResults.SelectedNode;
                if (oNode.Parent != null) oNode = oNode.Parent;
                this.frmParent.txtPO.Text = oNode.Text.Trim().Substring(0, 10);
                this.frmParent.frmParent.UpdateLastDidSomethingAt();
                this.treeResults = null;
                this.Close();
            }
        }

        private void cmdSupplier_Click(object sender, System.EventArgs e)
        {
            frmSupplierSearch frmSupp = new frmSupplierSearch(this);
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
            frmSupp.ShowDialog();
        }

        private void cmdCancel_Click(object sender, System.EventArgs e)
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

        #endregion
        #region General methods
        private void HideSearch()
        {
            this.panelSearchArea.Visible = false;
            //this.panelInfoArea.Visible = false;
            this.imgCompress.Visible = false;
            this.pnlStatusBarBack.Visible = true;
            this.pnlStatusBarFront.Visible = true;
            this.imgExpand.Visible = true;
            this.lblExpComp.Text = "Show search criteria";
            this.lblExpComp.Visible = true;
            this.treeResults.Visible = true;
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        private void ShowSearch()
        {
            this.pnlMain.Visible = true;
            this.panelSearchArea.Visible = true;
            this.pnlSearchFront.Visible = true;
            //this.panelInfoArea.Visible = true;
            this.treeResults.Visible = false;
            this.imgCompress.Visible = true;
            this.imgExpand.Visible = false;
            this.pnlStatusBarBack.Visible = true;
            this.pnlStatusBarFront.Visible = true;
            this.lblExpComp.Text = "Show results";
            this.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        #endregion
        #region SAP/Gateway calls
        private void GetPlants()
        {
            string sXML = "<blank></blank>";

            /* REmoved for now to supress call to web

            for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
            {
                try
                {
                    sXML = this.oSAPGateway.GetPlants();
                    break;
                }
                catch (Exception ex)
                {
                    if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                        frmStart.HandleException(ex, false);
                    else this.RefreshSAPGateway();
                }
            }
            */


            DataSet ds = new DataSet();

            XmlDocument oXML = new XmlDocument();
            oXML.LoadXml(sXML);
            XmlNodeList oPlants = oXML.GetElementsByTagName("p");


            DataTable t = ds.Tables.Add("Plants");
            t.Columns.Add("id", typeof(string));
            t.Columns.Add("name", typeof(string));

            DataRow r;
/*
            foreach (XmlNode oNode in oPlants)
            {
                //this.comboPlant.Items.Add(oNode.Attributes["n"].InnerText + " " + oNode.Attributes["d"].InnerText);


                r = t.NewRow();
                r["id"] = oNode.Attributes["n"].InnerText;
                r["name"] = oNode.Attributes["d"].InnerText;
                t.Rows.Add(r);
            }
 */

//For Niw this is Hard Coded
            
            r = t.NewRow();
            r["id"] = "A001";
            r["name"] = "Wapping";
            t.Rows.Add(r);
            r = t.NewRow();
            r["id"] = "A003";
            r["name"] = "Knowsley";
            t.Rows.Add(r);
            r = t.NewRow();
            r["id"] = "A106";
            r["name"] = "Broxbourne";
            t.Rows.Add(r);
            r = t.NewRow();
            r["id"] = "A107";
            r["name"] = "Knowsley2";
            t.Rows.Add(r);
            r = t.NewRow();
            r["id"] = "A108";
            r["name"] = "Eurocentral";
            t.Rows.Add(r);
            

            // Combobox Databinding
            comboPlant.DataSource = ds;
            comboPlant.DisplayMember = "Plants.name";
            comboPlant.ValueMember = "Plants.id";
        }

        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }
        #endregion
        #region Menu Events
        private void mnuiExit_Click(object sender, EventArgs e)
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
        private void mnuiViewLog_Click(object sender, EventArgs e)
        {
/// Display a form with a multiline textbox as dialog to show contents of log file
/// 

            ShowLog = new frmShowLog();

            ShowLog.ShowDialog();

       }
        #endregion
        #region Help Links
        private void frmSearch_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("search");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("search");
        }
         #endregion

 

    }
}