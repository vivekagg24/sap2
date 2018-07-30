using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using ce5b.SAPGateway;

namespace ce5b
{
    public partial class frmSupplierSearch : Form
    {
        private frmSearch frmParent;
        private DataSet ds;
        private System.Data.DataTable oItems;
        private SAPGateway.POFunctions oSAPGateway;

        public frmSupplierSearch(frmSearch lfrmParent)
        {
            #region Start Logger
            logger mylog = new logger();

            mylog.makelog("Starting Supplier Search");
            #endregion

            InitializeComponent();
            this.frmParent = lfrmParent;
        }
        #region Form events
        private void cmdSearch_Click(object sender, System.EventArgs e)
        {
            XmlDocument xmlRes = new XmlDocument();
            XmlNodeList xmlItems;
            DataRow oTableRow;
            string sXML = "";
            this.frmParent.frmParent.frmParent.UpdateLastDidSomethingAt();
            if (this.txtName.Text.Trim() != "" || this.txtPCode.Text.Trim() != "")
            {
                this.oItems.Clear();
                this.HideSearch();
                this.listResults.Visible = false;
                this.Refresh();
              Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();

                for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                {
                    try
                    {
                        sXML = this.oSAPGateway.SupplierSearch(this.txtName.Text, this.txtPCode.Text);
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
                xmlRes.LoadXml(sXML);
                xmlItems = xmlRes.GetElementsByTagName("s");
                if (xmlItems.Count > 0)
                {
                    foreach (XmlElement oNode in xmlItems)
                    {
                        oTableRow = this.oItems.NewRow();
                        oTableRow["lifnr"] = oNode.GetElementsByTagName("lifnr").Item(0).InnerText;
                        oTableRow["name1"] = oNode.GetElementsByTagName("name1").Item(0).InnerText;
                        oTableRow["name4"] = oNode.GetElementsByTagName("name4").Item(0).InnerText;
                        oTableRow["pstlz"] = oNode.GetElementsByTagName("pstlz").Item(0).InnerText;
                        this.oItems.Rows.Add(oTableRow);
                    }
                    this.listResults.Visible = true;
                }
                else MessageBox.Show("No supplier found", frmStart.MESSAGE_BOX_TITLE);
            }
            else MessageBox.Show("Please enter search criteria.", frmStart.MESSAGE_BOX_TITLE);
        }

        private void frmSupplierSearch_Load(object sender, System.EventArgs e)
        {
            this.imgCompress.Click += new System.EventHandler(this.imgCompress_Click);
            this.imgExpand.Click += new System.EventHandler(this.imgExpress_Click);

            this.listResults.Top = 75;
            this.listResults.Left = 2;
            this.listResults.Width = this.Width - 4;
            this.listResults.Height = this.Height - this.listResults.Top - 5;

            System.Drawing.Font oFont = new Font("Courier New", float.Parse("8.25"), System.Drawing.FontStyle.Regular);

            this.listResults.Font = oFont;
            this.imgExpand.Left = this.imgCompress.Left;
            this.imgExpand.Top = this.imgCompress.Top;
            this.BuildGrid();
            Cursor.Current = Cursors.Default;
            Cursor.Show();
            this.RefreshSAPGateway();
        }

        private void imgCompress_Click(object sender, System.EventArgs e)
        {
            this.HideSearch();
            this.frmParent.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        private void imgExpress_Click(object sender, System.EventArgs e)
        {
            this.ShowSearch();
            this.frmParent.frmParent.frmParent.UpdateLastDidSomethingAt();
        }
        private void listResults_Click(object sender, System.EventArgs e)
        {
            Point pt = this.listResults.PointToClient(Control.MousePosition);
            DataGrid.HitTestInfo hti = this.listResults.HitTest(pt.X, pt.Y);

            if (hti.Row >= 0)
            {
                this.frmParent.txtSupplier.Text = (string)this.oItems.Rows[this.listResults.CurrentCell.RowNumber][0];
                try
                {
                    this.Close();
                }
                catch (Exception ex)
                {
                    frmStart.HandleException(ex, true);
                }
            }
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
            this.pnlMiddleBack.Visible = false;
            this.listResults.Visible = true;
            this.imgCompress.Visible = false;
            this.imgExpand.Visible = true;
            this.pnlTopFront.Visible = true;
            this.pnlTobBack.Visible = true;
            this.lblExpComp.Text = "Show search criteria";
            this.lblExpComp.Visible = true;
        }
        private void ShowSearch()
        {
            this.pnlMiddleBack.Visible = true;
            this.listResults.Visible = false;
            this.imgCompress.Visible = true;
            this.imgExpand.Visible = false;
            this.pnlTopFront.Visible = true;
            this.pnlTobBack.Visible = true;
            this.lblExpComp.Text = "Hide search criteria";
        }

        private void BuildGrid()
        {
            // Create data set
            this.ds = new DataSet("Dataset");
            // Add a table

            this.oItems = this.ds.Tables.Add("Items");

            this.oItems.Columns.Add("lifnr", typeof(string));
            this.oItems.Columns.Add("name1", typeof(string));
            this.oItems.Columns.Add("name4", typeof(string));
            this.oItems.Columns.Add("pstlz", typeof(string));

            DataGridTableStyle ts = new DataGridTableStyle();
            ts.MappingName = "Items";

            DataGridTextBoxColumn cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Suppl.";
            cs.MappingName = "lifnr";
            cs.Width = 50;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Name";
            cs.MappingName = "name1"; // Data column name
            cs.Width = 100;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Town";
            cs.MappingName = "name4"; // Data column name
            cs.Width = 80;
            ts.GridColumnStyles.Add(cs);

            cs = new DataGridTextBoxColumn();
            cs.HeaderText = "Post Code";
            cs.MappingName = "pstlz"; // Data column name
            cs.Width = 70;
            ts.GridColumnStyles.Add(cs);

            this.listResults.TableStyles.Add(ts);
            this.listResults.DataSource = this.oItems;
        }
        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }
        #endregion
        #region Help Links
        private void frmSupplierSearch_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("supsearch");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("supsearch");
        }
        #endregion

        private void menuItem1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

    }
}

