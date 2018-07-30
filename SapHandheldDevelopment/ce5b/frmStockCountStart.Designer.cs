namespace ce5b
{
    partial class frmStockCountStart
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.Panel pnlMainFront;
        private System.Windows.Forms.Panel pnlMainBack;
        private System.Windows.Forms.Label lblCountBy;
        public System.Windows.Forms.Label lblStatusBar;
        private System.Windows.Forms.Panel pnlStatusBarBack;
        private System.Windows.Forms.Panel pnlStatusBarFront;

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
            this.pnlMainBack = new System.Windows.Forms.Panel();
            this.pnlMainFront = new System.Windows.Forms.Panel();
            this.comboBox2 = new System.Windows.Forms.ComboBox();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.lblCountBy = new System.Windows.Forms.Label();
            this.lblStatusBar = new System.Windows.Forms.Label();
            this.pnlStatusBarBack = new System.Windows.Forms.Panel();
            this.pnlStatusBarFront = new System.Windows.Forms.Panel();
            this.close_window = new System.Windows.Forms.Button();
            this.pnlMainBack.SuspendLayout();
            this.pnlMainFront.SuspendLayout();
            this.pnlStatusBarBack.SuspendLayout();
            this.pnlStatusBarFront.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlMainBack
            // 
            this.pnlMainBack.BackColor = System.Drawing.Color.Black;
            this.pnlMainBack.Controls.Add(this.pnlMainFront);
            this.pnlMainBack.Location = new System.Drawing.Point(8, 32);
            this.pnlMainBack.Name = "pnlMainBack";
            this.pnlMainBack.Size = new System.Drawing.Size(226, 171);
            // 
            // pnlMainFront
            // 
            this.pnlMainFront.BackColor = System.Drawing.Color.AliceBlue;
            this.pnlMainFront.Controls.Add(this.comboBox2);
            this.pnlMainFront.Controls.Add(this.comboBox1);
            this.pnlMainFront.Controls.Add(this.textBox2);
            this.pnlMainFront.Controls.Add(this.textBox1);
            this.pnlMainFront.Controls.Add(this.button1);
            this.pnlMainFront.Controls.Add(this.lblCountBy);
            this.pnlMainFront.Location = new System.Drawing.Point(2, 1);
            this.pnlMainFront.Name = "pnlMainFront";
            this.pnlMainFront.Size = new System.Drawing.Size(222, 168);
            this.pnlMainFront.GotFocus += new System.EventHandler(this.pnlMainFront_GotFocus);
            // 
            // comboBox2
            // 
            this.comboBox2.BackColor = System.Drawing.Color.Beige;
            this.comboBox2.Location = new System.Drawing.Point(8, 88);
            this.comboBox2.Name = "comboBox2";
            this.comboBox2.Size = new System.Drawing.Size(60, 23);
            this.comboBox2.TabIndex = 10;
            this.comboBox2.SelectedIndexChanged += new System.EventHandler(this.comboBox2_SelectedIndexChanged);
            // 
            // comboBox1
            // 
            this.comboBox1.BackColor = System.Drawing.Color.Beige;
            this.comboBox1.Location = new System.Drawing.Point(8, 56);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(60, 23);
            this.comboBox1.TabIndex = 9;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // textBox2
            // 
            this.textBox2.BackColor = System.Drawing.Color.Beige;
            this.textBox2.Location = new System.Drawing.Point(75, 88);
            this.textBox2.Name = "textBox2";
            this.textBox2.ReadOnly = true;
            this.textBox2.Size = new System.Drawing.Size(140, 23);
            this.textBox2.TabIndex = 5;
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.Color.Beige;
            this.textBox1.Location = new System.Drawing.Point(75, 56);
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            this.textBox1.Size = new System.Drawing.Size(140, 23);
            this.textBox1.TabIndex = 4;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(72, 130);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(80, 24);
            this.button1.TabIndex = 3;
            this.button1.Text = "Continue";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // lblCountBy
            // 
            this.lblCountBy.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Bold);
            this.lblCountBy.Location = new System.Drawing.Point(24, 8);
            this.lblCountBy.Name = "lblCountBy";
            this.lblCountBy.Size = new System.Drawing.Size(182, 36);
            this.lblCountBy.Text = "Please select the Plant and Location";
            this.lblCountBy.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.lblCountBy.ParentChanged += new System.EventHandler(this.lblCountBy_ParentChanged);
            // 
            // lblStatusBar
            // 
            this.lblStatusBar.ForeColor = System.Drawing.Color.Black;
            this.lblStatusBar.Location = new System.Drawing.Point(0, 0);
            this.lblStatusBar.Name = "lblStatusBar";
            this.lblStatusBar.Size = new System.Drawing.Size(233, 20);
            this.lblStatusBar.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // pnlStatusBarBack
            // 
            this.pnlStatusBarBack.BackColor = System.Drawing.Color.Black;
            this.pnlStatusBarBack.Controls.Add(this.pnlStatusBarFront);
            this.pnlStatusBarBack.Location = new System.Drawing.Point(4, 210);
            this.pnlStatusBarBack.Name = "pnlStatusBarBack";
            this.pnlStatusBarBack.Size = new System.Drawing.Size(235, 22);
            // 
            // pnlStatusBarFront
            // 
            this.pnlStatusBarFront.Controls.Add(this.lblStatusBar);
            this.pnlStatusBarFront.Location = new System.Drawing.Point(1, 1);
            this.pnlStatusBarFront.Name = "pnlStatusBarFront";
            this.pnlStatusBarFront.Size = new System.Drawing.Size(233, 20);
            // 
            // close_window
            // 
            this.close_window.BackColor = System.Drawing.Color.LightGreen;
            this.close_window.Location = new System.Drawing.Point(100, 7);
            this.close_window.Name = "close_window";
            this.close_window.Size = new System.Drawing.Size(40, 20);
            this.close_window.TabIndex = 2;
            this.close_window.Text = "Close";
            this.close_window.Click += new System.EventHandler(this.close_window_Click);
            // 
            // frmStockCountStart
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.Controls.Add(this.close_window);
            this.Controls.Add(this.pnlStatusBarBack);
            this.Controls.Add(this.pnlMainBack);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmStockCountStart";
            this.Text = "Stock Count";
            this.Load += new System.EventHandler(this.frmStockCountStart_Load);
            this.pnlMainBack.ResumeLayout(false);
            this.pnlMainFront.ResumeLayout(false);
            this.pnlStatusBarBack.ResumeLayout(false);
            this.pnlStatusBarFront.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.ComboBox comboBox2;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Button close_window;

    }
}