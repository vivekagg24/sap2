using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace ce5b
{
    public partial class frmShowLog : Form
    {
        public frmShowLog()
        {
            InitializeComponent();

// display logfile in textbox
            StreamReader reader = new StreamReader("logfile.txt");
            string data = reader.ReadToEnd();
            reader.Close();

            txtShowLog.Text = "";

            txtShowLog.Text = data;

        }

    }
}