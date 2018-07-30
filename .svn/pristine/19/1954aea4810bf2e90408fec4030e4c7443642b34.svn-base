using System;
using System.Xml;
using System.Net;
using System.IO;
using System.Text;
using System.Windows.Forms;
using Microsoft.Win32;


namespace ce5b
{
    /// <summary>
    /// Summary description for Class1.
    /// </summary>
    public class HTTPSAPGateway
    {
       private static string BASE_URL = "";
        private static string VERSION_URL = "http://nisapwireless/CurrentVersion.xml";
        public int TIMEOUT = 10000;
        private static int RETRIES = 3;



        public HTTPSAPGateway()
        {
            //
            // TODO: Add constructor logic here
            //dummy line
            //

            switch (frmStart.RUNNING_SYSTEM)
            {
                case "DEV":
                    BASE_URL = "http://nisapwireless/FSGWirelessDev/XMLInterface.aspx";
                    break;
                case "TEST":
                    BASE_URL = "http://nisapwireless/FSGWirelessTest/XMLInterface.aspx";
                    break;
                case "COPY":
                    BASE_URL = "http://nisapwireless/FSGWirelessCopy/XMLInterface.aspx";
                    break;
                case "LIVE":
                    BASE_URL = "http://nisapwireless/FSGWireless/XMLInterface.aspx";
                    break;
                case "R31":
                    BASE_URL = "http://nisapwireless/FSGWirelessDev/XMLInterface.aspx";
                    break;



            }
        }

        public bool CheckLogin(string sUname, string sPassword, out string sMessage)
                    {

            //check the wifi status
           

int WIFISTATE = (int)Registry.GetValue("HKEY_LOCAL_MACHINE\\System\\State\\Hardware", "WiFi", -1);

logger mylog = new logger();

            sMessage = "WIFI:" + WIFISTATE;

                mylog.makelog(sMessage);
            
            string sPOST = BASE_URL + "?FUNCTION=LOGIN&UNAME=" + sUname + "&PWORD=" + sPassword;

            if (frmStart.debug != true)
            {
                mylog.makelog(sPOST);
            }
            
            string sXML = RunQuery(sPOST);


            XmlDocument xml = new XmlDocument();
            xml.LoadXml(sXML);
            XmlNodeList nodeResult = xml.GetElementsByTagName("result");
            bool bOK = false;
            sMessage = "";
            if (nodeResult.Count > 0)
            {
                if (nodeResult.Item(0).InnerText.Trim() == "OK")
                {
                    bOK = true;
                    sMessage = "";
                }
                else
                {
                    sMessage = "Check Account (Locked?)";
                }
            }
            return bOK;
        }

        public string WOGetDetail(string sUname, string sPassword,
            string sAufnr, string sBwart, ref string sPlant, ref string sText, ref string sUOMXml)
        {
            string sPOST = BASE_URL + "?FUNCTION=WO_DETAIL&UNAME=" + sUname + "&PWORD=" + sPassword
                + "&AUFNR=" + sAufnr + "&BWART=" + sBwart;
            string sWOXML = "";
            try
            {
                string sXML = RunQuery(sPOST);
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sXML);
                sWOXML = "<wo>" + xml.GetElementsByTagName("wo").Item(0).InnerXml + "</wo>";
                sText = xml.GetElementsByTagName("htext").Item(0).InnerText;
                sPlant = xml.GetElementsByTagName("plant").Item(0).InnerText;
                sUOMXml = "<units>" + xml.GetElementsByTagName("units").Item(0).InnerXml + "</units>";
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            return sWOXML;
        }

        public bool GoodsMovement(string sUname, string sPassword,
            string sAufnr, string sDate, string sHText, string sMtype,
            string sRecip, string sItems, string sNewEquip, ref string sMessXML, out string sSuccessXML)
        {
            string sPOST = BASE_URL + "?FUNCTION=GOODS_MOVEMENT&UNAME=" + sUname + "&PWORD=" + sPassword
                + "&AUFNR=" + sAufnr + "&MTYPE=" + sMtype
                + "&DATE=" + sDate + "&HTEXT=" + sHText
                + "&RECIP=" + sRecip + "&ITEMS=" + sItems
                + "&EQUIP=" + sNewEquip;
            sSuccessXML = "";

            bool bOK = false;
            sMessXML = "";
            try
            {
                string sXML = RunQuery(sPOST);
                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sXML);
                sMessXML = "<mess>" + xml.GetElementsByTagName("mess").Item(0).InnerXml + "</mess>";
                sSuccessXML = "<ok>" + xml.GetElementsByTagName("success").Item(0).InnerXml + "</ok>";
                string sOK = xml.GetElementsByTagName("result").Item(0).Attributes["ok"].InnerText;
                if (sOK.ToLower() == "true") bOK = true;
            }
            catch (Exception ex)
            {
                frmStart.HandleException(ex, false);
            }
            return bOK;
        }

        public string GetCurrentVersion()
        {
            
            frmStart myStart = new frmStart();

                    string result = "";
                    XmlDocument oXML = new XmlDocument();
                    string sVersion = "";

                    // Create the web request  
                    RETRIES = 6;

                    for (int i = 1; i <= RETRIES; i++)
                    {
                        if (sVersion != "")
                        {
                            return sVersion; 
                        }
                        
                        try
                        {

                            WebRequest request = WebRequest.Create(VERSION_URL);
                            WebResponse response = request.GetResponse();

                            using (response)
                            {
                                // Get the response stream   
                                StreamReader reader = new StreamReader(response.GetResponseStream());

                                // Read the whole contents and return as a string   
                                result = reader.ReadToEnd();

                                oXML.LoadXml(result);
                                XmlNodeList oList = oXML.GetElementsByTagName("version");
                                sVersion = oList.Item(0).InnerText;

                            }
                        }
                        catch (Exception ex)
                        {
                            logger mylog = new logger();
                            mylog.makelog("Exception:" + i.ToString());
                            if (i == 5) frmStart.HandleException(ex, false);
                            return sVersion;
                        }
                         
                    }


                    return sVersion;
                   
        }





        private string RunQuery(string sPOST)
        {
            logger mylog = new logger();

            mylog.makelog("RunQuery");

            string sXML = "<result></result>";
            WebRequest oReq;
            WebResponse oRes = null;
            Encoding encode;
            StreamReader sr;
            Stream ReceiveStream = null;
            

      //      sPOST = "http://10.194.9.22/FSGWireless/XMLInterface.aspx";

            byte[] requestBytes = Encoding.ASCII.GetBytes(sPOST);

            RETRIES = 6;

            try
            {
                for (int i = 1; i <= RETRIES; i++)
                {
                    try
                    {
                        mylog.makelog("RunQuery:" + i.ToString());


                            
                        oReq =  WebRequest.Create(sPOST);

                        //// If required by the server, set the credentials.
                        oReq.Credentials = CredentialCache.DefaultCredentials;

                        //// Check for aproxy server
                        //if (oReq.DefaultWebProxy.GetProxy(new System.Uri (sPOST)).ToString() ==sPOST)
                        //{
                        //    //is a proxy
                        //}
                        //else
                        //{
                        //    //is not a proxy
                        //}


                        //// If required by the server, set the credentials.
                        //request.Credentials = CredentialCache.DefaultCredentials;

                        //// Get the response.
                        //HttpWebResponse response = (HttpWebResponse)request.GetResponse();

                        //// Get the stream containing content returned by the server.
                        //Stream dataStream = response.GetResponseStream();

                        //// Open the stream using a StreamReader for easy access.
                        //StreamReader reader = new StreamReader(dataStream);

                        //// Read the content.
                        //string responseFromServer = reader.ReadToEnd();

                        //reader.Close();

                        oReq.Timeout = TIMEOUT;
                        oReq.ContentLength = requestBytes.Length;
                        oReq.ContentType = "appliication/x-www-form-urlencoded";
                        oReq.Method = "POST";
                        Stream requestStream = oReq.GetRequestStream();
                        requestStream.Write(requestBytes, 0, requestBytes.Length);
                        requestStream.Close();

                       // oReq.Proxy = null;

                        
                        
                        oRes = oReq.GetResponse();


                        break;

                        
                    }
                    catch (Exception ex)
                    {
                        //frmStart myStart = new frmStart();
                        mylog.makelog("Exception:" + i.ToString() + ":" + ex.Message );
                        //myStart.lblStatusBar.Text = ex.Message;
                       
                        if (i == 5) frmStart.HandleException(ex, false);
                    }
                }
                ReceiveStream = oRes.GetResponseStream();

                if (ReceiveStream != null)
                {
                    encode = System.Text.Encoding.GetEncoding("utf-8");
                    sr = new StreamReader(ReceiveStream, encode);
                    sXML = sr.ReadToEnd();

                    mylog.makelog(sXML);

                    ReceiveStream.Close();
                    oRes.Close();
                }
                ReceiveStream = null;
                encode = null;
                sr = null;
                oRes = null;
                oReq = null;

            }
            catch (Exception ex) { frmStart.HandleException(ex, false); }

            return sXML;
        }
    }
}
