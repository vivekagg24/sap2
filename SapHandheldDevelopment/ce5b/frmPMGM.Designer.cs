namespace ce5b
{
    partial class frmPMGM
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.MainMenu mainMenu1;

        private System.Windows.Forms.MenuItem mnuiFunctions;
        private System.Windows.Forms.MenuItem mnuiExit;
        private System.Windows.Forms.MenuItem mnuiClear;
        private System.Windows.Forms.MenuItem mnuiLogon;
        private System.Windows.Forms.MenuItem mnuiLogoff;
        private System.Windows.Forms.MenuItem mnuiZeroQtys; 
        private System.Windows.Forms.MenuItem mnuiItems;
        private System.Windows.Forms.MenuItem mnuiDelete;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tbpItems;
        private System.Windows.Forms.TabPage tbpMessages;
        private System.Windows.Forms.DataGrid dgItems;
        private System.Windows.Forms.Panel pnlImageHoldDeleteItem;
        private System.Windows.Forms.PictureBox imgDeleteItem;
        private System.Windows.Forms.Button cmdPost;
        private System.Windows.Forms.ComboBox comboActype;
        private System.Windows.Forms.ComboBox comboLookUp;
        private System.Windows.Forms.ComboBox comboUOM;
        private System.Windows.Forms.ComboBox comboSloc;
        private System.Windows.Forms.TextBox txtEdit;
        private System.Windows.Forms.DataGrid dgMessages;

        private frmShowLog ShowLog;

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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmPMGM));
            this.mainMenu1 = new System.Windows.Forms.MainMenu();
            this.mnuiFunctions = new System.Windows.Forms.MenuItem();
            this.mnuiLogoff = new System.Windows.Forms.MenuItem();
            this.mnuiLogon = new System.Windows.Forms.MenuItem();
            this.mnuiClear = new System.Windows.Forms.MenuItem();
            this.mnuiExit = new System.Windows.Forms.MenuItem();
            this.mnuiShowLog = new System.Windows.Forms.MenuItem();
            this.mnuiDebugOn = new System.Windows.Forms.MenuItem();
            this.mnuiHelp = new System.Windows.Forms.MenuItem();
            this.mnuiItems = new System.Windows.Forms.MenuItem();
            this.mnuiDelete = new System.Windows.Forms.MenuItem();
            this.mnuiZeroQtys = new System.Windows.Forms.MenuItem();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tbpHeader = new System.Windows.Forms.TabPage();
            this.lblStatusBar = new System.Windows.Forms.Label();
            this.pnlMiddleBack = new System.Windows.Forms.Panel();
            this.pnlMiddleTop = new System.Windows.Forms.Panel();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.txtRecipient = new System.Windows.Forms.TextBox();
            this.cmdGetRecipients = new System.Windows.Forms.Button();
            this.comboMvtType = new System.Windows.Forms.ComboBox();
            this.comboRecipient = new System.Windows.Forms.ComboBox();
            this.txtDocHeader = new System.Windows.Forms.TextBox();
            this.lblMovementType = new System.Windows.Forms.Label();
            this.lblRecipient = new System.Windows.Forms.Label();
            this.lblDocHeader = new System.Windows.Forms.Label();
            this.lblDocDate = new System.Windows.Forms.Label();
            this.txtHeaderText = new System.Windows.Forms.TextBox();
            this.pnltopback = new System.Windows.Forms.Panel();
            this.pnlTopFront = new System.Windows.Forms.Panel();
            this.cmdGetWO = new System.Windows.Forms.Button();
            this.txtWO = new System.Windows.Forms.TextBox();
            this.lblWO = new System.Windows.Forms.Label();
            this.lblStatusBar_Back = new System.Windows.Forms.Panel();
            this.tbpItems = new System.Windows.Forms.TabPage();
            this.lblSaving = new System.Windows.Forms.Label();
            this.comboLookUp = new System.Windows.Forms.ComboBox();
            this.comboUOM = new System.Windows.Forms.ComboBox();
            this.comboSloc = new System.Windows.Forms.ComboBox();
            this.txtEdit = new System.Windows.Forms.TextBox();
            this.comboActype = new System.Windows.Forms.ComboBox();
            this.dgItems = new System.Windows.Forms.DataGrid();
            this.pnlImageHoldDeleteItem = new System.Windows.Forms.Panel();
            this.imgDeleteItem = new System.Windows.Forms.PictureBox();
            this.cmdPost = new System.Windows.Forms.Button();
            this.tbpMessages = new System.Windows.Forms.TabPage();
            this.dgMessages = new System.Windows.Forms.DataGrid();
            this.tabControl1.SuspendLayout();
            this.tbpHeader.SuspendLayout();
            this.pnlMiddleBack.SuspendLayout();
            this.pnlMiddleTop.SuspendLayout();
            this.pnltopback.SuspendLayout();
            this.pnlTopFront.SuspendLayout();
            this.tbpItems.SuspendLayout();
            this.pnlImageHoldDeleteItem.SuspendLayout();
            this.tbpMessages.SuspendLayout();
            this.SuspendLayout();
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.Add(this.mnuiFunctions);
            this.mainMenu1.MenuItems.Add(this.mnuiItems);
            // 
            // mnuiFunctions
            // 
            this.mnuiFunctions.MenuItems.Add(this.mnuiLogoff);
            this.mnuiFunctions.MenuItems.Add(this.mnuiLogon);
            this.mnuiFunctions.MenuItems.Add(this.mnuiClear);
            this.mnuiFunctions.MenuItems.Add(this.mnuiExit);
            this.mnuiFunctions.MenuItems.Add(this.mnuiShowLog);
            this.mnuiFunctions.MenuItems.Add(this.mnuiDebugOn);
            this.mnuiFunctions.MenuItems.Add(this.mnuiHelp);
            this.mnuiFunctions.Text = "Functions";
            // 
            // mnuiLogoff
            // 
            this.mnuiLogoff.Text = "Logoff SAP";
            this.mnuiLogoff.Click += new System.EventHandler(this.mnuiLogoff_Click);
            // 
            // mnuiLogon
            // 
            this.mnuiLogon.Text = "Logon to SAP";
            this.mnuiLogon.Click += new System.EventHandler(this.mnuiLogon_Click);
            // 
            // mnuiClear
            // 
            this.mnuiClear.Text = "Clear Current";
            this.mnuiClear.Click += new System.EventHandler(this.mnuiClear_Click);
            // 
            // mnuiExit
            // 
            this.mnuiExit.Text = "Exit";
            this.mnuiExit.Click += new System.EventHandler(this.mnuiExit_Click);
            // 
            // mnuiShowLog
            // 
            this.mnuiShowLog.Text = "View Log";
            this.mnuiShowLog.Click += new System.EventHandler(this.mnuiShowLog_Click);
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
            // mnuiItems
            // 
            this.mnuiItems.MenuItems.Add(this.mnuiDelete);
            this.mnuiItems.MenuItems.Add(this.mnuiZeroQtys);
            this.mnuiItems.Text = "Items";
            // 
            // mnuiDelete
            // 
            this.mnuiDelete.Text = "Delete Component";
            this.mnuiDelete.Click += new System.EventHandler(this.mnuiDelete_Click);
            // 
            // mnuiZeroQtys
            // 
            this.mnuiZeroQtys.Text = "Set all Qty to zero";
            this.mnuiZeroQtys.Click += new System.EventHandler(this.mnuiZeroQtys_Click);
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tbpHeader);
            this.tabControl1.Controls.Add(this.tbpItems);
            this.tabControl1.Controls.Add(this.tbpMessages);
            this.tabControl1.Location = new System.Drawing.Point(0, 26);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(242, 237);
            this.tabControl1.TabIndex = 0;
            // 
            // tbpHeader
            // 
            this.tbpHeader.Controls.Add(this.lblStatusBar);
            this.tbpHeader.Controls.Add(this.pnlMiddleBack);
            this.tbpHeader.Controls.Add(this.pnltopback);
            this.tbpHeader.Controls.Add(this.lblStatusBar_Back);
            this.tbpHeader.Location = new System.Drawing.Point(4, 25);
            this.tbpHeader.Name = "tbpHeader";
            this.tbpHeader.Size = new System.Drawing.Size(234, 208);
            this.tbpHeader.Text = "Header";
            // 
            // lblStatusBar
            // 
            this.lblStatusBar.Location = new System.Drawing.Point(2, 184);
            this.lblStatusBar.Name = "lblStatusBar";
            this.lblStatusBar.Size = new System.Drawing.Size(227, 18);
            // 
            // pnlMiddleBack
            // 
            this.pnlMiddleBack.BackColor = System.Drawing.Color.Black;
            this.pnlMiddleBack.Controls.Add(this.pnlMiddleTop);
            this.pnlMiddleBack.Location = new System.Drawing.Point(2, 38);
            this.pnlMiddleBack.Name = "pnlMiddleBack";
            this.pnlMiddleBack.Size = new System.Drawing.Size(228, 140);
            // 
            // pnlMiddleTop
            // 
            this.pnlMiddleTop.BackColor = System.Drawing.Color.AliceBlue;
            this.pnlMiddleTop.Controls.Add(this.dateTimePicker1);
            this.pnlMiddleTop.Controls.Add(this.txtRecipient);
            this.pnlMiddleTop.Controls.Add(this.cmdGetRecipients);
            this.pnlMiddleTop.Controls.Add(this.comboMvtType);
            this.pnlMiddleTop.Controls.Add(this.comboRecipient);
            this.pnlMiddleTop.Controls.Add(this.txtDocHeader);
            this.pnlMiddleTop.Controls.Add(this.lblMovementType);
            this.pnlMiddleTop.Controls.Add(this.lblRecipient);
            this.pnlMiddleTop.Controls.Add(this.lblDocHeader);
            this.pnlMiddleTop.Controls.Add(this.lblDocDate);
            this.pnlMiddleTop.Controls.Add(this.txtHeaderText);
            this.pnlMiddleTop.Location = new System.Drawing.Point(1, 1);
            this.pnlMiddleTop.Name = "pnlMiddleTop";
            this.pnlMiddleTop.Size = new System.Drawing.Size(226, 137);
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker1.Location = new System.Drawing.Point(72, 31);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(146, 24);
            this.dateTimePicker1.TabIndex = 3;
            this.dateTimePicker1.ValueChanged += new System.EventHandler(this.dateTimePicker1_ValueChanged);
            // 
            // txtRecipient
            // 
            this.txtRecipient.Location = new System.Drawing.Point(72, 33);
            this.txtRecipient.Name = "txtRecipient";
            this.txtRecipient.Size = new System.Drawing.Size(144, 23);
            this.txtRecipient.TabIndex = 14;
            this.txtRecipient.Visible = false;
            this.txtRecipient.TextChanged += new System.EventHandler(this.txtRecipient_TextChanged);
            // 
            // cmdGetRecipients
            // 
            this.cmdGetRecipients.Location = new System.Drawing.Point(81, 44);
            this.cmdGetRecipients.Name = "cmdGetRecipients";
            this.cmdGetRecipients.Size = new System.Drawing.Size(56, 20);
            this.cmdGetRecipients.TabIndex = 15;
            this.cmdGetRecipients.Text = "Assign someone else";
            this.cmdGetRecipients.Visible = false;
            // 
            // comboMvtType
            // 
            this.comboMvtType.Location = new System.Drawing.Point(72, 110);
            this.comboMvtType.Name = "comboMvtType";
            this.comboMvtType.Size = new System.Drawing.Size(144, 23);
            this.comboMvtType.TabIndex = 13;
            this.comboMvtType.SelectedIndexChanged += new System.EventHandler(this.comboMvtType_SelectedIndexChanged);
            // 
            // comboRecipient
            // 
            this.comboRecipient.Location = new System.Drawing.Point(72, 84);
            this.comboRecipient.Name = "comboRecipient";
            this.comboRecipient.Size = new System.Drawing.Size(144, 23);
            this.comboRecipient.TabIndex = 3;
            this.comboRecipient.SelectedIndexChanged += new System.EventHandler(this.comboRecipient_SelectedIndexChanged);
            // 
            // txtDocHeader
            // 
            this.txtDocHeader.Location = new System.Drawing.Point(72, 58);
            this.txtDocHeader.Name = "txtDocHeader";
            this.txtDocHeader.Size = new System.Drawing.Size(144, 23);
            this.txtDocHeader.TabIndex = 12;
            // 
            // lblMovementType
            // 
            this.lblMovementType.Location = new System.Drawing.Point(3, 110);
            this.lblMovementType.Name = "lblMovementType";
            this.lblMovementType.Size = new System.Drawing.Size(65, 16);
            this.lblMovementType.Text = "Mvt. Type";
            // 
            // lblRecipient
            // 
            this.lblRecipient.Location = new System.Drawing.Point(2, 85);
            this.lblRecipient.Name = "lblRecipient";
            this.lblRecipient.Size = new System.Drawing.Size(65, 16);
            this.lblRecipient.Text = "Recipient";
            // 
            // lblDocHeader
            // 
            this.lblDocHeader.Location = new System.Drawing.Point(2, 62);
            this.lblDocHeader.Name = "lblDocHeader";
            this.lblDocHeader.Size = new System.Drawing.Size(65, 16);
            this.lblDocHeader.Text = "Doc Header ";
            // 
            // lblDocDate
            // 
            this.lblDocDate.Location = new System.Drawing.Point(2, 34);
            this.lblDocDate.Name = "lblDocDate";
            this.lblDocDate.Size = new System.Drawing.Size(65, 16);
            this.lblDocDate.Text = "Doc Date";
            // 
            // txtHeaderText
            // 
            this.txtHeaderText.Location = new System.Drawing.Point(3, 4);
            this.txtHeaderText.Name = "txtHeaderText";
            this.txtHeaderText.ReadOnly = true;
            this.txtHeaderText.Size = new System.Drawing.Size(215, 23);
            this.txtHeaderText.TabIndex = 3;
            // 
            // pnltopback
            // 
            this.pnltopback.BackColor = System.Drawing.Color.Black;
            this.pnltopback.Controls.Add(this.pnlTopFront);
            this.pnltopback.Location = new System.Drawing.Point(2, 2);
            this.pnltopback.Name = "pnltopback";
            this.pnltopback.Size = new System.Drawing.Size(228, 32);
            // 
            // pnlTopFront
            // 
            this.pnlTopFront.BackColor = System.Drawing.Color.WhiteSmoke;
            this.pnlTopFront.Controls.Add(this.cmdGetWO);
            this.pnlTopFront.Controls.Add(this.txtWO);
            this.pnlTopFront.Controls.Add(this.lblWO);
            this.pnlTopFront.Location = new System.Drawing.Point(1, 1);
            this.pnlTopFront.Name = "pnlTopFront";
            this.pnlTopFront.Size = new System.Drawing.Size(226, 30);
            // 
            // cmdGetWO
            // 
            this.cmdGetWO.Location = new System.Drawing.Point(180, 3);
            this.cmdGetWO.Name = "cmdGetWO";
            this.cmdGetWO.Size = new System.Drawing.Size(43, 20);
            this.cmdGetWO.TabIndex = 2;
            this.cmdGetWO.Text = "OK";
            this.cmdGetWO.Click += new System.EventHandler(this.cmdGetWO_Click);
            // 
            // txtWO
            // 
            this.txtWO.Location = new System.Drawing.Point(74, 3);
            this.txtWO.Name = "txtWO";
            this.txtWO.Size = new System.Drawing.Size(100, 23);
            this.txtWO.TabIndex = 3;
            this.txtWO.TextChanged += new System.EventHandler(this.txtWO_TextChanged);
            // 
            // lblWO
            // 
            this.lblWO.Font = new System.Drawing.Font("Tahoma", 8F, System.Drawing.FontStyle.Regular);
            this.lblWO.Location = new System.Drawing.Point(2, 9);
            this.lblWO.Name = "lblWO";
            this.lblWO.Size = new System.Drawing.Size(65, 14);
            this.lblWO.Text = "WO Number";
            // 
            // lblStatusBar_Back
            // 
            this.lblStatusBar_Back.BackColor = System.Drawing.Color.Black;
            this.lblStatusBar_Back.Location = new System.Drawing.Point(1, 183);
            this.lblStatusBar_Back.Name = "lblStatusBar_Back";
            this.lblStatusBar_Back.Size = new System.Drawing.Size(229, 20);
            // 
            // tbpItems
            // 
            this.tbpItems.Controls.Add(this.lblSaving);
            this.tbpItems.Controls.Add(this.comboLookUp);
            this.tbpItems.Controls.Add(this.comboUOM);
            this.tbpItems.Controls.Add(this.comboSloc);
            this.tbpItems.Controls.Add(this.txtEdit);
            this.tbpItems.Controls.Add(this.comboActype);
            this.tbpItems.Controls.Add(this.dgItems);
            this.tbpItems.Controls.Add(this.pnlImageHoldDeleteItem);
            this.tbpItems.Controls.Add(this.cmdPost);
            this.tbpItems.Location = new System.Drawing.Point(4, 25);
            this.tbpItems.Name = "tbpItems";
            this.tbpItems.Size = new System.Drawing.Size(234, 208);
            this.tbpItems.Text = "Items";
            // 
            // lblSaving
            // 
            this.lblSaving.ForeColor = System.Drawing.Color.Black;
            this.lblSaving.Location = new System.Drawing.Point(4, 202);
            this.lblSaving.Name = "lblSaving";
            this.lblSaving.Size = new System.Drawing.Size(240, 24);
            this.lblSaving.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.lblSaving.Visible = false;
            // 
            // comboLookUp
            // 
            this.comboLookUp.Location = new System.Drawing.Point(4, 97);
            this.comboLookUp.Name = "comboLookUp";
            this.comboLookUp.Size = new System.Drawing.Size(100, 23);
            this.comboLookUp.TabIndex = 10;
            this.comboLookUp.Visible = false;
            this.comboLookUp.TextChanged += new System.EventHandler(this.comboLookUp_SelectedIndexChanged);
            // 
            // comboUOM
            // 
            this.comboUOM.Location = new System.Drawing.Point(110, 68);
            this.comboUOM.Name = "comboUOM";
            this.comboUOM.Size = new System.Drawing.Size(100, 23);
            this.comboUOM.TabIndex = 9;
            this.comboUOM.Visible = false;
            this.comboUOM.TextChanged += new System.EventHandler(this.comboUOM_SelectedIndexChanged);
            // 
            // comboSloc
            // 
            this.comboSloc.Location = new System.Drawing.Point(4, 68);
            this.comboSloc.Name = "comboSloc";
            this.comboSloc.Size = new System.Drawing.Size(100, 23);
            this.comboSloc.TabIndex = 8;
            this.comboSloc.Visible = false;
            this.comboSloc.SelectedIndexChanged += new System.EventHandler(this.comboSloc_SelectedIndexChanged);
            // 
            // txtEdit
            // 
            this.txtEdit.Location = new System.Drawing.Point(110, 39);
            this.txtEdit.Name = "txtEdit";
            this.txtEdit.Size = new System.Drawing.Size(100, 23);
            this.txtEdit.TabIndex = 7;
            this.txtEdit.Visible = false;
            this.txtEdit.TextChanged += new System.EventHandler(this.txtEdit_TextChanged);
            // 
            // comboActype
            // 
            this.comboActype.Location = new System.Drawing.Point(4, 39);
            this.comboActype.Name = "comboActype";
            this.comboActype.Size = new System.Drawing.Size(100, 23);
            this.comboActype.TabIndex = 6;
            this.comboActype.Visible = false;
            this.comboActype.SelectedIndexChanged += new System.EventHandler(this.comboActype_SelectedIndexChanged);
            // 
            // dgItems
            // 
            this.dgItems.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgItems.Location = new System.Drawing.Point(4, 30);
            this.dgItems.Name = "dgItems";
            this.dgItems.Size = new System.Drawing.Size(230, 97);
            this.dgItems.TabIndex = 2;
            this.dgItems.Click += new System.EventHandler(this.dgItems_Click);
            // 
            // pnlImageHoldDeleteItem
            // 
            this.pnlImageHoldDeleteItem.Controls.Add(this.imgDeleteItem);
            this.pnlImageHoldDeleteItem.Location = new System.Drawing.Point(211, 4);
            this.pnlImageHoldDeleteItem.Name = "pnlImageHoldDeleteItem";
            this.pnlImageHoldDeleteItem.Size = new System.Drawing.Size(22, 22);
            // 
            // imgDeleteItem
            // 
            this.imgDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("imgDeleteItem.Image")));
            this.imgDeleteItem.Location = new System.Drawing.Point(3, 4);
            this.imgDeleteItem.Name = "imgDeleteItem";
            this.imgDeleteItem.Size = new System.Drawing.Size(15, 16);
            this.imgDeleteItem.Click += new System.EventHandler(this.imgDeleteItem_Click_1);
            // 
            // cmdPost
            // 
            this.cmdPost.Location = new System.Drawing.Point(56, 4);
            this.cmdPost.Name = "cmdPost";
            this.cmdPost.Size = new System.Drawing.Size(128, 20);
            this.cmdPost.TabIndex = 0;
            this.cmdPost.Text = "Post";
            this.cmdPost.Click += new System.EventHandler(this.cmdPost_Click);
            // 
            // tbpMessages
            // 
            this.tbpMessages.Controls.Add(this.dgMessages);
            this.tbpMessages.Location = new System.Drawing.Point(4, 25);
            this.tbpMessages.Name = "tbpMessages";
            this.tbpMessages.Size = new System.Drawing.Size(234, 208);
            this.tbpMessages.Text = "Messages";
            // 
            // dgMessages
            // 
            this.dgMessages.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgMessages.Location = new System.Drawing.Point(3, 3);
            this.dgMessages.Name = "dgMessages";
            this.dgMessages.Size = new System.Drawing.Size(240, 200);
            this.dgMessages.TabIndex = 0;
            // 
            // frmPMGM
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ClientSize = new System.Drawing.Size(242, 265);
            this.Controls.Add(this.tabControl1);
            this.Menu = this.mainMenu1;
            this.Name = "frmPMGM";
            this.Text = "WO Issue";
            this.Closing += new System.ComponentModel.CancelEventHandler(this.frmPMGM_Closing);
            this.Load += new System.EventHandler(this.frmPMGM_Load);
            this.tabControl1.ResumeLayout(false);
            this.tbpHeader.ResumeLayout(false);
            this.pnlMiddleBack.ResumeLayout(false);
            this.pnlMiddleTop.ResumeLayout(false);
            this.pnltopback.ResumeLayout(false);
            this.pnlTopFront.ResumeLayout(false);
            this.tbpItems.ResumeLayout(false);
            this.pnlImageHoldDeleteItem.ResumeLayout(false);
            this.tbpMessages.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.MenuItem mnuiShowLog;
        private System.Windows.Forms.Label lblSaving;
        public System.Windows.Forms.MenuItem mnuiDebugOn;
        private System.Windows.Forms.TabPage tbpHeader;
        private System.Windows.Forms.Panel pnlMiddleBack;
        private System.Windows.Forms.Panel pnlMiddleTop;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.TextBox txtRecipient;
        private System.Windows.Forms.Button cmdGetRecipients;
        private System.Windows.Forms.ComboBox comboMvtType;
        private System.Windows.Forms.ComboBox comboRecipient;
        private System.Windows.Forms.TextBox txtDocHeader;
        private System.Windows.Forms.Label lblMovementType;
        private System.Windows.Forms.Label lblRecipient;
        private System.Windows.Forms.Label lblDocHeader;
        private System.Windows.Forms.Label lblDocDate;
        private System.Windows.Forms.TextBox txtHeaderText;
        private System.Windows.Forms.Panel pnltopback;
        private System.Windows.Forms.Panel pnlTopFront;
        private System.Windows.Forms.Button cmdGetWO;
        public System.Windows.Forms.TextBox txtWO;
        private System.Windows.Forms.Label lblWO;
        private System.Windows.Forms.MenuItem mnuiHelp;
        public System.Windows.Forms.Label lblStatusBar;
        public System.Windows.Forms.Panel lblStatusBar_Back;



    }
}