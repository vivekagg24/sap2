using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Microsoft.Win32;

namespace ce5b
{
    public partial class frmLogon : Form
    {
        private frmStart frmParent;
        private frmShowLog frmShowLog;
        frmStart frmStart = new frmStart();


		public frmLogon(frmStart frmParent)
        {
            string WifiString, HoldString;

            #region Start Logger
            logger mylog = new logger();

            mylog.makelog("Starting Login");
            #endregion

            InitializeComponent();
			this.frmParent = frmParent;

            //save the orinal message
            HoldString = this.frmParent.lblStatusBar.Text;
            
            //check wifi
            int WIFISTATE = (int)Registry.GetValue("HKEY_LOCAL_MACHINE\\System\\State\\Hardware", "WiFi", -1);

            switch (WIFISTATE)
            {
                case 1:
                   WifiString = "WIFI:" + "Off";
                   break;
                case 3:
                   WifiString = "WIFI:" + "Medium";
                   break;
                case 13:
                   WifiString = "WIFI:" + "Good";
                   break;
                default:
                   WifiString = "WIFI:" + "Unknown:" + WIFISTATE ;
                   break;
            }
               
            //display wifi state
            this.frmParent.lblStatusBar.Text = WifiString;
            this.frmParent.lblStatusBar.Update();

            //wait
            System.Threading.Thread.Sleep(4000);

            //replace original message
            this.frmParent.lblStatusBar.Text = HoldString;
            lblStatusBar.Text = this.frmParent.lblStatusBar.Text;
            this.frmParent.lblStatusBar.Update();

            #region Set Debuuger
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
            #endregion
        }
 
        #region Form events
        private void cmdLogon_Click(object sender, System.EventArgs e)
        {
            logger mylog = new logger();

            mylog.makelog("Login");

            HTTPSAPGateway SAPGateway = new HTTPSAPGateway();
            string sMessage = "";

            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();

            if (SAPGateway.CheckLogin(this.txtUname.Text, this.txtPword.Text, out sMessage))
            {
                frmStart frmMain = (frmStart)this.Parent;
                this.frmParent.SAPUname = this.txtUname.Text;
                this.frmParent.SAPPword = this.txtPword.Text;

                this.frmParent.SAPUname = this.txtUname.Text;
                this.frmParent.SAPPword = this.txtPword.Text;

                try
                {
                    this.frmParent.SAPlogontime = new DateTime(DateTime.UtcNow.Ticks);
                    this.Close();
                }
                catch (Exception ex)
                {
                    frmStart.HandleException(ex, true);
                }
            }
            else
            {
                //MessageBox.Show(sMessage, frmStart.MESSAGE_BOX_TITLE);
                if (sMessage == "")
                {
                    this.lblStatusBar.Text = "Cannot Connect";
                }
                else
                {
                    this.lblStatusBar.Text = sMessage;
                }
            }

            SAPGateway = null;
            Cursor.Current = Cursors.Default;
        }

        private void frmLogin_Load(object sender, System.EventArgs e)
        {
            Cursor.Current = Cursors.Default;
            this.txtUname.Text = this.frmParent.SAPUname;
            this.cmdLogon.BackColor = System.Drawing.Color.SteelBlue;
            this.txtUname.Focus();
            this.cmdClear.BackColor = System.Drawing.Color.Red;

//for development
            //this.txtUname.Text = "";
            //this.txtPword.Focus();
        }

        private void txtUname_TextChanged(object sender, System.EventArgs e)
        {
            bool bReplaced = false;
            //Can scan username
            this.txtUname = frmStart.RemoveScanSuffix(this.txtUname, out bReplaced);
            if (bReplaced) this.txtPword.Focus();
        }

        private void txtUname_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)32 || e.KeyChar == (char)13 || sender.ToString().Length == 12)
            {
                // If user types space in Login id or they have typed 12 characters, 
                // assume they want to move to password field.
                this.txtPword.Focus();
            }
        }

        private void txtPword_TextChanged(object sender, System.EventArgs e)
        {
            bool bReplaced = false;
            this.txtPword = frmStart.RemoveScanSuffix(this.txtPword, out bReplaced);
            if (bReplaced)
            {
                cmdLogon_Click(this, new EventArgs());
            }
            else if (this.txtPword.Text.Trim().Length >= 8 && this.txtUname.Text != "")
            {
                cmdLogon_Click(this, new EventArgs());
            }
        }

        private void txtPword_KeyUp(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            //Enter key
            if (e.KeyValue == 13 && this.txtUname.Text != "" && this.txtPword.Text != "")
                cmdLogon_Click(this, new EventArgs());
        }
        /// <summary>
        /// Clear all fields on the form
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdClear_Click(object sender, System.EventArgs e)
        {
            this.txtPword.Text = "";
            this.txtUname.Text = "";
            this.txtUname.Focus();
        }
        #endregion
        #region Menu Events

        private void mnuiViewLog_Click(object sender, EventArgs e)
        {
            /// Display a form with a multiline textbox as dialog to show contents of log file
            /// 
            frmShowLog = new frmShowLog();

            frmShowLog.ShowDialog();

        }

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
        private void frmLogon_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("login");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("login");
        }
        #endregion
    }
}