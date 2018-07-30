using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Reflection;
using System.IO;
using System.Net;
using ce5b.SAPGateway;

namespace ce5b
{
    /// <summary>
    /*
     * *************************************************************************************************
     * This is start form for the whole project(called from program.cs, all other forms are launched from here.
     *  Main functions:
     *
     *	The application defaults to the Live system, the user can select which system to use from the front
     *  menu
     *  Has several static constants used throughout the application - the timeout
     *	for the call to SAP, the barcode scan suffix, the number of retries for connection
     *	failure, and the message box caption for the application.
     *
     *	Also checks the version(set in the assembly file) against the server (CurrentVersionXML)
     *  in the web servers' root directory.
     *
     *	Has several public methods - GetSAPConnection,HandleException,IsConnectionError,
     *  RemoveScanSuffix.
     *
     *	Keeps track of the SAP connection (not actually a connection but just a correct
     *  username and password) and clears it after 180 seconds of inactivity, updating any child forms
     *  with the current login status.
     * *************************************************************************************************
     * 
     * Modifications
     * 
     * The helpfile for the application NIHandheld.htm is attached to the project purely to add it to the 
     * source safe process, it will need to be copied to the Windows folder on the device if it is modified
     * NB: THe attached .htm file will display an error - ignore
     * 
     * The System setting has been moved to an option selectable by the users
     * Added WIFI Status to statusBar
     * moved connection error to status bar
     * moved to VS2008 wm6
     * updates to be migrated by microsd
     */
    /// </summary>
        
    public partial class frmStart : Form
    {
		#region Public constants and static variables
		public static string RUNNING_SYSTEM = "LIVE";				//System DEV, TEST or LIVE
		public static string SERVICE_URL = "";						//URL for the PMwebServices
		public static string MESSAGE_BOX_TITLE = "NI Wireless";
		public static string BARCODE_END  = "*-";					//Suffix denotes the end the barcode scanned
		public static int SOAP_TIMEOUT = 60000;						//timeout for SOAP call
		public static int CONNECTION_RETRIES = 3;					//Number of retries when connection fail
		public bool bLoggedIn = false;
		#endregion
		#region SAP Login details
		public string SAPUname = "";					//SAP user name
		public string SAPPword = "";					//SAP password
		public int TIMEOUT_FOR_SAP_LOGIN = 180;
//        public int TIMEOUT_FOR_SAP_LOGIN = 600;
        public DateTime SAPlogontime;
		#endregion
		#region Private working variables
		private string sSystemText = "";				//Current running system on status bar - eg DEV System
		private DateTime dtLastDidSomethingAt = new DateTime(DateTime.UtcNow.Ticks);
		private string sCurrent = "";
		private string sRunning = "";

        public Exception exout;
		#endregion
		#region Sub forms
		private frmPMGM frmPMGM;							//PM Goods Movement
		private frmStockMenu frmStock;						//Stock Count
        //private frmPOGR frmPOGR;
        private frmShowLog ShowLog;                         //Debug logging
        public static bool debug;
        #endregion

        public frmStart()
        {
            InitializeComponent();
        }

        private void frmStart_Load(object sender, System.EventArgs e)
        {
            #region Start Logger
            logger mylog = new logger();

            //kill log
            if (File.Exists("logfile.txt"))
            {
                File.Delete("logfile.txt");
            }
           
            mylog.makelog("Starting Application");

            mylog.makelog("VersionDate:28.07.10:12:00");

//            if (Program.PlatformType == "SYMBOL WinCE")
//            {
//                mylog.makelog("CE5 Device");
//            }
//            else
//            {
////At the moment the CE5 guns will be updated manually so the version check is temporarily disabled
//                this.CheckVersion();
//                mylog.makelog("PPC Device");
//            }

            #endregion

            this.cmdExit.BackColor = System.Drawing.Color.Red;
            this.cmdPMGI.BackColor = System.Drawing.Color.LightGreen;
            this.cmdPMGR.BackColor = System.Drawing.Color.LightGreen;
            this.cmdStockCount.BackColor = System.Drawing.Color.LightGreen;
                   

            //define the default starting system
            SetSystem("LIVE");
            
        }
        #region Launch Forms
        //call Workorder Goods Issue via Login
        private void cmdPMGI_Click(object sender, System.EventArgs e)
        {
            logger mylog = new logger();
            
            mylog.makelog("Calling PMGM");
            
            frmPMGM = new frmPMGM();
            frmPMGM.SetParent(this);

            UpdateLastDidSomethingAt();
            
            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                frmPMGM.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                HandleException(ex, true);
            }

            frmPMGM = null;
            this.Refresh();
        }

        //Call Purchasing Receipt via login
        private void cmdPMGR_Click(object sender, System.EventArgs e)
        {
            logger mylog = new logger();
            
            mylog.makelog("Calling PMGR");

            frmPMGM = new frmPMGM();
            frmPMGM.SetParent(this);
            frmPMGM.SetToReturn();

            UpdateLastDidSomethingAt();
            try
            {
                Cursor.Current = Cursors.WaitCursor;
                Cursor.Show();
                frmPMGM.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                HandleException(ex, true);
            }

            frmPMGM = null;
            this.Refresh();
        }

        //Call Inventory functions via Login
        private void cmdStockCount_Click(object sender, System.EventArgs e)
        {
            logger mylog = new logger();
            
            mylog.makelog("Calling INV");

            frmStock = new frmStockMenu(this);

            frmStock.SetParent(this);
            
            UpdateLastDidSomethingAt();
            try
            {
                frmStock.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                HandleException(ex, true);
            }

            frmStock = null;
            this.Refresh();
        }
        #endregion
        #region Timer and misc
        /// <summary>
        /// Timer to check the inactivity before clearing out the current logged in user's details
        /// Update the status bar with the number of seconds until timeout
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void timerLogout_Tick(object sender, System.EventArgs e)
        {
            long iElapsed = ((DateTime.UtcNow.Ticks - this.dtLastDidSomethingAt.Ticks) / System.TimeSpan.TicksPerSecond);

            if (iElapsed > this.TIMEOUT_FOR_SAP_LOGIN)
            {
                this.SAPPword = "";
                this.mnuiLogon.Enabled = true;
                this.mnuiLogOnOff.Enabled = false;
                this.bLoggedIn = false;

                //kill log
                if (File.Exists("logfile.txt"))
                {
                    File.Delete("logfile.txt");
                }

            }
            if (this.SAPPword != "" && this.SAPUname != "")
            {
                this.lblStatusBar.Text = RUNNING_SYSTEM + " : " + this.SAPUname + " :" + (this.TIMEOUT_FOR_SAP_LOGIN - iElapsed) + " secs";
                this.mnuiLogon.Enabled = false;
                this.mnuiLogOnOff.Enabled = true;
                this.bLoggedIn = true;
            }
            else
            {
                if (debug != false)
                {
                    this.lblStatusBar.Text = "Not connected - " + "DEBUG";
                }
                else
                {
                    this.lblStatusBar.Text = "Not connected - " + RUNNING_SYSTEM;
                }

                this.mnuiLogon.Enabled = true;
                this.mnuiLogOnOff.Enabled = false;
                this.bLoggedIn = false;
            }
        }
        private void lblStatusBar_TextChanged(object sender, System.EventArgs e)
        {
            if (this.frmPMGM != null) { this.frmPMGM.lblStatusBar.Text = this.lblStatusBar.Text; }
            if (this.frmStock != null) { this.frmStock.lblStatusBar.Text = this.lblStatusBar.Text; }
            //if (this.frmPOGR != null) { this.frmPOGR.lblStatusBar.Text = this.lblStatusBar.Text; }
        }
        private void cmdExit_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                HandleException(ex, true);
            }
        }
        #endregion
   		#region Menu events
		private void mnuiClose_Click(object sender, System.EventArgs e)
		{
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                HandleException(ex, true);
            }
        }

		private void mnuiAbout_Click(object sender, System.EventArgs e)
		{
			MessageBox.Show("Latest version on server is " + this.sCurrent + ".\nThe version currently running on this handheld is " + this.sRunning + ".", "About");
		}

		private void mnuiLogon_Click(object sender, System.EventArgs e)
		{
			string sMess = "";
			if (!this.GetSAPConnection(ref sMess))
			{
				MessageBox.Show(sMess, MESSAGE_BOX_TITLE);
			}
			else
			{
				this.UpdateLastDidSomethingAt();
			}
		}

		private void mnuiLogoff_Click(object sender, System.EventArgs e)
		{
			this.LogoffSAP();
		}

        private void mnuiDebug_Click(object sender, EventArgs e)
        {
            SetSystem("DEV");
        }

        private void mnuiTest_Click(object sender, EventArgs e)
        {
            SetSystem("TEST");
        }

        private void mnuiCopy_Click(object sender, EventArgs e)
        {
            SetSystem("COPY");
        }
        private void mnuiLive_Click(object sender, EventArgs e)
        {

            SetSystem("LIVE");
        }

        private void mnuiR31_Click(object sender, EventArgs e)
        {

            SetSystem("R31");
        }





        private void mnuiChangeSystem_Click(object sender, EventArgs e)
        {
            cmdPMGI.Enabled = false;
            cmdPMGR.Enabled = false;
            cmdStockCount.Enabled = false;
        }

        private void mnuiViewLog_Click(object sender, EventArgs e)
        {
            /// Display a form with a multiline textbox as dialog to show contents of log file
            /// 
            ShowLog = new frmShowLog();

            ShowLog.ShowDialog();
        }
        #endregion
        #region Static Methods
        public static void HandleException(Exception ex, bool bIgnore)
        {
            if (!bIgnore)
            {
                logger mylog = new logger();
                
                mylog.makelog(ex.Message);

                string sMess = ex.Message;
                if (IsConnectionError(ex))
                {
                    sMess += "\nPlease try again as the network connection may have been temporarily lost.";
                    //MessageBox.Show(sMess, MESSAGE_BOX_TITLE);
                    mylog.makelog(ex.Message);
                    mylog.makelog(sMess);
                }
                else
                {
                    sMess = "Unknown Error-See Log";
                    mylog.makelog(ex.Message);
                }
                
            }
        }
        public static void HandleException(Exception ex, string sBoxTitle, bool bIgnore)
        {
            if (!bIgnore)
            {
                logger mylog = new logger();
                
                mylog.makelog(ex.Message);

                string sMess = ex.Message;
                if (IsConnectionError(ex))
                {
                    sMess += "\nPlease try again as the network connection may have been temporarily lost.";
                    //MessageBox.Show(sMess, sBoxTitle);
                    mylog.makelog(ex.Message);
                    mylog.makelog(sMess);
                }
                else
                {
                    mylog.makelog(ex.Message);
                }


            }
        }
        /// <summary>
        /// Remove the suffix that denootes the end of the scanned barcode
        /// </summary>
        /// <param name="txtInput">text input field</param>
        /// <returns></returns>
        public static TextBox RemoveScanSuffix(TextBox txtInput)
        {
            txtInput.Text = txtInput.Text.Replace(BARCODE_END, "");
            return txtInput;
        }
        public static TextBox RemoveScanSuffix(TextBox txtInput, out bool bReplaced)
        {
            bReplaced = false;
            string sOrig = txtInput.Text;
            txtInput.Text = txtInput.Text.Replace(BARCODE_END, "");
            if (sOrig != txtInput.Text) bReplaced = true;
            return txtInput;
        }
        public static string RemoveScanSuffix(string strInput)
        {
            strInput = strInput.Replace(BARCODE_END, "");
            return strInput;
        }
        /// <summary>
        /// Is an exception a SOAP connection error ?
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        public static bool IsConnectionError(Exception ex)
        {
            if (ex.Message.Trim().ToLower().IndexOf("transport connection", 0) >= 0) return true;
            else return false;
        }
        #endregion
        #region Public instance methods
        /// <summary>
        /// Logoff SAP -really just clears out the valid user name and password
        /// </summary>
        public void LogoffSAP()
        {
            this.SAPPword = "";
            this.lblStatusBar.Text = "Not connected";
            this.mnuiLogon.Enabled = true;
            this.mnuiLogOnOff.Enabled = false;
            this.bLoggedIn = false;
            this.SAPUname = "";
        }
        /// <summary>
        /// Launch SAP login form to get a valid user name an password
        /// for subsequent passing to functions that require non-generic SAP login
        /// </summary>
        /// <param name="sError"></param>
        /// <returns></returns>
        public bool GetSAPConnection(ref string sError)
        {
            logger mylog = new logger();
            mylog.makelog("Calling Login");
            
            frmLogon frmLogin = new frmLogon(this);
            this.SAPPword = "";
            this.SAPUname = "";
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();
            frmLogin.ShowDialog();

            if (this.SAPPword != "" && this.SAPUname != "")
            {
                this.lblStatusBar.Text = this.sSystemText + "Connected as " + this.SAPUname;
                this.UpdateLastDidSomethingAt();
                this.mnuiLogon.Enabled = false;
                this.mnuiLogOnOff.Enabled = true;
                this.bLoggedIn = true;
                return true;
            }
            else
            {
                this.mnuiLogOnOff.Enabled = false;
                this.mnuiLogon.Enabled = true;
                this.bLoggedIn = false;
                sError = "Please enter a user name and password";
                return false;
            }
        }
        public void UpdateLastDidSomethingAt()
        {
            this.dtLastDidSomethingAt = new DateTime(DateTime.UtcNow.Ticks);
        }
        #endregion
        #region Version Checking and Which System Code
        /// <summary>
        /// Warns the user if the version in the assembly file does not match
        /// the version on the web servers' CurrentVersionXML
        /// </summary>
        private void CheckVersion()
        {
            logger mylog = new logger();

            mylog.makelog("Calling CheckVersion");

            this.lblStatusBar.Text = "Checking Version..";
            this.lblStatusBar.Update();

            Type t = typeof(ce5b.frmStart);
            HTTPSAPGateway oGateway = new HTTPSAPGateway();
            this.sCurrent = oGateway.GetCurrentVersion().Trim();
            this.sRunning = t.Assembly.GetName().Version.ToString().Trim();
            
            //if (this.sCurrent != this.sRunning)
            //{

            //    if (Program.PlatformType == "SYMBOL WinCE")
            //    {
            //        string sWarn = "The application is not the current version.\n " +
            //            "Please Close Application and Download latest version via link";
            //        MessageBox.Show(sWarn, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1);
            //        this.lblStatusBar.Text = "Incorrect Version :" + sCurrent;
            //    }
            //    else
            //    {
            //        string sWarn = "The application is not the current version.\n " +
            //            "Please Close Application and Download latest version via link";
            //        MessageBox.Show(sWarn, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1);
            //        this.lblStatusBar.Text = "Incorrect Version :" + sCurrent;
            //    }
            //}
            //else
            //{
            //    this.lblStatusBar.Text = "Checked Version :" + sCurrent;
            //}
            
            this.lblStatusBar.Update();

            mylog.makelog("Exit Check Version");
            mylog.makelog(this.sCurrent);
        }
        #endregion
        
        private void SetSystem(string SystemName)
        {
            logger mylog = new logger();
            
            mylog.makelog("SetSystem:" + SystemName);

            if(SystemName=="Debug")
            
            cmdPMGI.Enabled = false;
            cmdPMGR.Enabled = false;
            cmdStockCount.Enabled = false;

            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();

            this.Refresh();

            if (SystemName != "LIVE")
            {
//go to DEV, TEST etc
                SERVICE_URL = "http://nisapwireless/PMWebServices" + SystemName + "/POFunctions.asmx";
            }
            else
//go to LIVE
            {
                SERVICE_URL = "http://nisapwireless/PMWebServices/POFunctions.asmx";
            }

            this.sSystemText = SystemName + " SYSTEM ";
            RUNNING_SYSTEM = SystemName; ;
            LogoffSAP();
            this.Refresh();

            Cursor.Current = Cursors.Default;

            cmdPMGI.Enabled = true;
            cmdPMGR.Enabled = true;
            cmdStockCount.Enabled = true;

        }

        #region Help Links
        private void frmStart_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("main");
        }
        private void menuItem1_Click(object sender, EventArgs e)
        {
            
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("main");
        }
        #endregion

        private void menuItemDebug_Click(object sender, EventArgs e)
        {
            logger mylog = new logger();
            mylog.makelog("Debug Toggle");

            if (this.menuItemDebug.Text == "Debug On")
            {
                if (frmStart.debug == false)
                {
                    frmStart.debug = true;
                    this.menuItemDebug.Text = "Debug Off";
                    mylog.makelog("Debug On");
                }
            }
            else
            {
                //debug off

                if (frmStart.debug == true)
                {
                    frmStart.debug = false;
                    this.menuItemDebug.Text = "Debug On";
                    mylog.makelog("Debug Off");
                }
            }

        }

        private void pnlMainFront_GotFocus(object sender, EventArgs e)
        {

        }

        private void lblNIWireless_ParentChanged(object sender, EventArgs e)
        {

        }

        private void pnlWirelessLogo_GotFocus(object sender, EventArgs e)
        {

        }

        private void lblStatusBar_ParentChanged(object sender, EventArgs e)
        {

        }
    }
}