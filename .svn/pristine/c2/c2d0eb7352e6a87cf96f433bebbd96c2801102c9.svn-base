package uk.co.newsint.sap.pi.proxy.sftp.receiver;

import java.io.File;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.SFTPException;
import ch.ethz.ssh2.SFTPv3Client;
import ch.ethz.ssh2.SFTPv3FileHandle;

import uk.co.newsint.sap.pi.proxy.sftp.common.*;

public class SftpCopyIn_PortTypeImpl extends com.sap.aii.proxy.xiruntime.core.AbstractProxy implements SftpCopyIn_PortType {
	
	/**
	 * Do the copy
	 * 
	 */
    public void sftpCopyIn(SftpCopy_Type sftpCopy) throws SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
		final String METHOD = "SftpCopyIn_PortTypeImpl.sftpCopyIn(): ";
    	
    	System.err.println(METHOD + "Called");
    	
    	SftpCopy sftp = new SftpCopy();
    	sftp.copy(sftpCopy.getSource(), sftpCopy.getTarget());

    	System.err.println(METHOD + "Completed");    	
    }

}
