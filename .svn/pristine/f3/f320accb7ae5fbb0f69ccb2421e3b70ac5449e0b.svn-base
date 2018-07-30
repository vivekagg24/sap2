using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace ce5b
{
    public class ShowHelp
    {
        string tag;

        public void MakeHelp(string helptoshow)
        {

            if (helptoshow == "")
            {
                tag = "#Main_Content";
            }
            else
            {
                tag = "#" + helptoshow;
            }

            try
            {
                PROCESS_INFORMATION processInfo = new PROCESS_INFORMATION();

                tag = "file:NIhandheld.htm" + tag;

                CreateProcess("peghelp.exe",
  //                    "file:NIhandheld.htm" + tag,
                      tag,
                      IntPtr.Zero,
                      IntPtr.Zero,
                      false,
                      0,
                      IntPtr.Zero,
                      null,
                      IntPtr.Zero,
                      ref processInfo);

            }
            catch (Exception)
            {
                MessageBox.Show("Cannot find specified Help. Will Display Application Help. Please inform Administator", "Help Error");

                PROCESS_INFORMATION processInfo = new PROCESS_INFORMATION();


                CreateProcess("peghelp.exe",
                      "file:NIHandheld.htm#Main_Content" ,
                      IntPtr.Zero,
                      IntPtr.Zero,
                      false,
                      0,
                      IntPtr.Zero,
                      null,
                      IntPtr.Zero,
                      ref processInfo);

            }


        }
        // Import CreateProcess from coredll
        #region Win32 APIs

        [DllImport("coredll.dll", SetLastError = true, CharSet = CharSet.Unicode)]
        public static extern int CreateProcess(string ImageName, string CmdLine, IntPtr Process, IntPtr Thread, bool InheritHandles, uint Create, IntPtr Environment, char[] CurDir, IntPtr StartInfo, ref PROCESS_INFORMATION procInfo);

        #endregion

        #region PROCESS_INFORMATION
        // Process information structure for CreateProcess
        [StructLayout(LayoutKind.Sequential)]
        public struct PROCESS_INFORMATION
        {
            public IntPtr hProcess;
            public IntPtr hThread;
            public uint dwProcessId;
            public uint dwThreadId;
        }
        #endregion

    }
}
