using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ce5b.SAPGateway;
using System.Xml;
using System.IO;

namespace ce5b
{
    public partial class frmCountByDocument : Form
    {
 //       public frmCountByDocument frmParent;
        public frmStockMenu frmParent;        
        public frmStart frmGrandParent;
        private POFunctions oSAPGateway;
        private frmStockCountMain frmCount;        
        private frmShowLog frmShowLog;

        frmStart frmStart = new frmStart();

  //      public frmCountByDocument(frmStockCountStart pfrmParent)
         public frmCountByDocument(frmStockMenu pfrmParent)
  
        {
            #region Start Logger
            logger mylog = new logger();

            //kill log
            if (File.Exists("logfile.txt"))
            {
                File.Delete("logfile.txt");
            }

            mylog.makelog("Starting CountByDocument");
            #endregion

            InitializeComponent();

            this.frmParent = pfrmParent;
            this.RefreshSAPGateway();

            this.lblStatusBar.Text = this.frmParent.frmParent.lblStatusBar.Text;
            this.lblStatusBar.Update();
            }

        private void cmdGetDocument_Click(object sender, EventArgs e)
        {
            this.GetCountFromSAP();
        }

        #region Communication with SAP
        private void GetCountFromSAP()
        {
            string sFYear = "";
            bool bOK = false;
            string sXML = "";
            string sPlantName = "";
            string sPlant = "";

            try
            {
     //           this.frmParent.UpdateLastDidSomethingAt();

                if (this.txtCountDocument.Text.Trim() == "")
                {
                    MessageBox.Show("Please enter a SAP count document number", frmStart.MESSAGE_BOX_TITLE);
                    this.txtCountDocument.Focus();
                }
                else
                {
                    if (frmStart.debug !=false) MessageBox.Show("Going to sap", "DEBUG");
                    
                    if (!this.GetSAPConnection()) return;

                    if (frmStart.debug != false) MessageBox.Show("Back from sap", "DEBUG");

                    Cursor.Current = Cursors.WaitCursor;
                    Cursor.Show();
                    for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                    {
                        try
                        {
                            if (frmStart.debug != false) MessageBox.Show("In Loop", "DEBUG");

                            sXML = this.oSAPGateway.StckGetCount(this.txtCountDocument.Text.Trim(), this.frmParent.frmParent.SAPUname,
                                this.frmParent.frmParent.SAPPword, out sFYear, out bOK, out sPlantName, out sPlant);
                            if (bOK)
                            {
                                // Check if all the items have already been counted.
                                XmlDocument oXML = new XmlDocument();
                                XmlNodeList oList;
                                oXML.LoadXml(sXML);
                                //Items are <i> nodes in the XML
                                oList = oXML.GetElementsByTagName("i");
                                char cCounted = 'Y';
                                foreach (XmlNode oItem in oList)
                                {
                                    if (oItem.Attributes.GetNamedItem("cntd").InnerText == "")
                                    {
                                        cCounted = 'N';
                                        break;
                                    }
                                }

                                if (cCounted == 'Y')
                                {
                                    MessageBox.Show("This document has already been counted");

                                    this.lblStatusBar.Text = "Already Counted";
                                    this.lblStatusBar.Update();

                                    this.txtCountDocument.Focus();
                                }
                                else
                                {
                                    Cursor.Current = Cursors.Default;
                                    this.frmCount = new frmStockCountMain(this.txtCountDocument.Text, sXML, sPlantName, sPlant,this);
                                    this.frmCount.ShowDialog();
                                }
                            }
                            else
                            {
                                MessageBox.Show("The count document was not found on SAP");

                                this.lblStatusBar.Text = "Documentnot Found";
                                this.lblStatusBar.Update();

                                this.txtCountDocument.Focus();
                            }
                            break;
                        }
                        catch (Exception ex)
                        {
                            if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                                frmStart.HandleException(ex, false);
                        }
                    }
                    Cursor.Current = Cursors.Default;
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            finally
            {
                
                Cursor.Current = Cursors.Default;
                Cursor.Show();
            }
        }
        private bool GetSAPConnection()
        {
            string sLoginError = "";

            if (this.frmParent.frmParent.SAPUname == "" || this.frmParent.frmParent.SAPPword == "")
            {
                if (frmStart.debug!=false) MessageBox.Show("not logged in", "DEBUG");

                if (!this.frmParent.frmParent.GetSAPConnection(ref sLoginError))
                {
                    MessageBox.Show(sLoginError, frmStart.MESSAGE_BOX_TITLE);
                    return false;
                }
                else
                {
                    if (frmStart.debug != false) MessageBox.Show("OK", "DEBUG");
                }

            }
            else
            {
                if (frmStart.debug != false) MessageBox.Show("already logged in", "DEBUG");
            }

            return true;
        }
        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }
        #endregion
        #region General methods
        public void UpdateLastDidSomethingAt()
        {
      //      this.frmParent.UpdateLastDidSomethingAt();
        }

        #endregion
        #region Menu Events
        private void menuItem2_Click(object sender, EventArgs e)
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
            frmShowLog = new frmShowLog();

            frmShowLog.ShowDialog();
        }

        private void mnuiDebugOn_Click(object sender, EventArgs e)
        {
            logger mylog = new logger();
            mylog.makelog("Debug Toggle");

            if (this.mnuiDebugOn.Text == "Debug On")
            {
                if (frmStart.debug == false)
                {
                    frmStart.debug = true;
                    this.mnuiDebugOn.Text = "Debug Off";
                    mylog.makelog("Debug On");
                }
            }
            else
            {
                //debug off

                if (frmStart.debug == true)
                {
                    frmStart.debug = false;
                    this.mnuiDebugOn.Text = "Debug On";
                    mylog.makelog("Debug Off");
                }
            }

        }
        #endregion
        #region Help Links
        private void frmCountByDocument_HelpRequested(object sender, System.Windows.Forms.HelpEventArgs hlpevent)
        {
            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("countbydoc");
        }
        private void mnuiHelp_Click(object sender, EventArgs e)
        {

            ShowHelp myHelp = new ShowHelp();

            myHelp.MakeHelp("countbydoc");
        }
        #endregion

        private void txtCountDocument_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmCountByDocument_Load(object sender, EventArgs e)
        {

        }

        private void pnlInnerFront_GotFocus(object sender, EventArgs e)
        {

        }

    }
}