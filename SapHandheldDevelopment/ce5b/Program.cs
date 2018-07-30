using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;
using System.Net;

namespace ce5b
{
    static class Program
    {

        public static string PlatformType="";
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [MTAThread]
        static void Main()
        {
            Type t = typeof(ce5b.PlatformInfo);


            
            PlatformType = PlatformInfo.GetPlatformType();
 
           Application.Run(new frmStart());
        }
    }
}