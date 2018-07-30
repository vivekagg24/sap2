package uk.co.newsint.sap.pi.proxy.sftp.receiver;

import uk.co.newsint.sap.pi.proxy.sftp.common.SftpCopy;
import uk.co.newsint.sap.pi.proxy.sftp.common.SftpCopy.Location;
import uk.co.newsint.sap.pi.proxy.sftp.receiver.*;
import java.math.BigInteger;

import ch.ethz.ssh2.SFTPException;

public class SftpCopySyncIn_PortTypeImpl extends com.sap.aii.proxy.xiruntime.core.AbstractProxy implements SftpCopySyncIn_PortType {

    public SftpCopyResponse_Type sftpCopySyncIn(SftpCopy_Type sftpCopy) throws SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
		final String METHOD = "SftpCopySyncIn_PortTypeImpl.sftpCopySyncIn(): ";    	
    	
		Location target;
		SftpCopyResponse_Type response = new SftpCopyResponse_Type();
    	SftpCopyResponse_Type.Return_Type responseReturn = new SftpCopyResponse_Type.Return_Type();
		Location_Type responseTarget = new Location_Type();
    	
    	System.err.println(METHOD + "Called");
    	
    	try {
	    	SftpCopy sftp = new SftpCopy();
	    	target = sftp.copy(sftpCopy.getSource(), sftpCopy.getTarget());
	    	
    		responseReturn.setCode(BigInteger.ZERO);
    		responseTarget.setHostname(target.hostname);
    		responseTarget.setPort(String.valueOf(target.port));
    		responseTarget.setDirectory(target.directory);
    		responseTarget.setFilename(target.filename);
    		response.setActualTarget(responseTarget);

    		responseReturn.setMessage("Copied " + target.size.toString() + " bytes");
    	} catch (Exception e) {
    		System.err.println(METHOD + "Exception: " + e.toString());
    		
    		String desc;
    		responseReturn.setCode(BigInteger.valueOf(-1));

			if (e instanceof SFTPException) {
				desc = ((SFTPException)e).getServerErrorMessage();
			} else if (e instanceof SftpFault_Message_Exception) {
				SftpFault_Message_Exception sftpFault = (SftpFault_Message_Exception)e;
				desc = sftpFault.getSftpFault_Message().getSftpFault().getStandard().getFaultText();
			} else {
				desc = e.getMessage();
			}
    		    		
    		responseReturn.setMessage(desc);
    	}
    	response.setReturn(responseReturn);

    	System.err.println(METHOD + "Completed");   	
    	
    	return response;
    }

}
