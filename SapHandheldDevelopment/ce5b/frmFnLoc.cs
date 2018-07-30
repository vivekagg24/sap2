using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ce5b.SAPGateway;
using System.Xml;

namespace ce5b
{
    public partial class frmFnLoc : Form
    {
        public frmPMGM frmParent;
        public string sTopNode = "";
        public string sPlant = "";
        private POFunctions oGateway = new POFunctions();

        public frmFnLoc()
        {
            InitializeComponent();
            oGateway.Url = frmStart.SERVICE_URL;
        }
        #region Form events
        private void frmFnLoc_Load(object sender, System.EventArgs e)
        {
            this.txtTopLevel.Text = this.sTopNode;

            this.treeFnLoc.BeforeExpand += new
                System.Windows.Forms.TreeViewCancelEventHandler(
                this.treeFnLoc_BeforeExpand);
            this.txtTopLevel.Focus();
            this.oGateway.Timeout = frmStart.SOAP_TIMEOUT;

            if (this.sTopNode == "") GetDefault();
            this.txtTopLevel.Text = this.sTopNode;
        }

        private void cmdGetStructure_Click(object sender, System.EventArgs e)
        {
            TreeNode oNode = new TreeNode();
            if (this.txtTopLevel.Text.Trim() == "")
            {
                MessageBox.Show("Please enter a functional location", frmStart.MESSAGE_BOX_TITLE);
            }
            else
            {
                this.treeFnLoc.Nodes.Clear();
                if (BuildSubTree(this.txtTopLevel.Text.Trim(), ref oNode))
                {
                    this.treeFnLoc.Nodes.Add(oNode);
                }
                else MessageBox.Show("No functional location found", frmStart.MESSAGE_BOX_TITLE);
            }
        }

        private void treeFnLoc_BeforeExpand(object sender, System.Windows.Forms.TreeViewCancelEventArgs e)
        {
            TreeNode oNode;
            this.treeFnLoc.BeginUpdate();
            Cursor.Current = Cursors.WaitCursor;

            if (e.Node.Nodes[0].Text == "")
            {
                oNode = new TreeNode();
                BuildSubTree((string)e.Node.Tag, ref oNode);
                if (oNode.Nodes.Count > 0) e.Node.Nodes[0].Remove();
                foreach (TreeNode oChild in oNode.Nodes)
                {
                    e.Node.Nodes.Add(oChild);
                }
            }
            Cursor.Current = Cursors.Default;
            this.treeFnLoc.EndUpdate();
        }

        private void cmdSelect_Click(object sender, System.EventArgs e)
        {
            try
            {
                if (this.treeFnLoc.SelectedNode.Tag != null)
                {
                    for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
                    {
                        try
                        {
                            if (this.oGateway.CheckFunctionalLocation((string)this.treeFnLoc.SelectedNode.Tag))
                            {
                                this.sTopNode = (string)this.treeFnLoc.SelectedNode.Tag;
                            }
                            else return;
                            break;
                        }
                        catch (Exception ex)
                        {
                            if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                                frmStart.HandleException(ex, false);
                            else RefreshSAPGateway();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
        }

        private void txtTopLevel_TextChanged(object sender, System.EventArgs e)
        {
            bool bReplaced = false;
            this.txtTopLevel = frmStart.RemoveScanSuffix(this.txtTopLevel, out bReplaced);
        }
        #endregion
        #region SAP calls
        private bool BuildSubTree(string sFLoc, ref TreeNode oNode)
        {
            string sXML = "";
            sFLoc = sFLoc.ToUpper();
            TreeNode oChild;
            Cursor.Current = Cursors.WaitCursor;
            Cursor.Show();

            for (int j = 1; j <= frmStart.CONNECTION_RETRIES; j++)
            {
                try
                {
                    sXML = this.oGateway.GetFuncLocHierarchy(sFLoc, " ");
                    break;
                }
                catch (Exception ex)
                {
                    if (!frmStart.IsConnectionError(ex) || j == frmStart.CONNECTION_RETRIES)
                        frmStart.HandleException(ex, false);
                    else RefreshSAPGateway();
                }
            }

            XmlDocument oXML = new XmlDocument();
            oXML.LoadXml(sXML);
            Cursor.Current = Cursors.Default;

            try
            {
                if (oXML.FirstChild.Attributes.Count == 0) return false;
                if (oXML.FirstChild.Attributes.Item(0).InnerText.Trim() == sFLoc)
                {
                    oNode = new TreeNode(sFLoc + " " + oXML.FirstChild.FirstChild.InnerText);
                    oNode.Tag = sFLoc;
                    XmlNodeList oChildren = oXML.GetElementsByTagName("f");
                    foreach (XmlNode oXMLNode in oChildren)
                    {
                        oChild = new TreeNode(oXMLNode.Attributes["n"].InnerText + " " + oXMLNode.InnerText);
                        oChild.Tag = oXMLNode.Attributes["n"].InnerText;
                        if (oXMLNode.Attributes["ch"].InnerText == "X") oChild.Nodes.Add("");
                        oNode.Nodes.Add(oChild);
                    }
                    return true;
                }
                else return false;
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
                return false;
            }
        }

        private void RefreshSAPGateway()
        {
            this.oGateway = null;
            this.oGateway = new POFunctions();
            this.oGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oGateway.Url = frmStart.SERVICE_URL;
        }
        private void GetDefault()
        {
            string sXML = "<plants></plants>";

            try
            {
                sXML = this.oGateway.GetDefaultFunctionalLocations();
                XmlDocument oXML = new XmlDocument();
                oXML.LoadXml(sXML);
                XmlNodeList oList = oXML.GetElementsByTagName("p");
                foreach (XmlNode oNode in oList)
                {
                    if (oNode.Attributes.GetNamedItem("n").InnerText == sPlant)
                    {
                        this.sTopNode = oNode.Attributes.GetNamedItem("f").InnerText;
                        if (this.sTopNode.EndsWith("-")) this.sTopNode = this.sTopNode.Remove(this.sTopNode.LastIndexOf("-"), 1);
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, true);
            }
        }
        #endregion

    }
}