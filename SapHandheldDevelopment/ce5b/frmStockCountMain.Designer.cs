namespace ce5b
{
    partial class frmStockCountMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        public System.Windows.Forms.StatusBar statusBar1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tbpCurrent;
        private System.Windows.Forms.TabPage tbpSerial;
        private System.Windows.Forms.TabPage tbpOverview;
        private System.Windows.Forms.Panel pnlMainBack;
        private System.Windows.Forms.Label lblPlant;
        private System.Windows.Forms.TextBox txtPlant;
        private System.Windows.Forms.Label lblBin;
        private System.Windows.Forms.TextBox txtBin;
        private System.Windows.Forms.Label lblSloc;
        private System.Windows.Forms.TextBox txtSloc;
        private System.Windows.Forms.TextBox txtMaterial;
        private System.Windows.Forms.Label lblMaterial;
        private System.Windows.Forms.TextBox txtOldMat;
        private System.Windows.Forms.Label lblOldMat;
        private System.Windows.Forms.TextBox txtMtnr;
        private System.Windows.Forms.TextBox txtQty;
        private System.Windows.Forms.TextBox txtUOM;
        private System.Windows.Forms.Button cmdPrev;
        private System.Windows.Forms.Button cmdNext;
        private System.Windows.Forms.Label lblCount;
        private System.Windows.Forms.DataGrid dgOverview;
        private System.Windows.Forms.DataGrid dgSerial;
        private System.Windows.Forms.CheckBox chkSerial;
        private System.Windows.Forms.TextBox txtSernrEdit;
        private System.Windows.Forms.TextBox txtEdit;
        private System.Windows.Forms.TabPage tbpVariance;
        private System.Windows.Forms.DataGrid dgVariance;
        private System.Windows.Forms.Button cmdPost;
        private System.Windows.Forms.CheckBox chkZero;
        private System.Windows.Forms.Button cmdConfirm;
        private System.Windows.Forms.TabPage tbpMessages;
        private System.Windows.Forms.DataGrid dgAlert;
        private System.Windows.Forms.DataGridTableStyle dataGridTableStyle1;
        private System.Windows.Forms.DataGridTextBoxColumn dataGridTextBoxColumn1;
        private System.Windows.Forms.TextBox txtItem;
        private System.Windows.Forms.Button cmdGoto;
        private System.Windows.Forms.Panel pnlMainFront;

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
            this.statusBar1 = new System.Windows.Forms.StatusBar();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tbpCurrent = new System.Windows.Forms.TabPage();
            this.pnlMainBack = new System.Windows.Forms.Panel();
            this.pnlMainFront = new System.Windows.Forms.Panel();
            this.txtItem = new System.Windows.Forms.TextBox();
            this.lblCount = new System.Windows.Forms.Label();
            this.cmdNext = new System.Windows.Forms.Button();
            this.cmdPrev = new System.Windows.Forms.Button();
            this.txtUOM = new System.Windows.Forms.TextBox();
            this.txtQty = new System.Windows.Forms.TextBox();
            this.txtMtnr = new System.Windows.Forms.TextBox();
            this.txtOldMat = new System.Windows.Forms.TextBox();
            this.lblOldMat = new System.Windows.Forms.Label();
            this.txtMaterial = new System.Windows.Forms.TextBox();
            this.lblMaterial = new System.Windows.Forms.Label();
            this.txtBin = new System.Windows.Forms.TextBox();
            this.lblBin = new System.Windows.Forms.Label();
            this.txtPlant = new System.Windows.Forms.TextBox();
            this.lblPlant = new System.Windows.Forms.Label();
            this.lblSloc = new System.Windows.Forms.Label();
            this.txtSloc = new System.Windows.Forms.TextBox();
            this.chkSerial = new System.Windows.Forms.CheckBox();
            this.tbpOverview = new System.Windows.Forms.TabPage();
            this.cmdGoto = new System.Windows.Forms.Button();
            this.cmdPost = new System.Windows.Forms.Button();
            this.txtEdit = new System.Windows.Forms.TextBox();
            this.dgOverview = new System.Windows.Forms.DataGrid();
            this.chkZero = new System.Windows.Forms.CheckBox();
            this.tbpVariance = new System.Windows.Forms.TabPage();
            this.cmdConfirm = new System.Windows.Forms.Button();
            this.dgVariance = new System.Windows.Forms.DataGrid();
            this.tbpMessages = new System.Windows.Forms.TabPage();
            this.dgAlert = new System.Windows.Forms.DataGrid();
            this.dataGridTableStyle1 = new System.Windows.Forms.DataGridTableStyle();
            this.dataGridTextBoxColumn1 = new System.Windows.Forms.DataGridTextBoxColumn();
            this.tbpSerial = new System.Windows.Forms.TabPage();
            this.txtSernrEdit = new System.Windows.Forms.TextBox();
            this.dgSerial = new System.Windows.Forms.DataGrid();
            this.tabControl1.SuspendLayout();
            this.tbpCurrent.SuspendLayout();
            this.pnlMainBack.SuspendLayout();
            this.pnlMainFront.SuspendLayout();
            this.tbpOverview.SuspendLayout();
            this.tbpVariance.SuspendLayout();
            this.tbpMessages.SuspendLayout();
            this.tbpSerial.SuspendLayout();
            this.SuspendLayout();
            // 
            // statusBar1
            // 
            this.statusBar1.Location = new System.Drawing.Point(0, 264);
            this.statusBar1.Name = "statusBar1";
            this.statusBar1.Size = new System.Drawing.Size(242, 24);
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tbpCurrent);
            this.tabControl1.Controls.Add(this.tbpOverview);
            this.tabControl1.Controls.Add(this.tbpVariance);
            this.tabControl1.Controls.Add(this.tbpMessages);
            this.tabControl1.Controls.Add(this.tbpSerial);
            this.tabControl1.Location = new System.Drawing.Point(2, 10);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(237, 247);
            this.tabControl1.TabIndex = 0;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // tbpCurrent
            // 
            this.tbpCurrent.Controls.Add(this.pnlMainBack);
            this.tbpCurrent.Location = new System.Drawing.Point(4, 25);
            this.tbpCurrent.Name = "tbpCurrent";
            this.tbpCurrent.Size = new System.Drawing.Size(229, 218);
            this.tbpCurrent.Text = "Current";
            this.tbpCurrent.Click += new System.EventHandler(this.tbpCurrent_Click);
            // 
            // pnlMainBack
            // 
            this.pnlMainBack.BackColor = System.Drawing.Color.Black;
            this.pnlMainBack.Controls.Add(this.pnlMainFront);
            this.pnlMainBack.Location = new System.Drawing.Point(8, 8);
            this.pnlMainBack.Name = "pnlMainBack";
            this.pnlMainBack.Size = new System.Drawing.Size(216, 208);
            // 
            // pnlMainFront
            // 
            this.pnlMainFront.BackColor = System.Drawing.Color.AliceBlue;
            this.pnlMainFront.Controls.Add(this.txtItem);
            this.pnlMainFront.Controls.Add(this.lblCount);
            this.pnlMainFront.Controls.Add(this.cmdNext);
            this.pnlMainFront.Controls.Add(this.cmdPrev);
            this.pnlMainFront.Controls.Add(this.txtUOM);
            this.pnlMainFront.Controls.Add(this.txtQty);
            this.pnlMainFront.Controls.Add(this.txtMtnr);
            this.pnlMainFront.Controls.Add(this.txtOldMat);
            this.pnlMainFront.Controls.Add(this.lblOldMat);
            this.pnlMainFront.Controls.Add(this.txtMaterial);
            this.pnlMainFront.Controls.Add(this.lblMaterial);
            this.pnlMainFront.Controls.Add(this.txtBin);
            this.pnlMainFront.Controls.Add(this.lblBin);
            this.pnlMainFront.Controls.Add(this.txtPlant);
            this.pnlMainFront.Controls.Add(this.lblPlant);
            this.pnlMainFront.Controls.Add(this.lblSloc);
            this.pnlMainFront.Controls.Add(this.txtSloc);
            this.pnlMainFront.Controls.Add(this.chkSerial);
            this.pnlMainFront.Location = new System.Drawing.Point(1, 1);
            this.pnlMainFront.Name = "pnlMainFront";
            this.pnlMainFront.Size = new System.Drawing.Size(213, 205);
            // 
            // txtItem
            // 
            this.txtItem.Location = new System.Drawing.Point(136, 176);
            this.txtItem.Name = "txtItem";
            this.txtItem.ReadOnly = true;
            this.txtItem.Size = new System.Drawing.Size(72, 23);
            this.txtItem.TabIndex = 0;
            // 
            // lblCount
            // 
            this.lblCount.Location = new System.Drawing.Point(8, 154);
            this.lblCount.Name = "lblCount";
            this.lblCount.Size = new System.Drawing.Size(48, 20);
            this.lblCount.Text = "Count";
            // 
            // cmdNext
            // 
            this.cmdNext.Location = new System.Drawing.Point(96, 176);
            this.cmdNext.Name = "cmdNext";
            this.cmdNext.Size = new System.Drawing.Size(32, 24);
            this.cmdNext.TabIndex = 2;
            this.cmdNext.Text = ">";
            this.cmdNext.Click += new System.EventHandler(this.cmdNext_Click);
            // 
            // cmdPrev
            // 
            this.cmdPrev.Location = new System.Drawing.Point(64, 176);
            this.cmdPrev.Name = "cmdPrev";
            this.cmdPrev.Size = new System.Drawing.Size(32, 24);
            this.cmdPrev.TabIndex = 3;
            this.cmdPrev.Text = "<";
            this.cmdPrev.Click += new System.EventHandler(this.cmdPrev_Click);
            // 
            // txtUOM
            // 
            this.txtUOM.Location = new System.Drawing.Point(144, 152);
            this.txtUOM.Name = "txtUOM";
            this.txtUOM.ReadOnly = true;
            this.txtUOM.Size = new System.Drawing.Size(64, 23);
            this.txtUOM.TabIndex = 4;
            // 
            // txtQty
            // 
            this.txtQty.Location = new System.Drawing.Point(64, 152);
            this.txtQty.Name = "txtQty";
            this.txtQty.Size = new System.Drawing.Size(80, 23);
            this.txtQty.TabIndex = 5;
            this.txtQty.Validated += new System.EventHandler(this.txtQty_Validated);
            this.txtQty.TextChanged += new System.EventHandler(this.txtQty_TextChanged);
            // 
            // txtMtnr
            // 
            this.txtMtnr.Location = new System.Drawing.Point(64, 104);
            this.txtMtnr.Name = "txtMtnr";
            this.txtMtnr.ReadOnly = true;
            this.txtMtnr.Size = new System.Drawing.Size(144, 23);
            this.txtMtnr.TabIndex = 6;
            // 
            // txtOldMat
            // 
            this.txtOldMat.Location = new System.Drawing.Point(64, 128);
            this.txtOldMat.Name = "txtOldMat";
            this.txtOldMat.ReadOnly = true;
            this.txtOldMat.Size = new System.Drawing.Size(144, 23);
            this.txtOldMat.TabIndex = 7;
            // 
            // lblOldMat
            // 
            this.lblOldMat.Location = new System.Drawing.Point(8, 130);
            this.lblOldMat.Name = "lblOldMat";
            this.lblOldMat.Size = new System.Drawing.Size(56, 20);
            this.lblOldMat.Text = "Old Mat.";
            // 
            // txtMaterial
            // 
            this.txtMaterial.Location = new System.Drawing.Point(64, 80);
            this.txtMaterial.Name = "txtMaterial";
            this.txtMaterial.ReadOnly = true;
            this.txtMaterial.Size = new System.Drawing.Size(144, 23);
            this.txtMaterial.TabIndex = 9;
            this.txtMaterial.TextChanged += new System.EventHandler(this.txtMaterial_TextChanged);
            // 
            // lblMaterial
            // 
            this.lblMaterial.Location = new System.Drawing.Point(8, 94);
            this.lblMaterial.Name = "lblMaterial";
            this.lblMaterial.Size = new System.Drawing.Size(56, 20);
            this.lblMaterial.Text = "Material";
            // 
            // txtBin
            // 
            this.txtBin.Location = new System.Drawing.Point(64, 56);
            this.txtBin.Name = "txtBin";
            this.txtBin.ReadOnly = true;
            this.txtBin.Size = new System.Drawing.Size(144, 23);
            this.txtBin.TabIndex = 11;
            // 
            // lblBin
            // 
            this.lblBin.Location = new System.Drawing.Point(8, 60);
            this.lblBin.Name = "lblBin";
            this.lblBin.Size = new System.Drawing.Size(40, 20);
            this.lblBin.Text = "Bin";
            // 
            // txtPlant
            // 
            this.txtPlant.Location = new System.Drawing.Point(64, 8);
            this.txtPlant.Name = "txtPlant";
            this.txtPlant.ReadOnly = true;
            this.txtPlant.Size = new System.Drawing.Size(144, 23);
            this.txtPlant.TabIndex = 13;
            this.txtPlant.TextChanged += new System.EventHandler(this.txtPlant_TextChanged);
            // 
            // lblPlant
            // 
            this.lblPlant.Location = new System.Drawing.Point(8, 10);
            this.lblPlant.Name = "lblPlant";
            this.lblPlant.Size = new System.Drawing.Size(48, 20);
            this.lblPlant.Text = "Plant";
            // 
            // lblSloc
            // 
            this.lblSloc.Location = new System.Drawing.Point(8, 34);
            this.lblSloc.Name = "lblSloc";
            this.lblSloc.Size = new System.Drawing.Size(40, 20);
            this.lblSloc.Text = "S Loc";
            // 
            // txtSloc
            // 
            this.txtSloc.Location = new System.Drawing.Point(64, 32);
            this.txtSloc.Name = "txtSloc";
            this.txtSloc.ReadOnly = true;
            this.txtSloc.Size = new System.Drawing.Size(144, 23);
            this.txtSloc.TabIndex = 16;
            // 
            // chkSerial
            // 
            this.chkSerial.Enabled = false;
            this.chkSerial.Location = new System.Drawing.Point(8, 176);
            this.chkSerial.Name = "chkSerial";
            this.chkSerial.Size = new System.Drawing.Size(60, 20);
            this.chkSerial.TabIndex = 17;
            this.chkSerial.Text = "Serial";
            this.chkSerial.CheckStateChanged += new System.EventHandler(this.chkSerial_CheckStateChanged);
            // 
            // tbpOverview
            // 
            this.tbpOverview.Controls.Add(this.cmdGoto);
            this.tbpOverview.Controls.Add(this.cmdPost);
            this.tbpOverview.Controls.Add(this.txtEdit);
            this.tbpOverview.Controls.Add(this.dgOverview);
            this.tbpOverview.Controls.Add(this.chkZero);
            this.tbpOverview.Location = new System.Drawing.Point(4, 25);
            this.tbpOverview.Name = "tbpOverview";
            this.tbpOverview.Size = new System.Drawing.Size(229, 218);
            this.tbpOverview.Text = "All";
            // 
            // cmdGoto
            // 
            this.cmdGoto.Location = new System.Drawing.Point(152, 4);
            this.cmdGoto.Name = "cmdGoto";
            this.cmdGoto.Size = new System.Drawing.Size(72, 24);
            this.cmdGoto.TabIndex = 0;
            this.cmdGoto.Text = "Goto Line";
            this.cmdGoto.Click += new System.EventHandler(this.cmdGoto_Click);
            // 
            // cmdPost
            // 
            this.cmdPost.Location = new System.Drawing.Point(88, 4);
            this.cmdPost.Name = "cmdPost";
            this.cmdPost.Size = new System.Drawing.Size(56, 24);
            this.cmdPost.TabIndex = 1;
            this.cmdPost.Text = "Post";
            this.cmdPost.Click += new System.EventHandler(this.cmdPost_Click);
            // 
            // txtEdit
            // 
            this.txtEdit.Location = new System.Drawing.Point(56, 88);
            this.txtEdit.Name = "txtEdit";
            this.txtEdit.Size = new System.Drawing.Size(100, 23);
            this.txtEdit.TabIndex = 2;
            this.txtEdit.Visible = false;
            this.txtEdit.TextChanged += new System.EventHandler(this.txtEdit_TextChanged);
            // 
            // dgOverview
            // 
            this.dgOverview.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgOverview.Location = new System.Drawing.Point(2, 32);
            this.dgOverview.Name = "dgOverview";
            this.dgOverview.Size = new System.Drawing.Size(232, 184);
            this.dgOverview.TabIndex = 3;
            this.dgOverview.Click += new System.EventHandler(this.dgOverview_Click);
            // 
            // chkZero
            // 
            this.chkZero.Location = new System.Drawing.Point(8, 8);
            this.chkZero.Name = "chkZero";
            this.chkZero.Size = new System.Drawing.Size(88, 20);
            this.chkZero.TabIndex = 4;
            this.chkZero.Text = "Post Zeros";
            this.chkZero.Click += new System.EventHandler(this.chkZero_Click);
            // 
            // tbpVariance
            // 
            this.tbpVariance.Controls.Add(this.cmdConfirm);
            this.tbpVariance.Controls.Add(this.dgVariance);
            this.tbpVariance.Location = new System.Drawing.Point(4, 25);
            this.tbpVariance.Name = "tbpVariance";
            this.tbpVariance.Size = new System.Drawing.Size(229, 218);
            this.tbpVariance.Text = "Variance";
            // 
            // cmdConfirm
            // 
            this.cmdConfirm.Location = new System.Drawing.Point(64, 8);
            this.cmdConfirm.Name = "cmdConfirm";
            this.cmdConfirm.Size = new System.Drawing.Size(96, 20);
            this.cmdConfirm.TabIndex = 0;
            this.cmdConfirm.Text = "Confirm Post";
            this.cmdConfirm.Visible = false;
            this.cmdConfirm.Click += new System.EventHandler(this.cmdConfirm_Click);
            // 
            // dgVariance
            // 
            this.dgVariance.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgVariance.Location = new System.Drawing.Point(2, 32);
            this.dgVariance.Name = "dgVariance";
            this.dgVariance.Size = new System.Drawing.Size(240, 176);
            this.dgVariance.TabIndex = 1;
            // 
            // tbpMessages
            // 
            this.tbpMessages.Controls.Add(this.dgAlert);
            this.tbpMessages.Location = new System.Drawing.Point(4, 25);
            this.tbpMessages.Name = "tbpMessages";
            this.tbpMessages.Size = new System.Drawing.Size(229, 218);
            this.tbpMessages.Text = "Alerts";
            // 
            // dgAlert
            // 
            this.dgAlert.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgAlert.Location = new System.Drawing.Point(2, 8);
            this.dgAlert.Name = "dgAlert";
            this.dgAlert.Size = new System.Drawing.Size(240, 200);
            this.dgAlert.TabIndex = 0;
            this.dgAlert.TableStyles.Add(this.dataGridTableStyle1);
            // 
            // dataGridTableStyle1
            // 
            this.dataGridTableStyle1.GridColumnStyles.Add(this.dataGridTextBoxColumn1);
            this.dataGridTableStyle1.MappingName = "Alerts";
            // 
            // dataGridTextBoxColumn1
            // 
            this.dataGridTextBoxColumn1.HeaderText = "Message";
            this.dataGridTextBoxColumn1.MappingName = "message";
            this.dataGridTextBoxColumn1.Width = 250;
            // 
            // tbpSerial
            // 
            this.tbpSerial.Controls.Add(this.txtSernrEdit);
            this.tbpSerial.Controls.Add(this.dgSerial);
            this.tbpSerial.Location = new System.Drawing.Point(4, 25);
            this.tbpSerial.Name = "tbpSerial";
            this.tbpSerial.Size = new System.Drawing.Size(229, 218);
            this.tbpSerial.Text = "Serial #";
            // 
            // txtSernrEdit
            // 
            this.txtSernrEdit.Location = new System.Drawing.Point(48, 96);
            this.txtSernrEdit.Name = "txtSernrEdit";
            this.txtSernrEdit.Size = new System.Drawing.Size(100, 23);
            this.txtSernrEdit.TabIndex = 0;
            this.txtSernrEdit.Visible = false;
            this.txtSernrEdit.LostFocus += new System.EventHandler(this.txtSernrEdit_LostFocus);
            this.txtSernrEdit.Validated += new System.EventHandler(this.txtSernrEdit_Validated);
            // 
            // dgSerial
            // 
            this.dgSerial.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.dgSerial.Location = new System.Drawing.Point(8, 8);
            this.dgSerial.Name = "dgSerial";
            this.dgSerial.Size = new System.Drawing.Size(216, 208);
            this.dgSerial.TabIndex = 1;
            this.dgSerial.CurrentCellChanged += new System.EventHandler(this.dgSerial_CurrentCellChanged);
            this.dgSerial.Click += new System.EventHandler(this.dgSerial_Click);
            // 
            // frmStockCountMain
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.statusBar1);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmStockCountMain";
            this.Text = "Stock Count";
            this.Closing += new System.ComponentModel.CancelEventHandler(this.frmStockCountMain_Closing);
            this.Load += new System.EventHandler(this.frmStockCountMain_Load);
            this.tabControl1.ResumeLayout(false);
            this.tbpCurrent.ResumeLayout(false);
            this.pnlMainBack.ResumeLayout(false);
            this.pnlMainFront.ResumeLayout(false);
            this.tbpOverview.ResumeLayout(false);
            this.tbpVariance.ResumeLayout(false);
            this.tbpMessages.ResumeLayout(false);
            this.tbpSerial.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
    }
}