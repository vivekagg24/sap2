namespace ce5b
{
    partial class frmPOGR
    {
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Button cmdGetPO;
        private System.Windows.Forms.Label lblPO;
        public System.Windows.Forms.TextBox txtPO;
        private System.Windows.Forms.DataGrid gridPOItems;
        private System.Windows.Forms.TextBox txtEdit;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtSupplier;
        private System.Windows.Forms.TextBox txtDelDate;
        private System.Windows.Forms.TextBox txtRequisitioner;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label lblCurrentPO;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.Button cmdGR;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtScanDoc;
        private System.Windows.Forms.TextBox txtDelNote;
        private System.Windows.Forms.DataGrid gridSernr;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.Panel panel6;
        private System.Windows.Forms.Panel panel7;
        private System.Windows.Forms.MainMenu mainMenu1;
        private System.Windows.Forms.MenuItem mnuiPO;
        private System.Windows.Forms.MenuItem mnuiExit;
        private System.Windows.Forms.MenuItem mnuiSearch;
        private System.Windows.Forms.MenuItem mnuiClear;
        private System.Windows.Forms.MenuItem mnuiQty;
        private System.Windows.Forms.MenuItem mnuiResetDefault;
        private System.Windows.Forms.MenuItem mnuiAllTo0;
        private System.Windows.Forms.MenuItem mnuiLogon;
        private System.Windows.Forms.MenuItem mnuiSerial;
        private System.Windows.Forms.MenuItem mnuiScan;
        private System.Windows.Forms.MenuItem mnuiType;
        private System.Windows.Forms.MenuItem mnuiClearSerial;
        private System.Windows.Forms.ComboBox comboSloc;
        private System.Windows.Forms.TextBox txtSernrEdit;
        private System.Windows.Forms.Panel panel8;
        private System.Windows.Forms.Panel panelImageHoldSearch;
        private System.Windows.Forms.PictureBox imgSearch;
        private System.Windows.Forms.Panel panel9;
        private System.Windows.Forms.MenuItem mnuiLogoff;
        private System.Windows.Forms.Panel panel10;
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
/*        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }
*/
        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmPOGR));
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.panel3 = new System.Windows.Forms.Panel();
            this.lblCurrentPO = new System.Windows.Forms.Label();
            this.panel5 = new System.Windows.Forms.Panel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel8 = new System.Windows.Forms.Panel();
            this.panelImageHoldSearch = new System.Windows.Forms.Panel();
            this.imgSearch = new System.Windows.Forms.PictureBox();
            this.lblPO = new System.Windows.Forms.Label();
            this.txtPO = new System.Windows.Forms.TextBox();
            this.cmdGetPO = new System.Windows.Forms.Button();
            this.panel6 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txtRequisitioner = new System.Windows.Forms.TextBox();
            this.txtDelDate = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtSupplier = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel7 = new System.Windows.Forms.Panel();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.comboSloc = new System.Windows.Forms.ComboBox();
            this.txtEdit = new System.Windows.Forms.TextBox();
            this.gridPOItems = new System.Windows.Forms.DataGrid();
            this.panel4 = new System.Windows.Forms.Panel();
            this.cmdGR = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.txtScanDoc = new System.Windows.Forms.TextBox();
            this.txtDelNote = new System.Windows.Forms.TextBox();
            this.panel9 = new System.Windows.Forms.Panel();
            this.panel10 = new System.Windows.Forms.Panel();
            this.mainMenu1 = new System.Windows.Forms.MainMenu();
            this.mnuiPO = new System.Windows.Forms.MenuItem();
            this.mnuiLogoff = new System.Windows.Forms.MenuItem();
            this.mnuiLogon = new System.Windows.Forms.MenuItem();
            this.mnuiClear = new System.Windows.Forms.MenuItem();
            this.mnuiSearch = new System.Windows.Forms.MenuItem();
            this.mnuiExit = new System.Windows.Forms.MenuItem();
            this.mnuiQty = new System.Windows.Forms.MenuItem();
            this.mnuiResetDefault = new System.Windows.Forms.MenuItem();
            this.mnuiAllTo0 = new System.Windows.Forms.MenuItem();
            this.mnuiSerial = new System.Windows.Forms.MenuItem();
            this.mnuiScan = new System.Windows.Forms.MenuItem();
            this.mnuiType = new System.Windows.Forms.MenuItem();
            this.mnuiClearSerial = new System.Windows.Forms.MenuItem();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel5.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panel8.SuspendLayout();
            this.panelImageHoldSearch.SuspendLayout();
            this.panel6.SuspendLayout();
            this.panel2.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.panel4.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Location = new System.Drawing.Point(0, 25);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(242, 239);
            this.tabControl1.TabIndex = 0;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.panel3);
            this.tabPage1.Controls.Add(this.panel5);
            this.tabPage1.Controls.Add(this.panel6);
            this.tabPage1.Controls.Add(this.panel7);
            this.tabPage1.Location = new System.Drawing.Point(4, 25);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Size = new System.Drawing.Size(234, 210);
            this.tabPage1.Text = "Select";
            // 
            // panel3
            // 
            this.panel3.BackColor = System.Drawing.Color.Ivory;
            this.panel3.Controls.Add(this.lblCurrentPO);
            this.panel3.Location = new System.Drawing.Point(2, 148);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(227, 58);
            // 
            // lblCurrentPO
            // 
            this.lblCurrentPO.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F, System.Drawing.FontStyle.Bold);
            this.lblCurrentPO.ForeColor = System.Drawing.Color.DarkRed;
            this.lblCurrentPO.Location = new System.Drawing.Point(2, 4);
            this.lblCurrentPO.Name = "lblCurrentPO";
            this.lblCurrentPO.Size = new System.Drawing.Size(225, 53);
            this.lblCurrentPO.Text = "No Purchase Order selected";
            // 
            // panel5
            // 
            this.panel5.BackColor = System.Drawing.Color.Black;
            this.panel5.Controls.Add(this.panel1);
            this.panel5.Location = new System.Drawing.Point(3, 3);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(229, 43);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.WhiteSmoke;
            this.panel1.Controls.Add(this.panel8);
            this.panel1.Controls.Add(this.lblPO);
            this.panel1.Controls.Add(this.txtPO);
            this.panel1.Controls.Add(this.cmdGetPO);
            this.panel1.Location = new System.Drawing.Point(1, 2);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(226, 40);
            // 
            // panel8
            // 
            this.panel8.BackColor = System.Drawing.Color.Black;
            this.panel8.Controls.Add(this.panelImageHoldSearch);
            this.panel8.Location = new System.Drawing.Point(200, 6);
            this.panel8.Name = "panel8";
            this.panel8.Size = new System.Drawing.Size(24, 24);
            // 
            // panelImageHoldSearch
            // 
            this.panelImageHoldSearch.BackColor = System.Drawing.Color.White;
            this.panelImageHoldSearch.Controls.Add(this.imgSearch);
            this.panelImageHoldSearch.Location = new System.Drawing.Point(1, 1);
            this.panelImageHoldSearch.Name = "panelImageHoldSearch";
            this.panelImageHoldSearch.Size = new System.Drawing.Size(22, 22);
            // 
            // imgSearch
            // 
            this.imgSearch.Image = ((System.Drawing.Image)(resources.GetObject("imgSearch.Image")));
            this.imgSearch.Location = new System.Drawing.Point(3, 3);
            this.imgSearch.Name = "imgSearch";
            this.imgSearch.Size = new System.Drawing.Size(15, 22);
            this.imgSearch.Click += new System.EventHandler(this.imgSearch_Click);
            // 
            // lblPO
            // 
            this.lblPO.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular);
            this.lblPO.ForeColor = System.Drawing.Color.Black;
            this.lblPO.Location = new System.Drawing.Point(2, 12);
            this.lblPO.Name = "lblPO";
            this.lblPO.Size = new System.Drawing.Size(70, 24);
            this.lblPO.Text = "PO Number";
            // 
            // txtPO
            // 
            this.txtPO.Location = new System.Drawing.Point(72, 8);
            this.txtPO.MaxLength = 10;
            this.txtPO.Name = "txtPO";
            this.txtPO.Size = new System.Drawing.Size(80, 23);
            this.txtPO.TabIndex = 2;
            this.txtPO.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPO_KeyPress);
            this.txtPO.TextChanged += new System.EventHandler(this.txtPO_TextChanged);
            // 
            // cmdGetPO
            // 
            this.cmdGetPO.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.75F, System.Drawing.FontStyle.Regular);
            this.cmdGetPO.Location = new System.Drawing.Point(155, 8);
            this.cmdGetPO.Name = "cmdGetPO";
            this.cmdGetPO.Size = new System.Drawing.Size(40, 20);
            this.cmdGetPO.TabIndex = 3;
            this.cmdGetPO.Text = "OK";
            this.cmdGetPO.Click += new System.EventHandler(this.cmdGetPO_Click);
            // 
            // panel6
            // 
            this.panel6.BackColor = System.Drawing.Color.Black;
            this.panel6.Controls.Add(this.panel2);
            this.panel6.Location = new System.Drawing.Point(2, 52);
            this.panel6.Name = "panel6";
            this.panel6.Size = new System.Drawing.Size(229, 91);
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.AliceBlue;
            this.panel2.Controls.Add(this.txtRequisitioner);
            this.panel2.Controls.Add(this.txtDelDate);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.txtSupplier);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Location = new System.Drawing.Point(1, 2);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(226, 88);
            // 
            // txtRequisitioner
            // 
            this.txtRequisitioner.Enabled = false;
            this.txtRequisitioner.Location = new System.Drawing.Point(72, 54);
            this.txtRequisitioner.Name = "txtRequisitioner";
            this.txtRequisitioner.Size = new System.Drawing.Size(151, 23);
            this.txtRequisitioner.TabIndex = 0;
            // 
            // txtDelDate
            // 
            this.txtDelDate.Enabled = false;
            this.txtDelDate.Location = new System.Drawing.Point(72, 30);
            this.txtDelDate.Name = "txtDelDate";
            this.txtDelDate.Size = new System.Drawing.Size(151, 23);
            this.txtDelDate.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular);
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(1, 56);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(80, 16);
            this.label3.Text = "Requisitioner";
            // 
            // txtSupplier
            // 
            this.txtSupplier.Enabled = false;
            this.txtSupplier.Location = new System.Drawing.Point(72, 6);
            this.txtSupplier.Name = "txtSupplier";
            this.txtSupplier.Size = new System.Drawing.Size(151, 23);
            this.txtSupplier.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular);
            this.label2.ForeColor = System.Drawing.Color.Black;
            this.label2.Location = new System.Drawing.Point(1, 32);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 16);
            this.label2.Text = "Delivery Date";
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular);
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(3, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 16);
            this.label1.Text = "Supplier";
            // 
            // panel7
            // 
            this.panel7.BackColor = System.Drawing.Color.Black;
            this.panel7.Location = new System.Drawing.Point(1, 146);
            this.panel7.Name = "panel7";
            this.panel7.Size = new System.Drawing.Size(230, 62);
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.comboSloc);
            this.tabPage2.Controls.Add(this.txtEdit);
            this.tabPage2.Controls.Add(this.gridPOItems);
            this.tabPage2.Controls.Add(this.panel4);
            this.tabPage2.Location = new System.Drawing.Point(4, 25);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Size = new System.Drawing.Size(234, 210);
            this.tabPage2.Text = "PO Items";
            // 
            // comboSloc
            // 
            this.comboSloc.Location = new System.Drawing.Point(24, 165);
            this.comboSloc.Name = "comboSloc";
            this.comboSloc.Size = new System.Drawing.Size(100, 23);
            this.comboSloc.TabIndex = 0;
            this.comboSloc.Visible = false;
            this.comboSloc.LostFocus += new System.EventHandler(this.comboSloc_LostFocus);
            // 
            // txtEdit
            // 
            this.txtEdit.Location = new System.Drawing.Point(160, 165);
            this.txtEdit.Name = "txtEdit";
            this.txtEdit.Size = new System.Drawing.Size(64, 23);
            this.txtEdit.TabIndex = 1;
            this.txtEdit.Visible = false;
            this.txtEdit.LostFocus += new System.EventHandler(this.txtEdit_LostFocus);
            this.txtEdit.TextChanged += new System.EventHandler(this.txtEdit_TextChanged);
            // 
            // gridPOItems
            // 
            this.gridPOItems.BackColor = System.Drawing.Color.White;
            this.gridPOItems.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            this.gridPOItems.Location = new System.Drawing.Point(0, 79);
            this.gridPOItems.Name = "gridPOItems";
            this.gridPOItems.SelectionForeColor = System.Drawing.Color.White;
            this.gridPOItems.Size = new System.Drawing.Size(231, 119);
            this.gridPOItems.TabIndex = 2;
            this.gridPOItems.CurrentCellChanged += new System.EventHandler(this.gridPOItems_CurrentCellChanged);
            this.gridPOItems.Click += new System.EventHandler(this.gridPOItems_Click);
            // 
            // panel4
            // 
            this.panel4.BackColor = System.Drawing.Color.White;
            this.panel4.Controls.Add(this.cmdGR);
            this.panel4.Controls.Add(this.label5);
            this.panel4.Controls.Add(this.label4);
            this.panel4.Controls.Add(this.txtScanDoc);
            this.panel4.Controls.Add(this.txtDelNote);
            this.panel4.Controls.Add(this.panel9);
            this.panel4.Controls.Add(this.panel10);
            this.panel4.Location = new System.Drawing.Point(0, 0);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(240, 76);
            // 
            // cmdGR
            // 
            this.cmdGR.Location = new System.Drawing.Point(9, 54);
            this.cmdGR.Name = "cmdGR";
            this.cmdGR.Size = new System.Drawing.Size(223, 20);
            this.cmdGR.TabIndex = 0;
            this.cmdGR.Text = "Confirm Goods Receipt";
            this.cmdGR.Click += new System.EventHandler(this.cmdGR_Click);
            // 
            // label5
            // 
            this.label5.Location = new System.Drawing.Point(16, 26);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(72, 15);
            this.label5.Text = "Scan Doc";
            // 
            // label4
            // 
            this.label4.Location = new System.Drawing.Point(16, 8);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(72, 16);
            this.label4.Text = "Del. Note";
            // 
            // txtScanDoc
            // 
            this.txtScanDoc.Location = new System.Drawing.Point(96, 26);
            this.txtScanDoc.Name = "txtScanDoc";
            this.txtScanDoc.Size = new System.Drawing.Size(112, 23);
            this.txtScanDoc.TabIndex = 3;
            this.txtScanDoc.TextChanged += new System.EventHandler(this.txtScanDoc_TextChanged);
            // 
            // txtDelNote
            // 
            this.txtDelNote.Location = new System.Drawing.Point(96, 4);
            this.txtDelNote.Name = "txtDelNote";
            this.txtDelNote.Size = new System.Drawing.Size(112, 23);
            this.txtDelNote.TabIndex = 4;
            this.txtDelNote.TextChanged += new System.EventHandler(this.txtDelNote_TextChanged);
            // 
            // panel9
            // 
            this.panel9.Location = new System.Drawing.Point(10, 2);
            this.panel9.Name = "panel9";
            this.panel9.Size = new System.Drawing.Size(220, 47);
            // 
            // panel10
            // 
            this.panel10.BackColor = System.Drawing.Color.Black;
            this.panel10.Location = new System.Drawing.Point(9, 1);
            this.panel10.Name = "panel10";
            this.panel10.Size = new System.Drawing.Size(223, 50);
            // 
            // mainMenu1
            // 
            this.mainMenu1.MenuItems.Add(this.mnuiPO);
            this.mainMenu1.MenuItems.Add(this.mnuiQty);
            this.mainMenu1.MenuItems.Add(this.mnuiSerial);
            // 
            // mnuiPO
            // 
            this.mnuiPO.MenuItems.Add(this.mnuiLogoff);
            this.mnuiPO.MenuItems.Add(this.mnuiLogon);
            this.mnuiPO.MenuItems.Add(this.mnuiClear);
            this.mnuiPO.MenuItems.Add(this.mnuiSearch);
            this.mnuiPO.MenuItems.Add(this.mnuiExit);
            this.mnuiPO.Text = "Functions";
            // 
            // mnuiLogoff
            // 
            this.mnuiLogoff.Text = "Logoff SAP";
            this.mnuiLogoff.Click += new System.EventHandler(this.mnuiLogoff_Click);
            // 
            // mnuiLogon
            // 
            this.mnuiLogon.Text = "Logon To SAP";
            this.mnuiLogon.Click += new System.EventHandler(this.mnuiLogon_Click);
            // 
            // mnuiClear
            // 
            this.mnuiClear.Text = "Clear Current PO";
            this.mnuiClear.Click += new System.EventHandler(this.mnuiClear_Click);
            // 
            // mnuiSearch
            // 
            this.mnuiSearch.Text = "Search";
            this.mnuiSearch.Click += new System.EventHandler(this.mnuiSearch_Click);
            // 
            // mnuiExit
            // 
            this.mnuiExit.Text = "Exit";
            this.mnuiExit.Click += new System.EventHandler(this.mnuiExit_Click);
            // 
            // mnuiQty
            // 
            this.mnuiQty.Enabled = false;
            this.mnuiQty.MenuItems.Add(this.mnuiResetDefault);
            this.mnuiQty.MenuItems.Add(this.mnuiAllTo0);
            this.mnuiQty.Text = "Quantities";
            // 
            // mnuiResetDefault
            // 
            this.mnuiResetDefault.Text = "Reset Default";
            this.mnuiResetDefault.Click += new System.EventHandler(this.mnuiResetDefault_Click);
            // 
            // mnuiAllTo0
            // 
            this.mnuiAllTo0.Text = "Set all to 0";
            this.mnuiAllTo0.Click += new System.EventHandler(this.mnuiAllTo0_Click);
            // 
            // mnuiSerial
            // 
            this.mnuiSerial.Enabled = false;
            this.mnuiSerial.MenuItems.Add(this.mnuiScan);
            this.mnuiSerial.MenuItems.Add(this.mnuiType);
            this.mnuiSerial.MenuItems.Add(this.mnuiClearSerial);
            this.mnuiSerial.Text = "Serial Nos.";
            // 
            // mnuiScan
            // 
            this.mnuiScan.Enabled = false;
            this.mnuiScan.Text = "Scan Mode";
            this.mnuiScan.Click += new System.EventHandler(this.mnuiScan_Click);
            // 
            // mnuiType
            // 
            this.mnuiType.Text = "Type Mode";
            this.mnuiType.Click += new System.EventHandler(this.mnuiType_Click);
            // 
            // mnuiClearSerial
            // 
            this.mnuiClearSerial.Text = "Clear All";
            this.mnuiClearSerial.Click += new System.EventHandler(this.mnuiClearSerial_Click);
            // 
            // frmPOGR
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ClientSize = new System.Drawing.Size(242, 265);
            this.Controls.Add(this.tabControl1);
            this.Menu = this.mainMenu1;
            this.Name = "frmPOGR";
            this.Text = "PO Goods Receipt";
            this.Closing += new System.ComponentModel.CancelEventHandler(this.frmPOGR_Closing);
            this.Load += new System.EventHandler(this.frmPOGR_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.panel3.ResumeLayout(false);
            this.panel5.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel8.ResumeLayout(false);
            this.panelImageHoldSearch.ResumeLayout(false);
            this.panel6.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.tabPage2.ResumeLayout(false);
            this.panel4.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

    }
}