using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace ce5b
{
    public class PlatformInfo
    {
        [DllImport("CoreDLL.dll")]
        static extern bool SystemParametersInfo(uint uiAction, uint uiParam, StringBuilder pvParam, uint Unused);
        const uint SPI_GETPLATFORMTYPE = 257;
        const int _bufferSize = 32;
        const string _smartphoneTypeString = "Smartphone";
        const string _pocketPcTypeString = "PocketPC";

        static public string GetPlatformType()
        {
            StringBuilder PlatformType = new StringBuilder(_bufferSize);
            SystemParametersInfo(SPI_GETPLATFORMTYPE, _bufferSize, PlatformType, 0);

            return PlatformType.ToString();
        }
        static DeviceType _deviceType = DeviceType.Undefined;
        static DeviceType DeviceType
        {
            get
            {
                string platformType = GetPlatformType();
                switch (platformType)
                {
                    case _smartphoneTypeString:
                        _deviceType=DeviceType.Standard;
                        break;
                    case _pocketPcTypeString:
                        _deviceType = DeviceType.Proffesional;
                        break;
                }
                return _deviceType;
 
            }
        }
    }

    [Flags]
    enum DeviceType
    {
        Undefined = 0x00,
        Classic = 0x01,
        Proffesional = 0x02,
        Standard = 0x04B
    }


}
