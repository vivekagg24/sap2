namespace ce5b
{
    partial class frmStart
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.PictureBox imgPresses;
        private System.Windows.Forms.Panel pnlMainFront;
        private System.Windows.Forms.Button cmdPMGI;
        private System.Windows.Forms.Button cmdStockCount;
        private System.Windows.Forms.Timer timerLogout;
        private System.Windows.Forms.MainMenu mnuMain;
        private System.Windows.Forms.MenuItem mnuiFile;
        private System.Windows.Forms.MenuItem mnuiClose;
        private System.Windows.Forms.Panel pnlMainBack;
        private System.Windows.Forms.Panel pnlWirelessLogo;
        private System.Windows.Forms.MenuItem mnuiLogOnOff;
        private System.Windows.Forms.MenuItem mnuiLogon;
        private System.Windows.Forms.MenuItem mnuiAbout;
        private System.Windows.Forms.Button cmdPMGR;
        private System.Windows.Forms.Button cmdExit;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmStart));
            this.mnuMain = new System.Windows.Forms.MainMenu();
            this.menuItem2 = new System.Windows.Forms.MenuItem();
            this.menuItem3 = new System.Windows.Forms.MenuItem();
            this.mnuiFile = new System.Windows.Forms.MenuItem();
            this.mnuiLogOnOff = new System.Windows.Forms.MenuItem();
            this.mnuiLogon = new System.Windows.Forms.MenuItem();
            this.mnuiAbout = new System.Windows.Forms.MenuItem();
            this.mnuiClose = new System.Windows.Forms.MenuItem();
            this.mnuiChangeSystem = new System.Windows.Forms.MenuItem();
            this.mnuiDevelopment = new System.Windows.Forms.MenuItem();
            this.mnuiTest = new System.Windows.Forms.MenuItem();
            this.mnuiCopy = new System.Windows.Forms.MenuItem();
            this.mnuiLive = new System.Windows.Forms.MenuItem();
            this.mnuiViewLog = new System.Windows.Forms.MenuItem();
            this.menuItem1 = new System.Windows.Forms.MenuItem();
            this.menuItemDebug = new System.Windows.Forms.MenuItem();
            this.cmdPMGR = new System.Windows.Forms.Button();
            this.pnlMainFront = new System.Windows.Forms.Panel();
            this.cmdStockCount = new System.Windows.Forms.Button();
            this.cmdPMGI = new System.Windows.Forms.Button();
            this.imgNILogo = new System.Windows.Forms.PictureBox();
            this.pnlWirelessLogo = new System.Windows.Forms.Panel();
            this.cmdExit = new System.Windows.Forms.Button();
            this.timerLogout = new System.Windows.Forms.Timer();
            this.pnlMainBack = new System.Windows.Forms.Panel();
            this.lblStatusBar = new System.Windows.Forms.Label();
            this.imgPresses = new System.Windows.Forms.PictureBox();
            this.lblStatusBarBack = new System.Windows.Forms.Label();
            this.pnlStatusBarFront = new System.Windows.Forms.Panel();
            this.pnlMainFront.SuspendLayout();
            this.pnlWirelessLogo.SuspendLayout();
            this.pnlStatusBarFront.SuspendLayout();
            this.SuspendLayout();
            // 
            // mnuMain
            // 
            this.mnuMain.MenuItems.Add(this.menuItem2);
            this.mnuMain.MenuItems.Add(this.mnuiFile);
            // 
            // menuItem2
            // 
            this.menuItem2.MenuItems.Add(this.menuItem3);
            this.menuItem2.Text = "";
            // 
            // menuItem3
            // 
            this.menuItem3.Text = "test";
            // 
            // mnuiFile
            // 
            this.mnuiFile.MenuItems.Add(this.mnuiLogOnOff);
            this.mnuiFile.MenuItems.Add(this.mnuiLogon);
            this.mnuiFile.MenuItems.Add(this.mnuiAbout);
            this.mnuiFile.MenuItems.Add(this.mnuiClose);
            this.mnuiFile.MenuItems.Add(this.mnuiChangeSystem);
            this.mnuiFile.MenuItems.Add(this.mnuiViewLog);
            this.mnuiFile.MenuItems.Add(this.menuItem1);
            this.mnuiFile.MenuItems.Add(this.menuItemDebug);
            this.mnuiFile.Text = "Functions ";
            // 
            // mnuiLogOnOff
            // 
            this.mnuiLogOnOff.Text = "Logoff SAP";
            this.mnuiLogOnOff.Click += new System.EventHandler(this.mnuiLogoff_Click);
            // 
            // mnuiLogon
            // 
            this.mnuiLogon.Text = "Logon to SAP";
            this.mnuiLogon.Click += new System.EventHandler(this.mnuiLogon_Click);
            // 
            // mnuiAbout
            // 
            this.mnuiAbout.Text = "About";
            this.mnuiAbout.Click += new System.EventHandler(this.mnuiAbout_Click);
            // 
            // mnuiClose
            // 
            this.mnuiClose.Text = "Exit";
            this.mnuiClose.Click += new System.EventHandler(this.mnuiClose_Click);
            // 
            // mnuiChangeSystem
            // 
            this.mnuiChangeSystem.Enabled = false;
            this.mnuiChangeSystem.MenuItems.Add(this.mnuiDevelopment);
            this.mnuiChangeSystem.MenuItems.Add(this.mnuiTest);
            this.mnuiChangeSystem.MenuItems.Add(this.mnuiCopy);
            this.mnuiChangeSystem.MenuItems.Add(this.mnuiLive);
            this.mnuiChangeSystem.Text = "Change System";
            this.mnuiChangeSystem.Click += new System.EventHandler(this.mnuiChangeSystem_Click);
            // 
            // mnuiDevelopment
            // 
            this.mnuiDevelopment.Enabled = false;
            this.mnuiDevelopment.Text = "Dev";
            this.mnuiDevelopment.Click += new System.EventHandler(this.mnuiDebug_Click);
            // 
            // mnuiTest
            // 
            this.mnuiTest.Enabled = false;
            this.mnuiTest.Text = "Test";
            this.mnuiTest.Click += new System.EventHandler(this.mnuiTest_Click);
            // 
            // mnuiCopy
            // 
            this.mnuiCopy.Enabled = false;
            this.mnuiCopy.Text = "Copy";
            this.mnuiCopy.Click += new System.EventHandler(this.mnuiCopy_Click);
            // 
            // mnuiLive
            // 
            this.mnuiLive.Enabled = false;
            this.mnuiLive.Text = "Live";
            this.mnuiLive.Click += new System.EventHandler(this.mnuiLive_Click);
            // 
            // mnuiViewLog
            // 
            this.mnuiViewLog.Text = "View Log";
            this.mnuiViewLog.Click += new System.EventHandler(this.mnuiViewLog_Click);
            // 
            // menuItem1
            // 
            this.menuItem1.Text = "Help";
            this.menuItem1.Click += new System.EventHandler(this.menuItem1_Click);
            // 
            // menuItemDebug
            // 
            this.menuItemDebug.Text = "Debug On";
            this.menuItemDebug.Click += new System.EventHandler(this.menuItemDebug_Click);
            // 
            // cmdPMGR
            // 
            this.cmdPMGR.Location = new System.Drawing.Point(10, 86);
            this.cmdPMGR.Name = "cmdPMGR";
            this.cmdPMGR.Size = new System.Drawing.Size(205, 24);
            this.cmdPMGR.TabIndex = 2;
            this.cmdPMGR.Text = "Goods Return to Work Order";
            this.cmdPMGR.Click += new System.EventHandler(this.cmdPMGR_Click);
            // 
            // pnlMainFront
            // 
            this.pnlMainFront.BackColor = System.Drawing.Color.White;
            this.pnlMainFront.Controls.Add(this.cmdStockCount);
            this.pnlMainFront.Controls.Add(this.cmdPMGI);
            this.pnlMainFront.Controls.Add(this.cmdPMGR);
            this.pnlMainFront.Controls.Add(this.imgNILogo);
            this.pnlMainFront.Controls.Add(this.pnlWirelessLogo);
            this.pnlMainFront.Location = new System.Drawing.Point(8, 29);
            this.pnlMainFront.Name = "pnlMainFront";
            this.pnlMainFront.Size = new System.Drawing.Size(224, 151);
            this.pnlMainFront.GotFocus += new System.EventHandler(this.pnlMainFront_GotFocus);
            // 
            // cmdStockCount
            // 
            this.cmdStockCount.Location = new System.Drawing.Point(10, 116);
            this.cmdStockCount.Name = "cmdStockCount";
            this.cmdStockCount.Size = new System.Drawing.Size(205, 24);
            this.cmdStockCount.TabIndex = 0;
            this.cmdStockCount.Text = "Inventory";
            this.cmdStockCount.Click += new System.EventHandler(this.cmdStockCount_Click);
            // 
            // cmdPMGI
            // 
            this.cmdPMGI.Location = new System.Drawing.Point(10, 56);
            this.cmdPMGI.Name = "cmdPMGI";
            this.cmdPMGI.Size = new System.Drawing.Size(205, 24);
            this.cmdPMGI.TabIndex = 1;
            this.cmdPMGI.Text = "Goods Issue to Work Order";
            this.cmdPMGI.Click += new System.EventHandler(this.cmdPMGI_Click);
            // 
            // imgNILogo
            // 
            this.imgNILogo.Image = ((System.Drawing.Image)(resources.GetObject("imgNILogo.Image")));
            this.imgNILogo.Location = new System.Drawing.Point(9, 11);
            this.imgNILogo.Name = "imgNILogo";
            this.imgNILogo.Size = new System.Drawing.Size(163, 35);
            this.imgNILogo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            // 
            // pnlWirelessLogo
            // 
            this.pnlWirelessLogo.BackColor = System.Drawing.Color.White;
            this.pnlWirelessLogo.Controls.Add(this.cmdExit);
            this.pnlWirelessLogo.Location = new System.Drawing.Point(173, 2);
            this.pnlWirelessLogo.Name = "pnlWirelessLogo";
            this.pnlWirelessLogo.Size = new System.Drawing.Size(44, 48);
            this.pnlWirelessLogo.GotFocus += new System.EventHandler(this.pnlWirelessLogo_GotFocus);
            // 
            // cmdExit
            // 
            this.cmdExit.Location = new System.Drawing.Point(2, 14);
            this.cmdExit.Name = "cmdExit";
            this.cmdExit.Size = new System.Drawing.Size(40, 24);
            this.cmdExit.TabIndex = 0;
            this.cmdExit.Text = "EXIT";
            this.cmdExit.Click += new System.EventHandler(this.cmdExit_Click);
            // 
            // timerLogout
            // 
            this.timerLogout.Enabled = true;
            this.timerLogout.Interval = 10000;
            this.timerLogout.Tick += new System.EventHandler(this.timerLogout_Tick);
            // 
            // pnlMainBack
            // 
            this.pnlMainBack.BackColor = System.Drawing.Color.Black;
            this.pnlMainBack.Location = new System.Drawing.Point(7, 28);
            this.pnlMainBack.Name = "pnlMainBack";
            this.pnlMainBack.Size = new System.Drawing.Size(226, 153);
            // 
            // lblStatusBar
            // 
            this.lblStatusBar.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Bold);
            this.lblStatusBar.Location = new System.Drawing.Point(0, 0);
            this.lblStatusBar.Name = "lblStatusBar";
            this.lblStatusBar.Size = new System.Drawing.Size(236, 20);
            this.lblStatusBar.Text = "Not Connected";
            this.lblStatusBar.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.lblStatusBar.ParentChanged += new System.EventHandler(this.lblStatusBar_ParentChanged);
            // 
            // imgPresses
            // 
            this.imgPresses.Image = ((System.Drawing.Image)(resources.GetObject("imgPresses.Image")));
            this.imgPresses.Location = new System.Drawing.Point(1, 187);
            this.imgPresses.Name = "imgPresses";
            this.imgPresses.Size = new System.Drawing.Size(240, 54);
            // 
            // lblStatusBarBack
            // 
            this.lblStatusBarBack.BackColor = System.Drawing.Color.WhiteSmoke;
            this.lblStatusBarBack.Location = new System.Drawing.Point(1, 244);
            this.lblStatusBarBack.Name = "lblStatusBarBack";
            this.lblStatusBarBack.Size = new System.Drawing.Size(238, 22);
            this.lblStatusBarBack.Text = "label2";
            // 
            // pnlStatusBarFront
            // 
            this.pnlStatusBarFront.Controls.Add(this.lblStatusBar);
            this.pnlStatusBarFront.Location = new System.Drawing.Point(2, 245);
            this.pnlStatusBarFront.Name = "pnlStatusBarFront";
            this.pnlStatusBarFront.Size = new System.Drawing.Size(236, 20);
            // 
            // frmStart
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.BackColor = System.Drawing.Color.WhiteSmoke;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.ControlBox = false;
            this.Controls.Add(this.pnlStatusBarFront);
            this.Controls.Add(this.lblStatusBarBack);
            this.Controls.Add(this.pnlMainFront);
            this.Controls.Add(this.imgPresses);
            this.Controls.Add(this.pnlMainBack);
            this.Menu = this.mnuMain;
            this.Name = "frmStart";
            this.Text = "NI Applications";
            this.Load += new System.EventHandler(this.frmStart_Load);
            this.pnlMainFront.ResumeLayout(false);
            this.pnlWirelessLogo.ResumeLayout(false);
            this.pnlStatusBarFront.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        public System.Windows.Forms.Label lblStatusBar;
        private System.Windows.Forms.MenuItem mnuiChangeSystem;
        private System.Windows.Forms.MenuItem mnuiDevelopment;
        private System.Windows.Forms.MenuItem mnuiTest;
        private System.Windows.Forms.MenuItem mnuiCopy;
        private System.Windows.Forms.MenuItem mnuiLive;
        private System.Windows.Forms.MenuItem mnuiViewLog;
        private System.Windows.Forms.Label lblStatusBarBack;
        private System.Windows.Forms.Panel pnlStatusBarFront;
        private System.Windows.Forms.MenuItem menuItem1;
        public System.Windows.Forms.MenuItem menuItemDebug;
        private System.Windows.Forms.MenuItem menuItem2;
        private System.Windows.Forms.MenuItem menuItem3;
        private System.Windows.Forms.PictureBox imgNILogo;


    }
}

