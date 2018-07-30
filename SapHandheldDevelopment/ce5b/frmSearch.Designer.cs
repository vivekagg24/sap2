namespace ce5b
{
    partial class frmSearch
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.Panel pnlSearchFront;
        private System.Windows.Forms.Label lblDate;
        //private DateTimePicker DTCpicker1;
        private System.Windows.Forms.Label lblSupplier;
        public System.Windows.Forms.TextBox txtSupplier;
        private System.Windows.Forms.Label lblPONumber;
        private System.Windows.Forms.TextBox txtPOFrom;
        private System.Windows.Forms.TextBox txtPOTo;
        private System.Windows.Forms.Panel panelSearchArea;
        private System.Windows.Forms.PictureBox imgCompress;
        private System.Windows.Forms.PictureBox imgExpand;
        private System.Windows.Forms.Label lblExpComp;
        //private DateTimePicker DTCpicker2;
        private System.Windows.Forms.Button cmdSupplier;
        private System.Windows.Forms.Button cmdCancel;
        private System.Windows.Forms.Button cmdSearch;
        private System.Windows.Forms.MainMenu mainMenu1;
        private Microsoft.WindowsCE.Forms.InputPanel inputPanel1;
        private System.Windows.Forms.Label lblPlant;
        private System.Windows.Forms.ComboBox comboPlant;

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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmSearch));
            this.panelSearchArea = new System.Windows.Forms.Panel();
            this.pnlSearchFront = new System.Windows.Forms.Panel();
            this.DateTo = new System.Windows.Forms.DateTimePicker();
            this.DateFrom = new System.Windows.Forms.DateTimePicker();
            this.comboPlant = new System.Windows.Forms.ComboBox();
            this.lblPlant = new System.Windows.Forms.Label();
            this.cmdSearch = new System.Windows.Forms.Button();
            this.cmdSupplier = new System.Windows.Forms.Button();
            this.txtPOTo = new System.Windows.Forms.TextBox();
            this.txtPOFrom = new System.Windows.Forms.TextBox();
            this.lblPONumber = new System.Windows.Forms.Label();
            this.txtSupplier = new System.Windows.Forms.TextBox();
            this.lblSupplier = new System.Windows.Forms.Label();
            this.lblDate = new System.Windows.Forms.Label();
            this.cmdCancel = new System.Windows.Forms.Button();
            this.imgCompress = new System.Windows.Forms.PictureBox();
            this.imgExpand = new System.Windows.Forms.PictureBox();
            this.lblExpComp = new System.Windows.Forms.Label();
            this.mainMenu1 = new System.Windows.Forms.MainMenu();
            this.mnuiFunctions = new System.Windows.Forms.MenuItem();
            this.mnuiExit = new System.Windows.Forms.MenuItem();
            this.mnuiHelp = new System.Windows.Forms.MenuItem();
            this.mnuiViewLog = new System.Windows.Forms.MenuItem();
            this.mnuiDebugOn = new System.Windows.Forms.MenuItem();
            this.inputPanel1 = new Microsoft.WindowsCE.Forms.InputPanel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pnlMain = new System.Windows.Forms.Panel();
            this.pnlStatusBarBack = new System.Windows.Forms.Panel();
            this.pnlStatusBarFront = new System.Windows.Forms.Panel();
            this.pnlTreeView = new System.Windows.Forms.Panel();
            this.treeResults = new System.Windows.Forms.TreeView();
            this.panelSearchArea.SuspendLayout();
            this.pnlSearchFront.SuspendLayout();
            this.pnlMain.SuspendLayout();
            this.pnlStatusBarBack.SuspendLayout();
            this.pnlStatusBarFront.SuspendLayout();
            this.pnlTreeView.SuspendLayout();
            this.SuspendLayout();
            // 
            // panelSearchArea
            // 
            this.panelSearchArea.BackColor = System.Drawing.Color.Black;
            this.panelSearchArea.Controls.Add(this.pnlSearchFront);
            this.panelSearchArea.Location = new System.Drawing.Point(3, 35);
            this.panelSearchArea.Name = "panelSearchArea";
            this.panelSearchArea.Size = new System.Drawing.Size(224, 148);
            // 
            // pnlSearchFront
            // 
            this.pnlSearchFront.BackColor = System.Drawing.Color.Tan;
            this.pnlSearchFront.Controls.Add(this.DateTo);
            this.pnlSearchFront.Controls.Add(this.DateFrom);
            this.pnlSearchFront.Controls.Add(this.comboPlant);
            this.pnlSearchFront.Controls.Add(this.lblPlant);
            this.pnlSearchFront.Controls.Add(this.cmdSearch);
            this.pnlSearchFront.Controls.Add(this.cmdSupplier);
            this.pnlSearchFront.Controls.Add(this.txtPOTo);
            this.pnlSearchFront.Controls.Add(this.txtPOFrom);
            this.pnlSearchFront.Controls.Add(this.lblPONumber);
            this.pnlSearchFront.Controls.Add(this.txtSupplier);
            this.pnlSearchFront.Controls.Add(this.lblSupplier);
            this.pnlSearchFront.Controls.Add(this.lblDate);
            this.pnlSearchFront.Controls.Add(this.cmdCancel);
            this.pnlSearchFront.Location = new System.Drawing.Point(1, 1);
            this.pnlSearchFront.Name = "pnlSearchFront";
            this.pnlSearchFront.Size = new System.Drawing.Size(222, 144);
            // 
            // DateTo
            // 
            this.DateTo.CustomFormat = " ";
            this.DateTo.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DateTo.Location = new System.Drawing.Point(135, 4);
            this.DateTo.MaxDate = new System.DateTime(2999, 12, 31, 0, 0, 0, 0);
            this.DateTo.Name = "DateTo";
            this.DateTo.Size = new System.Drawing.Size(80, 24);
            this.DateTo.TabIndex = 13;
            this.DateTo.Value = new System.DateTime(2008, 2, 25, 0, 0, 0, 0);
            // 
            // DateFrom
            // 
            this.DateFrom.CustomFormat = " ";
            this.DateFrom.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.DateFrom.Location = new System.Drawing.Point(50, 4);
            this.DateFrom.Name = "DateFrom";
            this.DateFrom.Size = new System.Drawing.Size(80, 24);
            this.DateFrom.TabIndex = 6;
            this.DateFrom.Value = new System.DateTime(2008, 2, 25, 0, 0, 0, 0);
            // 
            // comboPlant
            // 
            this.comboPlant.Location = new System.Drawing.Point(50, 88);
            this.comboPlant.Name = "comboPlant";
            this.comboPlant.Size = new System.Drawing.Size(166, 23);
            this.comboPlant.TabIndex = 0;
            // 
            // lblPlant
            // 
            this.lblPlant.Location = new System.Drawing.Point(2, 88);
            this.lblPlant.Name = "lblPlant";
            this.lblPlant.Size = new System.Drawing.Size(40, 24);
            this.lblPlant.Text = "Plant";
            // 
            // cmdSearch
            // 
            this.cmdSearch.Location = new System.Drawing.Point(135, 116);
            this.cmdSearch.Name = "cmdSearch";
            this.cmdSearch.Size = new System.Drawing.Size(72, 24);
            this.cmdSearch.TabIndex = 2;
            this.cmdSearch.Text = "Search";
            this.cmdSearch.Click += new System.EventHandler(this.cmdSearch_Click);
            // 
            // cmdSupplier
            // 
            this.cmdSupplier.Location = new System.Drawing.Point(136, 32);
            this.cmdSupplier.Name = "cmdSupplier";
            this.cmdSupplier.Size = new System.Drawing.Size(72, 24);
            this.cmdSupplier.TabIndex = 3;
            this.cmdSupplier.Text = "Look Up";
            this.cmdSupplier.Click += new System.EventHandler(this.cmdSupplier_Click);
            // 
            // txtPOTo
            // 
            this.txtPOTo.Location = new System.Drawing.Point(136, 60);
            this.txtPOTo.Name = "txtPOTo";
            this.txtPOTo.Size = new System.Drawing.Size(80, 23);
            this.txtPOTo.TabIndex = 4;
            // 
            // txtPOFrom
            // 
            this.txtPOFrom.Location = new System.Drawing.Point(50, 60);
            this.txtPOFrom.Name = "txtPOFrom";
            this.txtPOFrom.Size = new System.Drawing.Size(80, 23);
            this.txtPOFrom.TabIndex = 5;
            // 
            // lblPONumber
            // 
            this.lblPONumber.Location = new System.Drawing.Point(2, 60);
            this.lblPONumber.Name = "lblPONumber";
            this.lblPONumber.Size = new System.Drawing.Size(46, 24);
            this.lblPONumber.Text = "PO #";
            // 
            // txtSupplier
            // 
            this.txtSupplier.Location = new System.Drawing.Point(50, 32);
            this.txtSupplier.Name = "txtSupplier";
            this.txtSupplier.Size = new System.Drawing.Size(80, 23);
            this.txtSupplier.TabIndex = 7;
            // 
            // lblSupplier
            // 
            this.lblSupplier.Location = new System.Drawing.Point(2, 32);
            this.lblSupplier.Name = "lblSupplier";
            this.lblSupplier.Size = new System.Drawing.Size(62, 24);
            this.lblSupplier.Text = "Supplier";
            // 
            // lblDate
            // 
            this.lblDate.Location = new System.Drawing.Point(2, 4);
            this.lblDate.Name = "lblDate";
            this.lblDate.Size = new System.Drawing.Size(42, 24);
            this.lblDate.Text = "Date";
            // 
            // cmdCancel
            // 
            this.cmdCancel.Location = new System.Drawing.Point(50, 116);
            this.cmdCancel.Name = "cmdCancel";
            this.cmdCancel.Size = new System.Drawing.Size(72, 24);
            this.cmdCancel.TabIndex = 12;
            this.cmdCancel.Text = "Cancel";
            this.cmdCancel.Click += new System.EventHandler(this.cmdCancel_Click);
            // 
            // imgCompress
            // 
            this.imgCompress.Image = ((System.Drawing.Image)(resources.GetObject("imgCompress.Image")));
            this.imgCompress.Location = new System.Drawing.Point(13, 3);
            this.imgCompress.Name = "imgCompress";
            this.imgCompress.Size = new System.Drawing.Size(16, 16);
            this.imgCompress.Visible = false;
            // 
            // imgExpand
            // 
            this.imgExpand.Image = ((System.Drawing.Image)(resources.GetObject("imgExpand.Image")));
            this.imgExpand.Location = new System.Drawing.Point(123, 3);
            this.imgExpand.Name = "imgExpand";
            this.imgExpand.Size = new System.Drawing.Size(16, 16);
            this.imgExpand.Visible = false;
            // 
            // lblExpComp
            // 
            this.lblExpComp.ForeColor = System.Drawing.Color.DarkGreen;
            this.lblExpComp.Location = new System.Drawing.Point(35, 4);
            this.lblExpComp.Name = "lblExpComp";
            this.lblExpComp.Size = new System.Drawing.Size(160, 16);
            this.lblExpComp.Text = "Show search criteria";
            this.lblExpComp.Visible = false;
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.Add(this.mnuiFunctions);
            // 
            // mnuiFunctions
            // 
            this.mnuiFunctions.MenuItems.Add(this.mnuiExit);
            this.mnuiFunctions.MenuItems.Add(this.mnuiHelp);
            this.mnuiFunctions.MenuItems.Add(this.mnuiViewLog);
            this.mnuiFunctions.MenuItems.Add(this.mnuiDebugOn);
            this.mnuiFunctions.Text = "Functions";
            // 
            // mnuiExit
            // 
            this.mnuiExit.Text = "Exit";
            this.mnuiExit.Click += new System.EventHandler(this.mnuiExit_Click);
            // 
            // mnuiHelp
            // 
            this.mnuiHelp.Text = "Help";
            this.mnuiHelp.Click += new System.EventHandler(this.mnuiHelp_Click);
            // 
            // mnuiViewLog
            // 
            this.mnuiViewLog.Text = "View Log";
            this.mnuiViewLog.Click += new System.EventHandler(this.mnuiViewLog_Click);
            // 
            // mnuiDebugOn
            // 
            this.mnuiDebugOn.Enabled = false;
            this.mnuiDebugOn.Text = "Debug On";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(261, 241);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(16, 16);
            this.pictureBox1.Visible = false;
            // 
            // pnlMain
            // 
            this.pnlMain.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.pnlMain.Controls.Add(this.pnlStatusBarBack);
            this.pnlMain.Controls.Add(this.pnlTreeView);
            this.pnlMain.Controls.Add(this.panelSearchArea);
            this.pnlMain.Location = new System.Drawing.Point(3, 25);
            this.pnlMain.Name = "pnlMain";
            this.pnlMain.Size = new System.Drawing.Size(234, 187);
            // 
            // pnlStatusBarBack
            // 
            this.pnlStatusBarBack.BackColor = System.Drawing.Color.Black;
            this.pnlStatusBarBack.Controls.Add(this.pnlStatusBarFront);
            this.pnlStatusBarBack.Location = new System.Drawing.Point(3, 3);
            this.pnlStatusBarBack.Name = "pnlStatusBarBack";
            this.pnlStatusBarBack.Size = new System.Drawing.Size(230, 25);
            this.pnlStatusBarBack.Visible = false;
            // 
            // pnlStatusBarFront
            // 
            this.pnlStatusBarFront.BackColor = System.Drawing.Color.Ivory;
            this.pnlStatusBarFront.Controls.Add(this.imgCompress);
            this.pnlStatusBarFront.Controls.Add(this.imgExpand);
            this.pnlStatusBarFront.Controls.Add(this.lblExpComp);
            this.pnlStatusBarFront.Location = new System.Drawing.Point(1, 1);
            this.pnlStatusBarFront.Name = "pnlStatusBarFront";
            this.pnlStatusBarFront.Size = new System.Drawing.Size(228, 23);
            this.pnlStatusBarFront.Visible = false;
            // 
            // pnlTreeView
            // 
            this.pnlTreeView.Controls.Add(this.treeResults);
            this.pnlTreeView.Location = new System.Drawing.Point(1, 31);
            this.pnlTreeView.Name = "pnlTreeView";
            this.pnlTreeView.Size = new System.Drawing.Size(231, 175);
            this.pnlTreeView.Visible = false;
            // 
            // treeResults
            // 
            this.treeResults.Location = new System.Drawing.Point(3, 0);
            this.treeResults.Name = "treeResults";
            this.treeResults.Size = new System.Drawing.Size(225, 152);
            this.treeResults.TabIndex = 5;
            this.treeResults.Visible = false;
            this.treeResults.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.treeResults_AfterSelect);
            // 
            // frmSearch
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ClientSize = new System.Drawing.Size(240, 268);
            this.Controls.Add(this.pnlMain);
            this.Controls.Add(this.pictureBox1);
            this.Menu = this.mainMenu1;
            this.Name = "frmSearch";
            this.Text = "PO Search";
            this.Load += new System.EventHandler(this.frmSearch_Load);
            this.panelSearchArea.ResumeLayout(false);
            this.pnlSearchFront.ResumeLayout(false);
            this.pnlMain.ResumeLayout(false);
            this.pnlStatusBarBack.ResumeLayout(false);
            this.pnlStatusBarFront.ResumeLayout(false);
            this.pnlTreeView.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel pnlMain;
        private System.Windows.Forms.MenuItem mnuiFunctions;
        private System.Windows.Forms.MenuItem mnuiExit;
        private System.Windows.Forms.MenuItem mnuiHelp;
        private System.Windows.Forms.MenuItem mnuiViewLog;
        public System.Windows.Forms.MenuItem mnuiDebugOn;
        private System.Windows.Forms.DateTimePicker DateTo;
        private System.Windows.Forms.DateTimePicker DateFrom;
        private System.Windows.Forms.Panel pnlTreeView;
        private System.Windows.Forms.Panel pnlStatusBarBack;
        private System.Windows.Forms.Panel pnlStatusBarFront;
        private System.Windows.Forms.TreeView treeResults;
    }
}