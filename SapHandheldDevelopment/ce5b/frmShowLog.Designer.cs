namespace ce5b
{
    partial class frmShowLog
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
            this.txtShowLog = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // txtShowLog
            // 
            this.txtShowLog.Location = new System.Drawing.Point(3, 31);
            this.txtShowLog.Multiline = true;
            this.txtShowLog.Name = "txtShowLog";
            this.txtShowLog.ReadOnly = true;
            this.txtShowLog.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtShowLog.Size = new System.Drawing.Size(236, 222);
            this.txtShowLog.TabIndex = 0;
            // 
            // frmShowLog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(242, 288);
            this.Controls.Add(this.txtShowLog);
            this.MaximizeBox = false;
            this.Menu = this.mainMenu1;
            this.MinimizeBox = false;
            this.Name = "frmShowLog";
            this.Text = "Show Log";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox txtShowLog;
    }
}