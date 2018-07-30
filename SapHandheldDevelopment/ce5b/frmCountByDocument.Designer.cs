namespace ce5b
{
    partial class frmCountByDocument
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.MainMenu mainMenu1;

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
            this.mainMenu1 = new System.Windows.Forms.MainMenu();
            this.mnuiFunctions = new System.Windows.Forms.MenuItem();
            this.mnuiExit = new System.Windows.Forms.MenuItem();
            this.mnuiViewLog = new System.Windows.Forms.MenuItem();
            this.mnuiDebugOn = new System.Windows.Forms.MenuItem();
            this.mnuiHelp = new System.Windows.Forms.MenuItem();
            this.pnlOuterback = new System.Windows.Forms.Panel();
            this.pnlOuterFront = new System.Windows.Forms.Panel();
            this.pnlInnerBack = new System.Windows.Forms.Panel();
            this.pnlInnerFront = new System.Windows.Forms.Panel();
            this.cmdGetDocument = new System.Windows.Forms.Button();
            this.txtCountDocument = new System.Windows.Forms.TextBox();
            this.lblCountDocument = new System.Windows.Forms.Label();
            this.lblStatusBar = new System.Windows.Forms.Label();
            this.pnlStatusBarBack = new System.Windows.Forms.Panel();
            this.pnlStatusBarFront = new System.Windows.Forms.Panel();
            this.pnlOuterback.SuspendLayout();
            this.pnlOuterFront.SuspendLayout();
            this.pnlInnerBack.SuspendLayout();
            this.pnlInnerFront.SuspendLayout();
            this.pnlStatusBarBack.SuspendLayout();
            this.pnlStatusBarFront.SuspendLayout();
            this.SuspendLayout();
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.Add(this.mnuiFunctions);
            // 
            // mnuiFunctions
            // 
            this.mnuiFunctions.MenuItems.Add(this.mnuiExit);
            this.mnuiFunctions.MenuItems.Add(this.mnuiViewLog);
            this.mnuiFunctions.MenuItems.Add(this.mnuiDebugOn);
            this.mnuiFunctions.MenuItems.Add(this.mnuiHelp);
            this.mnuiFunctions.Text = "Functions";
            // 
            // mnuiExit
            // 
            this.mnuiExit.Text = "Exit";
            this.mnuiExit.Click += new System.EventHandler(this.menuItem2_Click);
            // 
            // mnuiViewLog
            // 
            this.mnuiViewLog.Text = "View Log";
            this.mnuiViewLog.Click += new System.EventHandler(this.mnuiViewLog_Click);
            // 
            // mnuiDebugOn
            // 
            this.mnuiDebugOn.Text = "Debug On";
            this.mnuiDebugOn.Click += new System.EventHandler(this.mnuiDebugOn_Click);
            // 
            // mnuiHelp
            // 
            this.mnuiHelp.Text = "Help";
            this.mnuiHelp.Click += new System.EventHandler(this.mnuiHelp_Click);
            // 
            // pnlOuterback
            // 
            this.pnlOuterback.BackColor = System.Drawing.Color.Black;
            this.pnlOuterback.Controls.Add(this.pnlOuterFront);
            this.pnlOuterback.Location = new System.Drawing.Point(24, 40);
            this.pnlOuterback.Name = "pnlOuterback";
            this.pnlOuterback.Size = new System.Drawing.Size(192, 129);
            // 
            // pnlOuterFront
            // 
            this.pnlOuterFront.BackColor = System.Drawing.Color.AliceBlue;
            this.pnlOuterFront.Controls.Add(this.pnlInnerBack);
            this.pnlOuterFront.Location = new System.Drawing.Point(1, 1);
            this.pnlOuterFront.Name = "pnlOuterFront";
            this.pnlOuterFront.Size = new System.Drawing.Size(190, 127);
            // 
            // pnlInnerBack
            // 
            this.pnlInnerBack.BackColor = System.Drawing.Color.Black;
            this.pnlInnerBack.Controls.Add(this.pnlInnerFront);
            this.pnlInnerBack.Location = new System.Drawing.Point(6, 16);
            this.pnlInnerBack.Name = "pnlInnerBack";
            this.pnlInnerBack.Size = new System.Drawing.Size(176, 96);
            // 
            // pnlInnerFront
            // 
            this.pnlInnerFront.BackColor = System.Drawing.Color.Lavender;
            this.pnlInnerFront.Controls.Add(this.cmdGetDocument);
            this.pnlInnerFront.Controls.Add(this.txtCountDocument);
            this.pnlInnerFront.Controls.Add(this.lblCountDocument);
            this.pnlInnerFront.Location = new System.Drawing.Point(1, 1);
            this.pnlInnerFront.Name = "pnlInnerFront";
            this.pnlInnerFront.Size = new System.Drawing.Size(174, 94);
            this.pnlInnerFront.GotFocus += new System.EventHandler(this.pnlInnerFront_GotFocus);
            // 
            // cmdGetDocument
            // 
            this.cmdGetDocument.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.cmdGetDocument.Location = new System.Drawing.Point(44, 61);
            this.cmdGetDocument.Name = "cmdGetDocument";
            this.cmdGetDocument.Size = new System.Drawing.Size(85, 20);
            this.cmdGetDocument.TabIndex = 3;
            this.cmdGetDocument.Text = "Start Count";
            this.cmdGetDocument.Click += new System.EventHandler(this.cmdGetDocument_Click);
            // 
            // txtCountDocument
            // 
            this.txtCountDocument.Location = new System.Drawing.Point(75, 19);
            this.txtCountDocument.Name = "txtCountDocument";
            this.txtCountDocument.Size = new System.Drawing.Size(95, 23);
            this.txtCountDocument.TabIndex = 1;
            this.txtCountDocument.TextChanged += new System.EventHandler(this.txtCountDocument_TextChanged);
            // 
            // lblCountDocument
            // 
            this.lblCountDocument.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Bold);
            this.lblCountDocument.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.lblCountDocument.Location = new System.Drawing.Point(2, 22);
            this.lblCountDocument.Name = "lblCountDocument";
            this.lblCountDocument.Size = new System.Drawing.Size(83, 20);
            this.lblCountDocument.Text = "Count Doc.";
            // 
            // lblStatusBar
            // 
            this.lblStatusBar.Location = new System.Drawing.Point(0, 0);
            this.lblStatusBar.Name = "lblStatusBar";
            this.lblStatusBar.Size = new System.Drawing.Size(236, 22);
            this.lblStatusBar.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // pnlStatusBarBack
            // 
            this.pnlStatusBarBack.BackColor = System.Drawing.Color.Black;
            this.pnlStatusBarBack.Controls.Add(this.pnlStatusBarFront);
            this.pnlStatusBarBack.Location = new System.Drawing.Point(3, 200);
            this.pnlStatusBarBack.Name = "pnlStatusBarBack";
            this.pnlStatusBarBack.Size = new System.Drawing.Size(236, 24);
            // 
            // pnlStatusBarFront
            // 
            this.pnlStatusBarFront.Controls.Add(this.lblStatusBar);
            this.pnlStatusBarFront.Location = new System.Drawing.Point(1, 1);
            this.pnlStatusBarFront.Name = "pnlStatusBarFront";
            this.pnlStatusBarFront.Size = new System.Drawing.Size(234, 22);
            // 
            // frmCountByDocument
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.Controls.Add(this.pnlStatusBarBack);
            this.Controls.Add(this.pnlOuterback);
            this.Menu = this.mainMenu1;
            this.Name = "frmCountByDocument";
            this.Text = "Count By Document";
            this.Load += new System.EventHandler(this.frmCountByDocument_Load);
            this.pnlOuterback.ResumeLayout(false);
            this.pnlOuterFront.ResumeLayout(false);
            this.pnlInnerBack.ResumeLayout(false);
            this.pnlInnerFront.ResumeLayout(false);
            this.pnlStatusBarBack.ResumeLayout(false);
            this.pnlStatusBarFront.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnlOuterback;
        private System.Windows.Forms.Panel pnlOuterFront;
        private System.Windows.Forms.Panel pnlInnerBack;
        private System.Windows.Forms.Panel pnlInnerFront;
        private System.Windows.Forms.TextBox txtCountDocument;
        private System.Windows.Forms.Label lblCountDocument;
        private System.Windows.Forms.Button cmdGetDocument;
        public System.Windows.Forms.Label lblStatusBar;
        private System.Windows.Forms.MenuItem mnuiFunctions;
        private System.Windows.Forms.MenuItem mnuiExit;
        private System.Windows.Forms.MenuItem mnuiViewLog;
        private System.Windows.Forms.Panel pnlStatusBarBack;
        private System.Windows.Forms.Panel pnlStatusBarFront;
        public System.Windows.Forms.MenuItem mnuiDebugOn;
        private System.Windows.Forms.MenuItem mnuiHelp;
    }
}