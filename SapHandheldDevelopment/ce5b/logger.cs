using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace ce5b
{
    public class logger
    {

        public void makelog(string TextToLog)
        {
            Type t = typeof(ce5b.frmStart);
            string logfile;
       //     frmStart frmStart = new frmStart();

            logfile = "logfile.txt";

            // Create a writer and open the file:
            StreamWriter log;

            if (!File.Exists(logfile))
            {
                log = new StreamWriter(logfile);
            }
            else
            {
                log = File.AppendText(logfile);
            }

            // Write to the file:
            log.WriteLine(DateTime.Now);
            log.WriteLine(TextToLog);
            log.WriteLine();

            // Close the stream:
            log.Close();

            if (frmStart.debug == true)
            {
                MessageBox.Show(TextToLog, "Debug");
            }
        }
    }
}
