package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpFault_Message_Exception extends com.sap.aii.proxy.xiruntime.core.ApplicationFaultException implements java.io.Serializable {

    private  static final long serialVersionUID = 459634635L ;

    public void setSftpFault_Message(uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message fault) {
        this.fault = fault;
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message getSftpFault_Message() {
        return (uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message)fault;
    }

}
