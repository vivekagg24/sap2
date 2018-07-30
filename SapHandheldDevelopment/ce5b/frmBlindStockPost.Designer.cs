namespace ce5b
{
    partial class frmBlindStockPost
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tbpSerial;
        private System.Windows.Forms.TabPage tbpOverview;
        private System.Windows.Forms.DataGrid dgOverview;
        private System.Windows.Forms.DataGrid dgSerial;
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
        private System.Windows.Forms.Button cmdGoto;

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
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tbpOverview = new System.Windows.Forms.TabPage();
            this.button1 = new System.Windows.Forms.Button();
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
            this.tbpOverview.SuspendLayout();
            this.tbpVariance.SuspendLayout();
            this.tbpMessages.SuspendLayout();
            this.tbpSerial.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tbpOverview);
            this.tabControl1.Controls.Add(this.tbpVariance);
            this.tabControl1.Controls.Add(this.tbpMessages);
            this.tabControl1.Controls.Add(this.tbpSerial);
            this.tabControl1.Location = new System.Drawing.Point(0, 16);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(237, 238);
            this.tabControl1.TabIndex = 0;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // tbpOverview
            // 
            this.tbpOverview.Controls.Add(this.button1);
            this.tbpOverview.Controls.Add(this.cmdGoto);
            this.tbpOverview.Controls.Add(this.cmdPost);
            this.tbpOverview.Controls.Add(this.txtEdit);
            this.tbpOverview.Controls.Add(this.dgOverview);
            this.tbpOverview.Controls.Add(this.chkZero);
            this.tbpOverview.Location = new System.Drawing.Point(4, 25);
            this.tbpOverview.Name = "tbpOverview";
            this.tbpOverview.Size = new System.Drawing.Size(229, 209);
            this.tbpOverview.Text = "All";
            this.tbpOverview.Click += new System.EventHandler(this.tbpOverview_Click);
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.Red;
            this.button1.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular);
            this.button1.Location = new System.Drawing.Point(183, 4);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(42, 24);
            this.button1.TabIndex = 5;
            this.button1.Text = "Delete";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // cmdGoto
            // 
            this.cmdGoto.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular);
            this.cmdGoto.Location = new System.Drawing.Point(120, 4);
            this.cmdGoto.Name = "cmdGoto";
            this.cmdGoto.Size = new System.Drawing.Size(60, 24);
            this.cmdGoto.TabIndex = 0;
            this.cmdGoto.Text = "Goto Line";
            this.cmdGoto.Click += new System.EventHandler(this.cmdGoto_Click);
            // 
            // cmdPost
            // 
            this.cmdPost.Location = new System.Drawing.Point(80, 4);
            this.cmdPost.Name = "cmdPost";
            this.cmdPost.Size = new System.Drawing.Size(35, 24);
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
            this.dgOverview.Location = new System.Drawing.Point(1, 35);
            this.dgOverview.Name = "dgOverview";
            this.dgOverview.Size = new System.Drawing.Size(225, 170);
            this.dgOverview.TabIndex = 3;
            this.dgOverview.CurrentCellChanged += new System.EventHandler(this.dgOverview_CurrentCellChanged);
            this.dgOverview.Click += new System.EventHandler(this.dgOverview_Click);
            // 
            // chkZero
            // 
            this.chkZero.Location = new System.Drawing.Point(1, 8);
            this.chkZero.Name = "chkZero";
            this.chkZero.Size = new System.Drawing.Size(80, 20);
            this.chkZero.TabIndex = 4;
            this.chkZero.Text = "Post Zero";
            this.chkZero.Click += new System.EventHandler(this.chkZero_Click);
            this.chkZero.CheckStateChanged += new System.EventHandler(this.chkZero_CheckStateChanged);
            // 
            // tbpVariance
            // 
            this.tbpVariance.Controls.Add(this.cmdConfirm);
            this.tbpVariance.Controls.Add(this.dgVariance);
            this.tbpVariance.Location = new System.Drawing.Point(4, 25);
            this.tbpVariance.Name = "tbpVariance";
            this.tbpVariance.Size = new System.Drawing.Size(229, 209);
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
            this.tbpMessages.Size = new System.Drawing.Size(229, 209);
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
            this.tbpSerial.Size = new System.Drawing.Size(229, 209);
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
            this.dgSerial.Size = new System.Drawing.Size(214, 195);
            this.dgSerial.TabIndex = 1;
            this.dgSerial.CurrentCellChanged += new System.EventHandler(this.dgSerial_CurrentCellChanged);
            this.dgSerial.Click += new System.EventHandler(this.dgSerial_Click);
            // 
            // frmBlindStockPost
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.Controls.Add(this.tabControl1);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmBlindStockPost";
            this.Text = "Stock Count";
            this.Closing += new System.ComponentModel.CancelEventHandler(this.frmStockCountMain_Closing);
            this.Load += new System.EventHandler(this.frmStockCountMain_Load);
            this.tabControl1.ResumeLayout(false);
            this.tbpOverview.ResumeLayout(false);
            this.tbpVariance.ResumeLayout(false);
            this.tbpMessages.ResumeLayout(false);
            this.tbpSerial.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
    }
}