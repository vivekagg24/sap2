using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Reflection;
using System.IO;
using ce5b.SAPGateway;


namespace ce5b
{
    public partial class frmStockCountStart : Form
    {
        private frmBlindCount frmBlind; 
        public frmStockMenu frmParent;
        //private frmCountByDocument frmCountByDocument;
        private DateTime dtLastDidSomethingAt = new DateTime(DateTime.UtcNow.Ticks);
 	    private SAPGateway.POFunctions oSAPGateway = new POFunctions();

//holds plant and storage locations including texts
        public Array Plant = Array.CreateInstance(typeof(string),20,2);
        public Array Store = Array.CreateInstance(typeof(string),20,2);
        
        public frmStockCountStart(frmStockMenu pfrmParent)
        {
    
            #region Start Logger
            logger mylog = new logger();

            mylog.makelog("Starting Stock Count");
            #endregion

            InitializeComponent();
            this.button1.BackColor = System.Drawing.Color.LightGreen;
            this.textBox1.BackColor = System.Drawing.Color.Beige;
            this.textBox2.BackColor = System.Drawing.Color.Beige;
            this.frmParent = pfrmParent;
            this.RefreshSAPGateway();
            this.comboBox1.Focus();
                      
        }

        #region Form events
        private void frmStockCountStart_Load(object sender, System.EventArgs e)
        {
            string sError = "";
          

            //Status - logged on status
            this.lblStatusBar.Text = this.frmParent.lblStatusBar.Text;

            Cursor.Current = Cursors.Default;
            Cursor.Show();

            //Username/ Password are required
            if (this.frmParent.frmParent.SAPPword == "" || this.frmParent.frmParent.SAPUname == "")
            {
                if (!this.frmParent.frmParent.GetSAPConnection(ref sError)) MessageBox.Show(sError, frmStart.MESSAGE_BOX_TITLE);
            }
            this.lblStatusBar.Text = this.frmParent.lblStatusBar.Text;
            if (this.frmParent.frmParent.SAPUname != "" & this.frmParent.frmParent.SAPPword != "")
            {
//                this.mnuiLogoff.Enabled = true;
//                this.mnuiLogon.Enabled = false;
            }
            else
            {
//                this.mnuiLogoff.Enabled = false;
//                this.mnuiLogon.Enabled = true;
            }
            string sXML = "";
            string sPlant = "";             
            int count = 0;
            int max = 1;
            int i = 0;
            int j = 0;
            int k = 0;
            int l = 0;

            Plant.Initialize();
            Store.Initialize();

            sXML = this.oSAPGateway.GetPlantLocation(sPlant);

            XmlDocument oXML = new XmlDocument();
            XmlNodeList oList;
            oXML.LoadXml(sXML);
         //Plants are <p> nodes in the XML
            oList = oXML.GetElementsByTagName("p");
            foreach (XmlNode oItem in oList)
            {
                count = 0;
                while (count < max)
                {
                    try
                    {
                        if (oItem.Attributes.GetNamedItem("N").Name == "N")
                        {
                            if (oItem.Attributes.GetNamedItem("N").Value != "")
                            {
                                this.comboBox1.Items.Add(oItem.Attributes.GetNamedItem("N").Value);
                                // now add to the plant array for later use
                                if (oItem.Attributes.GetNamedItem("NT").Value != "")
                                {
                                    Plant.SetValue(oItem.Attributes.GetNamedItem("N").Value, i, j);
                                    j = 1;
                                    Plant.SetValue(oItem.Attributes.GetNamedItem("NT").Value, i, j);
                                    i++;
                                    j = 0;
                                }
                            }
                        }
                    }
                    catch
                    {
                    }

                    try
                    {
                        if (oItem.Attributes.GetNamedItem("L").Name == "L")
                        {
                            if (oItem.Attributes.GetNamedItem("L").Value != "")
                            {
                                this.comboBox2.Items.Add(oItem.Attributes.GetNamedItem("L").Value);
                                //save storage location values for later
                                if (oItem.Attributes.GetNamedItem("LT").Value != "")
                                {
                                    Store.SetValue(oItem.Attributes.GetNamedItem("L").Value, k, l);
                                    l = 1;
                                    Store.SetValue(oItem.Attributes.GetNamedItem("LT").Value, k, l);
                                    k++;
                                    l = 0;
                                }
                            }
                        }
                    }
                    catch
                    {
                    }

                    count++;
                }
            }
                        

        }
        private void cmdCountByDocument_Click(object sender, EventArgs e)
        {
  //          frmCountByDocument=new frmCountByDocument(this);
  //          this.frmCountByDocument.ShowDialog();
        }
        public void UpdateLastDidSomethingAt()
        {
            this.dtLastDidSomethingAt = new DateTime(DateTime.UtcNow.Ticks);
        }

        private void RefreshSAPGateway()
          {
              this.oSAPGateway = null;
              this.oSAPGateway = new POFunctions();
              this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
              this.oSAPGateway.Url = frmStart.SERVICE_URL;
          }

        #endregion

        #region Menu Events
        private void mnuiLogoff_Click(object sender, EventArgs e)
        {
            this.UpdateLastDidSomethingAt();
            this.frmParent.frmParent.LogoffSAP();
//            this.mnuiLogon.Enabled = true;
//            this.mnuiLogoff.Enabled = false;
        }

//        private void mnuiLogon_Click(object sender, EventArgs e)
//        {
//        //    this.frmParent.UpdateLastDidSomethingAt();
//            string sLoginError = "";
//            if (!this.frmParent.frmParent.GetSAPConnection(ref sLoginError))
//            {
//                MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
//                this.mnuiLogoff.Enabled = false;
//            }
//            else
//            {
//                this.mnuiLogoff.Enabled = true;
//                this.mnuiLogon.Enabled = false;
//                //this.DefaultRecipient();
//            }

//        }

        private void mnuiExit_Click(object sender, EventArgs e)
        {
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
        }
        private void mnuiViewLog_Click(object sender, EventArgs e)
        {

            /// Display a form with a multiline textbox as dialog to show contents of log file
            /// 
            frmShowLog ShowLog = new frmShowLog();

            ShowLog.ShowDialog();

        }

//        private void mnuiDebugOn_Click(object sender, EventArgs e)
//        {
//            logger mylog = new logger();
//            mylog.makelog("Debug Toggle");

//            if (this.mnuiDebugOn.Text == "Debug On")
//            {
//                if (frmStart.debug == false)
//                {
//                    frmStart.debug = true;
//                    this.mnuiDebugOn.Text = "Debug Off";
//                    mylog.makelog("Debug On");
//                }
//            }
//            else
//            {
//                //debug off

//                if (frmStart.debug == true)
//                {
//                    frmStart.debug = false;
//                    this.mnuiDebugOn.Text = "Debug On";
//                    mylog.makelog("Debug Off");
//                }
//            }

//        }

        #endregion

       #region Help Links
        private void frmStockCountStart_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("stockcount");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("stockcount");
        }
        #endregion

        private void cmdLocation_Click(object sender, EventArgs e)
        {

        }

        private void cmdPriority_Click(object sender, EventArgs e)
        {

        }

        private void cmdRandom_Click(object sender, EventArgs e)
        {

        }

        private void pnlMainFront_GotFocus(object sender, EventArgs e)
        {

        }

        private void lblCountBy_ParentChanged(object sender, EventArgs e)
        {

        }

 
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i1 = 0;
            int i2 = 1;
            string mystring = "";
            object obj1 = "";
            obj1 = comboBox1.Text;
      
// read the array for the combobox value and then return the next array index which contains the text
            for (int i = 0; i <= 20; i++)
            {
                mystring = Plant.GetValue(i, i1).ToString();

                if (mystring == obj1.ToString())
                {
                    textBox1.Text = Plant.GetValue(i, i2).ToString();
                    break;
                }      
            }
            this.UpdateLastDidSomethingAt();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i1 = 0;
            int i2 = 1;
            string mystring = "";
            object obj1 = "";
            obj1 = comboBox2.Text;

 // read the array for the combobox value and then return the next array index which contains the text
            for (int i = 0; i <= 20; i++)
            {
                mystring = Store.GetValue(i, i1).ToString();
                    
                if (mystring == obj1.ToString())
                {
                    textBox2.Text = Store.GetValue(i, i2).ToString();
                    break;
                }
            }
            this.UpdateLastDidSomethingAt();
        }

        private void mnuiFunctions_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if ( comboBox1.Text == "" || comboBox2.Text == "")
            {
                MessageBox.Show("You must enter a Plant & Storage Location");
                return;
            }
            this.UpdateLastDidSomethingAt();
            this.frmBlind = new frmBlindCount(this, this.comboBox1.Text, this.textBox1.Text, this.comboBox2.Text, this.textBox2.Text, "");
            this.frmBlind.ShowDialog();
        }

        private void close_Click(object sender, EventArgs e)
        {

        }

        private void close_window_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        

    }
}