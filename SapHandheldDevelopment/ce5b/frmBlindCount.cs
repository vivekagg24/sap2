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
    public partial class frmBlindCount : Form
    {
        int a1 = 0;
        int b1 = 1;
        int c1 = 2;
        int d1 = 3;
        int e1 = 4;
        int f1 = 5;
        int g1 = 6;
        int h1 = 7;
        int i1 = 8;
        int j1 = 9;
        public int stockcount = 0;
        int itemcount = 0;
        string Plantno = null;
        string Sloc = null;
        string[] separray = new string[0];
        private bool eventdisable = false;
        public frmStockCountStart frmParent;
        private SAPGateway.POFunctions oSAPGateway = new POFunctions();
        public Array countdoc = Array.CreateInstance(typeof (string),100,10);
        private Array oldmat = Array.CreateInstance(typeof (string),1,5);
        DialogResult result;

         
        public frmBlindCount(frmStockCountStart pfrmParent,string plantno, string plant,string sloc, string location, string display)
        {
            
            InitializeComponent();
            if (display == "X")
            {
                eventdisable = true;
                this.frmBlindCount_Display(plantno,plant,sloc,location);
             }
            else
            {
                try
                {
                    this.frmParent = pfrmParent;
                    this.RefreshSAPGateway();
                    this.Plant.Text = plant.ToString();
                    this.location.Text = location.ToString();
                    Plantno = plantno.ToString();
                    Sloc = sloc.ToString();
                    itemcount = 0;
                    stockcount = 0;
                    count.Text = null;
                    this.material.Focus();
                }
                catch
                {
                }
            }
        }

        private void frmBlindCount_Display(string plantno, string plant, string sloc, string location)
        {
            char[] seperator= {':'};
//hide the buttons and set the input fields to read only
            material.ReadOnly = true;
            qty.ReadOnly = true;
            count.Visible = false;
            label1.Visible = false;
            label4.Visible = false;
            button1.Visible = false;
            button2.Visible = false;
            this.MinimizeBox = false;
            this.MaximizeBox = false;
            

//the following code utilises the existing parameters to pass the line values for display
//these are then split out and added to the screen fields as follows


//plantno contains plant and location text   
            try
            {
                separray = plantno.Split(seperator[0]);
            }
            catch
            {
            }
            for (int i = 0; i < separray.Length; i++)
            {
               switch (i)
               {
                   case 0:
                      this.Plant.Text = separray[i];
                      break;
                   case 1:
                      this.location.Text = separray[i];
                      break;
               }
            }
            Array.Clear(separray, 0, separray.Length);

//plant contains material and UOM text
            try
            {
                separray = plant.Split(seperator[0]);
            }
            catch
            {
            }
            for (int i = 0; i < separray.Length; i++)
            {
                switch (i)
                {
                    case 0:
                        this.material.Text = separray[i];
                        break;
                    case 1:
                        this.UOM.Text = separray[i];
                        break;
                }
            }
            Array.Clear(separray, 0, separray.Length);

//sloc contains the material description
            try
            {
                separray = sloc.Split(seperator[0]);
//                material_desc.Text = sloc.ToString();
            }
            catch
            {
            }
            for (int i = 0; i < separray.Length; i++)
            {
                switch (i)
                {
                    case 0:
                        this.material_desc.Text = separray[i];
                        break;
                    case 1:
                        if (separray[i] == "X")
                        {
                            this.serialised.Checked = true;
                        }
                        else
                        {
                            this.serialised.Checked = false;
                        }
                        break;
                }
            }
            Array.Clear(separray, 0, separray.Length);


//location contains the qty and bin text
            try
            {
                separray = location.Split(seperator[0]);
            }
            catch
            {
            }
            for (int i = 0; i < separray.Length; i++)
            {
                switch (i)
                {
                    case 0:
                        this.qty.Text = separray[i];
                        break;
                    case 1:
                        this.Bin.Text = separray[i];
                        break;
                }
            }
            Array.Clear(separray, 0, separray.Length);
            
        }

        private void frmBlindCount_Load(object sender, EventArgs e)
        {

        }

        private void menuItem11_Click(object sender, EventArgs e)
        {

        }

        private void menuItem12_Click(object sender, EventArgs e)
        {

        }

 

        private void RefreshSAPGateway()
        {
            this.oSAPGateway = null;
            this.oSAPGateway = new POFunctions();
            this.oSAPGateway.Timeout = frmStart.SOAP_TIMEOUT;
            this.oSAPGateway.Url = frmStart.SERVICE_URL;
        }

        private void GetMaterialData(ref bool error, ref bool inv_error)
        {
            string sXML = "";
            //string oMessage;
            string material = this.material.Text;            
            int max = 1;
            //int oldmatcount = 0;
            bool ok = true;
           

            error = false;
            itemcount = 0;

            Array.Clear(oldmat, 0, 5);
            sXML = this.oSAPGateway.GetMaterialData(material,Plantno,Sloc,out ok);
            if (ok == false)
            {
                error = true;
                return;
            }
            XmlDocument oXML = new XmlDocument();
            XmlNodeList oLIST;
            oXML.LoadXml(sXML);
            oLIST = oXML.GetElementsByTagName("p");
            foreach (XmlNode oItem in oLIST)
            {
           
              while (itemcount < max)
              {
                  try
                  {
//Get the Unit of measure text
                      if (oItem.Attributes.GetNamedItem("UT").Name == "UT")
                      {
                          if (oItem.Attributes.GetNamedItem("UT").Value != "")
                          {
                              this.UOM.Text = oItem.Attributes.GetNamedItem("UT").Value;

                          }
                      }
                  }
                  catch
                  {
           
                  }

//get the material text
                  try
                  {
                      if (oItem.Attributes.GetNamedItem("MT").Name == "MT")
                      {
                          if (oItem.Attributes.GetNamedItem("MT").Value != "")
                          {
                              this.material_desc.Text = oItem.Attributes.GetNamedItem("MT").Value;

                          }
                      }
                  }
                  catch
                  {
                  }

                  try
                  {
//Get the old material number
                    if (oItem.Attributes.GetNamedItem("OMT").Name == "OMT")
                    {
                        if (oItem.Attributes.GetNamedItem("OMT").Value != "")
                        {
                            oldmat.SetValue(material,0,a1);
                            oldmat.SetValue(oItem.Attributes.GetNamedItem("OMT").Value,0,b1);
                            
                        }
                    }
  //                  oldmatcount++;
                  }                 

                  catch
                  { 
                  
                  }

                  try
                  {
//Get the bin location
                      if (oItem.Attributes.GetNamedItem("SLT").Name == "SLT")
                      {
                          if (oItem.Attributes.GetNamedItem("SLT").Value != "")
                          {
                              oldmat.SetValue(material, 0, a1);
                              oldmat.SetValue(oItem.Attributes.GetNamedItem("SLT").Value, 0, c1);
                             
                              this.Bin.Text = oItem.Attributes.GetNamedItem("SLT").Value;
                          }
                      }
   //                  oldmatcount++;
                  }

                  catch
                  {

                  }

//check if serialised
                  try
                  {
                      if (oItem.Attributes.GetNamedItem("SN").Name == "SN")
                      {
                          if (oItem.Attributes.GetNamedItem("SN").Value != "")
                          {
                              oldmat.SetValue(material, 0, a1);
                              oldmat.SetValue(oItem.Attributes.GetNamedItem("SN").Value, 0, d1);
                              
                              this.serialised.Checked = true;
                          }
                      }
 //                     oldmatcount++;
                  }

                  catch
                  {

                  }
//unrestricted stock value
                  try
                  {
                      if (oItem.Attributes.GetNamedItem("URS").Name == "URS")
                      {
                          if (oItem.Attributes.GetNamedItem("URS").Value != "")
                          {
                              oldmat.SetValue(material, 0, a1);
                              oldmat.SetValue(oItem.Attributes.GetNamedItem("URS").Value, 0, e1);
                              
                          }
                      }
  //                    oldmatcount++;
                  }
                  catch
                  {

                  }

// check if material already entered on a material document
                  try
                  {
                      if (oItem.Attributes.GetNamedItem("PIN").Name == "PIN")
                      {
                          if (oItem.Attributes.GetNamedItem("PIN").Value != "")
                          {
                              string message = "Material " + material + " is already included in count doc " + oItem.Attributes.GetNamedItem("PIN").Value;
                              MessageBox.Show(message);
                              Array.Clear(oldmat, 0, 5);
                              this.clear();
                              inv_error = true;
                              break;
                          }
                      }
                  }
                  catch
                  { 

                  }
//Check storage location
                  try
                  {
                      if (oItem.Attributes.GetNamedItem("SLOC").Name == "SLOC")
                      {
                          if (oItem.Attributes.GetNamedItem("SLOC").Value == "")
                          {
                              string message = "Material " + material + " is not valid at " + Plantno + " " + Sloc;
                              MessageBox.Show(message);
                              Array.Clear(oldmat, 0, 5);
                              this.clear();
                              inv_error = true;
                              break;
                          }
                      }
                  }
                  catch
                  {
                  }

                    
                     itemcount++;
              }
              itemcount = 0;
            }
        }

        private void exception()
        {
            throw new Exception("The method or operation is not implemented.");
        }

        private void material_enter(object sender, KeyEventArgs e)
        {
            bool error = false;
            bool inv_error = false;
            if (!eventdisable)
            {
                this.material = frmStart.RemoveScanSuffix(this.material);
                if (this.material.TextLength >= 6)
                {
                    //get material detail from sap
                    this.GetMaterialData(ref error, ref inv_error);
                    if (error == false)
                    {   
                        if (inv_error == false)
                        {
                            this.qty.Focus();
                        }
                        else
                        {
                            this.material.Focus();
                        }
                    }
                    else
                    {
                        result = MessageBox.Show("Invalid Material Number", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
                        if (result == DialogResult.OK)
                        {
                            this.material.Text = null;
                            this.material_desc.Text = null;
                            this.UOM.Text = null;
                            error = true;
                        }
                        this.material.Focus();
                    }
                }
            }

        }

        private void material_TextChanged(object sender, EventArgs e)
        {
            bool error = false;
            bool inv_error = false;
            if (!eventdisable)
            {
                this.material = frmStart.RemoveScanSuffix(this.material);
                if (this.material.TextLength >= 6)
                {
                    //get material detail from sap
                    this.GetMaterialData(ref error, ref inv_error);
                    if (error == false)
                    {
                        if (inv_error == false)
                        {
                            this.qty.Focus();
                        }
                        else
                        {
                            this.material.Focus();
                        }
                    }
                    else
                    {
                        result = MessageBox.Show("Invalid Material Number", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
                        if (result == DialogResult.OK)
                        {
                            this.material.Text = null;
                            this.material_desc.Text = null;
                            this.UOM.Text = null;
                            error = true;
                        }
                        this.material.Focus();
                    }
 
                }
            }
            try { this.frmParent.UpdateLastDidSomethingAt(); } catch { };
        }

        private void Front_panel_GotFocus(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
// add the screen input to the array for later use and increment the count
// Array is set as follows: Plant(0), Storage Location(1), Material Number(2),
//                         Description(3),Quantity(4), Unit of Measure(5)
            string quant = qty.ToString();
            string unit  = UOM.ToString();

            if (stockcount == 25)
            {
                MessageBox.Show("Max number of items reached, Please post this count");
                this.button1.Focus();
            }
            else
            {

                if (material.Text != "")
                {
                    countdoc.SetValue(Plantno, stockcount, a1);
                    countdoc.SetValue(Sloc, stockcount, b1);
                    countdoc.SetValue(material.Text, stockcount, c1);
                    countdoc.SetValue(material_desc.Text, stockcount, d1);
                    countdoc.SetValue(qty.Text, stockcount, e1);
                    countdoc.SetValue(UOM.Text, stockcount, f1);
                    //read the stored values for the old material number and storage bin and save in count array

                    //old material #             
                    countdoc.SetValue(oldmat.GetValue(0, b1), stockcount, g1);
                    //Bin
                    countdoc.SetValue(oldmat.GetValue(0, c1), stockcount, h1);
                    //Serial #
                    countdoc.SetValue(oldmat.GetValue(0, d1), stockcount, i1);
                    //Unrestricted stock
                    countdoc.SetValue(oldmat.GetValue(0, e1), stockcount, j1);

                    stockcount++;
                    this.count.Text = stockcount.ToString();
                    this.material.Text = null;
                    this.material_desc.Text = null;
                    this.UOM.Text = null;
                    this.qty.Text = null;
                    this.Bin.Text = null;
                    this.serialised.Checked = false;
                    this.material.Focus();
                }
            }
            try { this.frmParent.UpdateLastDidSomethingAt(); }
            catch { };
        }

        private void button1_Click(object sender, EventArgs e)
        {
// check if any counts have been entered if not do not go to post screen
            string rowcount = null;
            try { rowcount = countdoc.GetValue(0, 0).ToString(); } catch { }
            if (rowcount == null)
//            if ( countdoc.GetUpperBound(1) < 1)
            {
                MessageBox.Show("No items have been entered for posting !");
            }
            else
            {
                DialogResult result;
                result = MessageBox.Show("Are you sure that you want to post this count", "Confirm Post", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1);
                if (result == DialogResult.Yes)
                {
                    frmBlindStockPost StockPost = new frmBlindStockPost(this, Plantno, Sloc, this.Plant.Text, this.location.Text);
                    StockPost.ShowDialog();
                    this.Close();
                }
                else
                {

                }
           }
           try { this.frmParent.UpdateLastDidSomethingAt(); } catch { }
        }

        private void Bin_TextChanged(object sender, EventArgs e)
        {

        }

        private void serialised_CheckStateChanged(object sender, EventArgs e)
        {

        }

        private void Plant_TextChanged(object sender, EventArgs e)
        {

        }

        private void material_desc_TextChanged(object sender, EventArgs e)
        {

        }

        private void close_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Clear_button_Click(object sender, EventArgs e)
        {
            clear();
        }
        private void clear()
        {
            material.Text = null;
            UOM.Text = null;
            material_desc.Text = null;
            qty.Text = null;
            Bin.Text = null;
            serialised.Checked = false;
            this.frmParent.UpdateLastDidSomethingAt();
        }
      
    }
}