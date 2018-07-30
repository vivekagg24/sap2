namespace ce5b
{
    partial class frmLogon
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TextBox txtUname;
        private System.Windows.Forms.Label lblUserName;
        private System.Windows.Forms.Button cmdLogon;
        private System.Windows.Forms.TextBox txtPword;
        private System.Windows.Forms.PictureBox imgGun;
        private System.Windows.Forms.Panel pnlTopFront;
        private System.Windows.Forms.Panel pnlTopBack;
        private System.Windows.Forms.Label lblPassword;
        private System.Windows.Forms.Panel pnlBottomFront;
        private System.Windows.Forms.Panel pnlBottomBack;
        private System.Windows.Forms.PictureBox imgNILogo;
        private Microsoft.WindowsCE.Forms.InputPanel inputPanel1;
        private System.Windows.Forms.MainMenu mainMenu1;
        private System.Windows.Forms.Button cmdClear;

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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmLogon));
            this.txtUname = new System.Windows.Forms.TextBox();
            this.txtPword = new System.Windows.Forms.TextBox();
            this.lblUserName = new System.Windows.Forms.Label();
            this.cmdLogon = new System.Windows.Forms.Button();
            this.imgGun = new System.Windows.Forms.PictureBox();
            this.pnlTopFront = new System.Windows.Forms.Panel();
            this.lblPassword = new System.Windows.Forms.Label();
            this.pnlTopBack = new System.Windows.Forms.Panel();
            this.pnlBottomFront = new System.Windows.Forms.Panel();
            this.imgNILogo = new System.Windows.Forms.PictureBox();
            this.cmdClear = new System.Windows.Forms.Button();
            this.pnlBottomBack = new System.Windows.Forms.Panel();
            this.inputPanel1 = new Microsoft.WindowsCE.Forms.InputPanel();
            this.mainMenu1 = new System.Windows.Forms.MainMenu();
            this.mnuiFunctions = new System.Windows.Forms.MenuItem();
            this.mnuiViewLog = new System.Windows.Forms.MenuItem();
            this.mnuiExit = new System.Windows.Forms.MenuItem();
            this.mnuiDebugOn = new System.Windows.Forms.MenuItem();
            this.mnuiHelp = new System.Windows.Forms.MenuItem();
            this.lblStatusBar = new System.Windows.Forms.Label();
            this.pnlStatusBarBack = new System.Windows.Forms.Panel();
            this.pnlStatusBarFront = new System.Windows.Forms.Panel();
            this.pnlTopFront.SuspendLayout();
            this.pnlBottomFront.SuspendLayout();
            this.pnlBottomBack.SuspendLayout();
            this.pnlStatusBarBack.SuspendLayout();
            this.pnlStatusBarFront.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtUname
            // 
            this.txtUname.Location = new System.Drawing.Point(112, 8);
            this.txtUname.Name = "txtUname";
            this.txtUname.Size = new System.Drawing.Size(104, 23);
            this.txtUname.TabIndex = 1;
            this.txtUname.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtUname_KeyPress);
            this.txtUname.TextChanged += new System.EventHandler(this.txtUname_TextChanged);
            // 
            // txtPword
            // 
            this.txtPword.Location = new System.Drawing.Point(112, 32);
            this.txtPword.Name = "txtPword";
            this.txtPword.PasswordChar = '*';
            this.txtPword.Size = new System.Drawing.Size(104, 23);
            this.txtPword.TabIndex = 0;
            this.txtPword.KeyUp += new System.Windows.Forms.KeyEventHandler(this.txtPword_KeyUp);
            this.txtPword.TextChanged += new System.EventHandler(this.txtPword_TextChanged);
            // 
            // lblUserName
            // 
            this.lblUserName.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular);
            this.lblUserName.ForeColor = System.Drawing.Color.Black;
            this.lblUserName.Location = new System.Drawing.Point(8, 8);
            this.lblUserName.Name = "lblUserName";
            this.lblUserName.Size = new System.Drawing.Size(98, 25);
            this.lblUserName.Text = " User Name";
            // 
            // cmdLogon
            // 
            this.cmdLogon.Location = new System.Drawing.Point(48, 58);
            this.cmdLogon.Name = "cmdLogon";
            this.cmdLogon.Size = new System.Drawing.Size(112, 24);
            this.cmdLogon.TabIndex = 4;
            this.cmdLogon.Text = "Logon to SAP";
            this.cmdLogon.Click += new System.EventHandler(this.cmdLogon_Click);
            // 
            // imgGun
            // 
            this.imgGun.Image = ((System.Drawing.Image)(resources.GetObject("imgGun.Image")));
            this.imgGun.Location = new System.Drawing.Point(1, 2);
            this.imgGun.Name = "imgGun";
            this.imgGun.Size = new System.Drawing.Size(70, 103);
            // 
            // pnlTopFront
            // 
            this.pnlTopFront.BackColor = System.Drawing.Color.LightSteelBlue;
            this.pnlTopFront.Controls.Add(this.txtPword);
            this.pnlTopFront.Controls.Add(this.txtUname);
            this.pnlTopFront.Controls.Add(this.lblUserName);
            this.pnlTopFront.Controls.Add(this.lblPassword);
            this.pnlTopFront.Controls.Add(this.cmdLogon);
            this.pnlTopFront.Location = new System.Drawing.Point(7, 33);
            this.pnlTopFront.Name = "pnlTopFront";
            this.pnlTopFront.Size = new System.Drawing.Size(226, 88);
            // 
            // lblPassword
            // 
            this.lblPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular);
            this.lblPassword.ForeColor = System.Drawing.Color.Black;
            this.lblPassword.Location = new System.Drawing.Point(8, 33);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(98, 25);
            this.lblPassword.Text = " Password";
            // 
            // pnlTopBack
            // 
            this.pnlTopBack.BackColor = System.Drawing.Color.Black;
            this.pnlTopBack.Location = new System.Drawing.Point(6, 32);
            this.pnlTopBack.Name = "pnlTopBack";
            this.pnlTopBack.Size = new System.Drawing.Size(228, 91);
            // 
            // pnlBottomFront
            // 
            this.pnlBottomFront.BackColor = System.Drawing.Color.White;
            this.pnlBottomFront.Controls.Add(this.imgGun);
            this.pnlBottomFront.Controls.Add(this.imgNILogo);
            this.pnlBottomFront.Controls.Add(this.cmdClear);
            this.pnlBottomFront.Location = new System.Drawing.Point(1, 1);
            this.pnlBottomFront.Name = "pnlBottomFront";
            this.pnlBottomFront.Size = new System.Drawing.Size(226, 107);
            // 
            // imgNILogo
            // 
            this.imgNILogo.Image = ((System.Drawing.Image)(resources.GetObject("imgNILogo.Image")));
            this.imgNILogo.Location = new System.Drawing.Point(73, 16);
            this.imgNILogo.Name = "imgNILogo";
            this.imgNILogo.Size = new System.Drawing.Size(153, 45);
            // 
            // cmdClear
            // 
            this.cmdClear.Location = new System.Drawing.Point(145, 85);
            this.cmdClear.Name = "cmdClear";
            this.cmdClear.Size = new System.Drawing.Size(72, 20);
            this.cmdClear.TabIndex = 3;
            this.cmdClear.Text = "Clear";
            this.cmdClear.Click += new System.EventHandler(this.cmdClear_Click);
            // 
            // pnlBottomBack
            // 
            this.pnlBottomBack.BackColor = System.Drawing.Color.Black;
            this.pnlBottomBack.Controls.Add(this.pnlBottomFront);
            this.pnlBottomBack.Location = new System.Drawing.Point(6, 128);
            this.pnlBottomBack.Name = "pnlBottomBack";
            this.pnlBottomBack.Size = new System.Drawing.Size(228, 109);
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.Add(this.mnuiFunctions);
            // 
            // mnuiFunctions
            // 
            this.mnuiFunctions.MenuItems.Add(this.mnuiViewLog);
            this.mnuiFunctions.MenuItems.Add(this.mnuiExit);
            this.mnuiFunctions.MenuItems.Add(this.mnuiDebugOn);
            this.mnuiFunctions.MenuItems.Add(this.mnuiHelp);
            this.mnuiFunctions.Text = "Functions";
            // 
            // mnuiViewLog
            // 
            this.mnuiViewLog.Text = "View Log";
            this.mnuiViewLog.Click += new System.EventHandler(this.mnuiViewLog_Click);
            // 
            // mnuiExit
            // 
            this.mnuiExit.Text = "Exit";
            this.mnuiExit.Click += new System.EventHandler(this.mnuiExit_Click);
            // 
            // mnuiDebugOn
            // 
            this.mnuiDebugOn.Enabled = false;
            this.mnuiDebugOn.Text = "Debug On";
            this.mnuiDebugOn.Click += new System.EventHandler(this.mnuiDebugOn_Click);
            // 
            // mnuiHelp
            // 
            this.mnuiHelp.Text = "Help";
            this.mnuiHelp.Click += new System.EventHandler(this.mnuiHelp_Click);
            // 
            // lblStatusBar
            // 
            this.lblStatusBar.Location = new System.Drawing.Point(0, 0);
            this.lblStatusBar.Name = "lblStatusBar";
            this.lblStatusBar.Size = new System.Drawing.Size(226, 22);
            this.lblStatusBar.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // pnlStatusBarBack
            // 
            this.pnlStatusBarBack.BackColor = System.Drawing.Color.Black;
            this.pnlStatusBarBack.Controls.Add(this.pnlStatusBarFront);
            this.pnlStatusBarBack.Location = new System.Drawing.Point(6, 240);
            this.pnlStatusBarBack.Name = "pnlStatusBarBack";
            this.pnlStatusBarBack.Size = new System.Drawing.Size(228, 24);
            // 
            // pnlStatusBarFront
            // 
            this.pnlStatusBarFront.Controls.Add(this.lblStatusBar);
            this.pnlStatusBarFront.Location = new System.Drawing.Point(1, 1);
            this.pnlStatusBarFront.Name = "pnlStatusBarFront";
            this.pnlStatusBarFront.Size = new System.Drawing.Size(226, 22);
            // 
            // frmLogon
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.BackColor = System.Drawing.Color.MintCream;
            this.ClientSize = new System.Drawing.Size(240, 293);
            this.Controls.Add(this.pnlStatusBarBack);
            this.Controls.Add(this.pnlBottomBack);
            this.Controls.Add(this.pnlTopFront);
            this.Controls.Add(this.pnlTopBack);
            this.Menu = this.mainMenu1;
            this.Name = "frmLogon";
            this.Text = "Logon to SAP";
            this.Load += new System.EventHandler(this.frmLogin_Load);
            this.pnlTopFront.ResumeLayout(false);
            this.pnlBottomFront.ResumeLayout(false);
            this.pnlBottomBack.ResumeLayout(false);
            this.pnlStatusBarBack.ResumeLayout(false);
            this.pnlStatusBarFront.ResumeLayout(false);
            this.ResumeLayout(false);

       }

        #endregion

        public System.Windows.Forms.Label lblStatusBar;
        private System.Windows.Forms.MenuItem mnuiFunctions;
        private System.Windows.Forms.MenuItem mnuiViewLog;
        private System.Windows.Forms.MenuItem mnuiExit;
        public System.Windows.Forms.MenuItem mnuiDebugOn;
        private System.Windows.Forms.Panel pnlStatusBarBack;
        private System.Windows.Forms.Panel pnlStatusBarFront;
        private System.Windows.Forms.MenuItem mnuiHelp;




   }
}