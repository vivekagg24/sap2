using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ce5b.SAPGateway;

namespace ce5b
{
    public partial class frmStockMenu : Form
    {
        public frmStart frmParent;       
        private frmPOGR frmPOGR;							//Goods receipt
        private frmPMGM frmStoreIssue;    
        private frmCountByDocument frmStock;
        private SAPGateway.POFunctions oSAPGateway;			//SOAP Services provided by the gateway server
        private frmStockCountStart frmBlind;

       public frmStockMenu(frmStart pfrmParent)

        {
            InitializeComponent();
            this.frmParent = pfrmParent;

            this.lblStatusBar.Text = frmParent.lblStatusBar.Text;

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

        #region Form events
        private void frmStockMenu_Load(object sender, System.EventArgs e)
        {
            // Extend their timeout to 5 minutes.
//            this.frmParent.TIMEOUT_FOR_SAP_LOGIN = 300;
//            this.frmParent.TIMEOUT_FOR_SAP_LOGIN = 60;

            if (this.frmParent.bLoggedIn == true)
            {
                this.mnuiLogon.Enabled = false;
                this.mnuiLogoff.Enabled = true;
            }
            else
            {
                this.mnuiLogon.Enabled = true;
                this.mnuiLogoff.Enabled = false;
            }
            this.btnCount.BackColor = System.Drawing.Color.LightGreen;
            this.btnIssue.BackColor = System.Drawing.Color.LightGreen;
            this.btnPOGR.BackColor = System.Drawing.Color.LightGreen;
            this.blndstck.BackColor = System.Drawing.Color.LightGreen;

            string sError = "";

            this.lblStatusBar.Text = this.frmParent.lblStatusBar.Text;

            if (this.frmParent.SAPPword == "" || this.frmParent.SAPUname == "")
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
                this.mnuiLogoff.Enabled = false;
                this.mnuiLogon.Enabled = true;
            }
            //Setup SAP call
            this.RefreshSAPGateway();

        }
        public void SetParent(frmStart pfrmParent)
        {
            this.frmParent = pfrmParent;
        }

        private void btnCount_Click(object sender, System.EventArgs e)
        { 
   //         this.frmParent.UpdateLastDidSomethingAt();
            this.frmStock = new frmCountByDocument(this);
                       
            //UpdateLastDidSomethingAt();
            try
            {
//                Cursor.Current = Cursors.WaitCursor;
//                Cursor.Show();
                this.frmStock.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                frmStart.HandleException(ex, true);
            }

            this.frmStock = null;
            this.Refresh();
        }

        private void btnIssue_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            this.frmStoreIssue = new frmPMGM();
            this.frmStoreIssue.SetParent(this.frmParent);
            this.frmStoreIssue.SetToStores();

            //UpdateLastDidSomethingAt();
            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                this.frmStoreIssue.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                frmStart.HandleException(ex, true);
            }

            this.frmStoreIssue = null;
            this.Refresh();
        }

        private void btnPOGR_Click(object sender, System.EventArgs e)
        {
            this.frmPOGR = new frmPOGR(this.frmParent);
            this.frmParent.UpdateLastDidSomethingAt();

            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                this.frmPOGR.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                frmStart.HandleException(ex, true);
            }

            this.frmPOGR = null;
            this.Refresh();
        }
        #endregion
        #region Menu Events

        private void mnuiExit_Click(object sender, System.EventArgs e)
        {
            // Set the timeout back to the usual 3 minutes.
//            this.frmParent.TIMEOUT_FOR_SAP_LOGIN = 180;
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
            }
        }

        private void mnuiLogoff_Click(object sender, System.EventArgs e)
        {
            this.frmParent.UpdateLastDidSomethingAt();
            this.frmParent.LogoffSAP();
            this.mnuiLogon.Enabled = true;
            this.mnuiLogoff.Enabled = false;
        }

        private void mnuiShowLog_Click(object sender, EventArgs e)
        {

            /// Display a form with a multiline textbox as dialog to show contents of log file
            /// 
            frmShowLog ShowLog = new frmShowLog();

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
        #region SAP Logon
        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }
        #endregion

        private void pnlMainFront_GotFocus(object sender, EventArgs e)
        {

        }

        private void lblStatusBar_ParentChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.frmBlind = new frmStockCountStart(this);
            this.frmBlind.ShowDialog();
        }

       
    }
}