package uk.co.newsint.sap.pi.proxy.sftp.receiver;

import java.io.File;
import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.SFTPException;
import ch.ethz.ssh2.SFTPv3Client;
import ch.ethz.ssh2.SFTPv3FileHandle;

/**
 * $Id$
 * 
 * Perform SFTP transfer of provided payload to system provided in PI message
 * body. See namespace urn:newsint.co.uk:Common:Proxy:SFTP of SWCV
 * NI_B_COMMON 1.0 for the message definitions.
 * 
 * @author Michael-John Turner <mj.turner@newsint.co.uk>
 * 
 */
public class SftpTransferIn_PortTypeImpl extends com.sap.aii.proxy.xiruntime.core.AbstractProxy implements SftpTransferIn_PortType {

	private static final long serialVersionUID = 5868842823854408443L;

	/**
	 * Do the transfer
	 */
	public void sftpTransferIn(SftpTransfer_Type sftpTransfer) throws SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
		final String CRLF = "\r\n";
		final String LF = "\n";
		final int PORT_DEFAULT = 22; 
		
		SftpFault_Message sftpFaultMessage = null;
		SftpFault_Type sftpFault = null;
		ExchangeFaultData_Type standardFault;
		
    	Connection conn = null;
    	SFTPv3Client sftp = null;
    
    	try {
    		
    		// Get the payload, adjusting the line-ending
    		String strPayload = sftpTransfer.getPayload().getData().toString();
    		strPayload = strPayload.replace(";", ""); // urgh...
    		strPayload = strPayload.replaceAll("\\n", CRLF);
    		
    		byte[] bytePayload = strPayload.getBytes();
    		
    		// Make sure we got valid parameters. We should do some more validation here...
    		String hostname = sftpTransfer.getLocation().getHostname();
    		
    		int port = 0;
    		try {
    			port = Integer.parseInt(sftpTransfer.getLocation().getPort());
    		} catch (NumberFormatException e) {
    			port = 0;
    		}
    		if (port <= 0) {
    			port = PORT_DEFAULT;
    		}
    		    		
    		String username = sftpTransfer.getAuthentication().getUsername();
    		String password = sftpTransfer.getAuthentication().getPassword();
    		String directory = sftpTransfer.getLocation().getDirectory();
    		String filename = sftpTransfer.getLocation().getFilename();
    		
    		if (null == hostname || null == directory || null == username || null == password || null == filename) {
    			sftpFaultMessage = new SftpFault_Message();
    			sftpFault = new SftpFault_Type();
    			standardFault = new ExchangeFaultData_Type();
    			standardFault.setFaultText("Hostname, Directory, Filename, Username and Password must be supplied");
    			sftpFault.setStandard(standardFault);
    				
    			sftpFaultMessage.setSftpFault(sftpFault);

    			SftpFault_Message_Exception ex = new SftpFault_Message_Exception();
    			ex.setSftpFault_Message(sftpFaultMessage);
    			throw ex;
    		}

    		String target = directory + File.separatorChar + filename;
    		
    		conn = new Connection(hostname, port);
    		conn.connect();
    		conn.authenticateWithPassword(username, password);
    		sftp = new SFTPv3Client(conn);

    		SFTPv3FileHandle handle = sftp.createFileTruncate(target);
    		sftp.write(handle, 0, bytePayload, 0, bytePayload.length);
    		sftp.closeFile(handle);

    	} catch (Exception e) {
			sftpFaultMessage = new SftpFault_Message();
			sftpFault = new SftpFault_Type();
			standardFault = new ExchangeFaultData_Type();
			if (e instanceof SFTPException) {
				standardFault.setFaultText(((SFTPException)e).getServerErrorMessage());
			} else {
				standardFault.setFaultText(e.getMessage());		
			}
			sftpFault.setStandard(standardFault);			
			sftpFaultMessage.setSftpFault(sftpFault);

			SftpFault_Message_Exception ex = new SftpFault_Message_Exception();
			ex.setSftpFault_Message(sftpFaultMessage);
			throw ex;
    	} finally {
    		// Close the connections
    		if (null != sftp) {
    			sftp.close();
    		}    		
    		if (null != conn) {
    			conn.close();
    		}
    		
    	}
    }
    	
    	
}
