package uk.co.newsint.sap.pi.proxy.sftp.common;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Iterator;
import java.util.Vector;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.InteractiveCallback;
import ch.ethz.ssh2.SFTPException;
import ch.ethz.ssh2.SFTPv3Client;
import ch.ethz.ssh2.SFTPv3DirectoryEntry;
import ch.ethz.ssh2.SFTPv3FileAttributes;
import ch.ethz.ssh2.SFTPv3FileHandle;
import uk.co.newsint.sap.pi.proxy.sftp.receiver.*;

/**
 * Simple class to copy a file from one location to another, using sftp. Assumes
 * password authentication... 
 * 
 * @author MJ Turner <mj@mjturner.net>
 *
 */
public class SftpCopy {
	final int PORT_DEFAULT = 22; 
	
	public class Location {
		public String hostname = null;
		public int port = 0;
		public String directory = null;
		public String filename = null;
		public BigInteger size = BigInteger.ZERO;
	}
	
	protected void validateParams(Location_Type location, Authentication_Type auth) throws SftpFault_Message_Exception {
		SftpFault_Message sftpFaultMessage = null;
		SftpFault_Type sftpFault = null;
		ExchangeFaultData_Type standardFault;

		if (null == location.getHostname() || null == location.getDirectory() ||  
			null == auth.getUsername() || null == auth.getPassword()) {
			sftpFaultMessage = new SftpFault_Message();
			sftpFault = new SftpFault_Type();
			standardFault = new ExchangeFaultData_Type();
			standardFault.setFaultText("Source Hostname, Directory, Username and Password must be supplied");
			sftpFault.setStandard(standardFault);
				
			sftpFaultMessage.setSftpFault(sftpFault);

			SftpFault_Message_Exception ex = new SftpFault_Message_Exception();
			ex.setSftpFault_Message(sftpFaultMessage);
			throw ex;
		}
	}
	
	/**
	 * Determine the port number for a connection. If an invalid port is
	 * supplied, the default (22) is used.
	 * 
	 * @param location Location instance
	 * @return Port number
	 */
	protected int getPort(Location_Type location) {
		int port = 0;
		try {
			port = Integer.parseInt(location.getPort());
		} catch (NumberFormatException e) {
			port = 0;
		}
		if (port <= 0) {
			port = PORT_DEFAULT;
		}
		return port;
	}

	/**
	 * Copy a file, using sftp as the transport layer. Wildcards are supported, but only the first
	 * match is copied.
	 * 
	 * @param source Source (instance of <code>Source_Type</code> containing the source server/filename, etc)
	 * @param target Target (instance of <code>Target_Type</code> containing the target server/filename, etc).
	 * @return Number of bytes copied
	 */
	public Location copy(SftpCopy_Type.Source_Type source, SftpCopy_Type.Target_Type target) throws SftpFault_Message_Exception {
		final String METHOD = "SftpCopy.copy(): ";
		
    	int i;
    	BigInteger bytesCopied = BigInteger.ZERO;
		SftpFault_Message sftpFaultMessage = null;
		SftpFault_Type sftpFault = null;
		ExchangeFaultData_Type standardFault;
		
    	Connection srcConn = null, tgtConn = null;
    	SFTPv3Client srcClient = null, tgtClient = null;
    	SFTPv3FileHandle srcHandle = null, tgtHandle = null;    	
    	SFTPv3FileAttributes srcStat = null;
    	
    	Location dest = new Location();
    	
    	System.err.println(METHOD + "Started");   	
    	
    	try {
    		// Make sure we got valid parameters. We should do some more validation here...
    		
    		int srcPort = getPort(source.getLocation());
    		int tgtPort = getPort(target.getLocation());

    		validateParams(source.getLocation(), source.getAuthentication());
    		validateParams(target.getLocation(), target.getAuthentication());

    		String srcHostname = source.getLocation().getHostname();   		
    		String srcUsername = source.getAuthentication().getUsername();
    		String srcPassword = source.getAuthentication().getPassword();
    		String srcDirectory = source.getLocation().getDirectory();
    		String srcFilename = source.getLocation().getFilename();

    		String tgtHostname = target.getLocation().getHostname();   		
    		String tgtUsername = target.getAuthentication().getUsername();
    		String tgtPassword = target.getAuthentication().getPassword();
    		String tgtDirectory = target.getLocation().getDirectory();
    		String tgtFilename = target.getLocation().getFilename();

        	System.err.println(METHOD + "Source: " + srcUsername + "@" + srcHostname + ":" + srcPort);
        	System.err.println(METHOD + "Target: " + tgtUsername + "@" + tgtHostname + ":" + tgtPort);
    		
    		// Open the source connection
    		srcConn = new Connection(srcHostname, srcPort);
    		srcConn.connect();
    		
    		// Authenticate
    		if (srcConn.isAuthMethodAvailable(srcUsername, "password")) {
    			srcConn.authenticateWithPassword(srcUsername, srcPassword);
    		} else if (tgtConn.isAuthMethodAvailable(srcUsername, "keyboard-interactive")) {
    			SftpInteractiveCallback srcCallback = new SftpInteractiveCallback(srcUsername, srcPassword);
    			srcConn.authenticateWithKeyboardInteractive(srcUsername, srcCallback);
    		}
    		
    		srcClient = new SFTPv3Client(srcConn);

    		System.err.println(METHOD + "Connected to source host");
    		
    		// Convert glob patterns into a regex
			String regex = srcFilename.replace("?", ".?").replace("*", ".*?");    			

    		Vector<SFTPv3DirectoryEntry> srcFiles = srcClient.ls(srcDirectory);

    		System.err.println(METHOD + "Source directory read");
    		
    		Iterator<SFTPv3DirectoryEntry> srcFilesIterator = srcFiles.listIterator();
    		while (srcFilesIterator.hasNext()) {
    			SFTPv3DirectoryEntry dirEntry = srcFilesIterator.next();
    			if (dirEntry.filename.matches(regex)) {
    				srcFilename = dirEntry.filename;
    				break;
    			}
    		}

    		// We only do this here as we have to use the proper source file name,
    		// not one containing globs
    		if ((null == tgtFilename) || tgtFilename.trim().length() == 0) {
    			tgtFilename = srcFilename; 
    		}
    		
    		String srcFile = srcDirectory + '/' + srcFilename; // was File.separatorChar
    		String tgtFile = tgtDirectory + '/' + tgtFilename;

    		System.err.println(METHOD + "Source file: " + srcFile);
        	System.err.println(METHOD + "Target file: " + tgtFile);    		
    		
    		srcHandle = srcClient.openFileRO(srcFile);
    		srcStat = srcClient.stat(srcFile);
    		
    		// Open the target connection
    		tgtConn = new Connection(tgtHostname, tgtPort);
    		tgtConn.connect();

    		// Authenticate
    		if (tgtConn.isAuthMethodAvailable(tgtUsername, "password")) {
    			tgtConn.authenticateWithPassword(tgtUsername, tgtPassword);
    		} else if (tgtConn.isAuthMethodAvailable(tgtUsername, "keyboard-interactive")) {
    			SftpInteractiveCallback tgtCallback = new SftpInteractiveCallback(tgtUsername, tgtPassword);
    			tgtConn.authenticateWithKeyboardInteractive(tgtUsername, tgtCallback);
    		}
    		
    		tgtClient = new SFTPv3Client(tgtConn);

    		System.err.println(METHOD + "Connected to target host");
    		
    		tgtHandle = tgtClient.createFileTruncate(tgtFile);

    		byte[] buffer = new byte[32000];    
    		
    		// Copy the file
    		int offset = 0;
    		while ((i = srcClient.read(srcHandle, offset, buffer, 0, buffer.length)) >= 0) {
        		tgtClient.write(tgtHandle, offset, buffer, 0, i);
        		offset += i;
        		
        		bytesCopied = bytesCopied.add(BigInteger.valueOf(i));
    		}
        	tgtClient.closeFile(tgtHandle);
    		srcClient.closeFile(srcHandle);

        	System.err.println(METHOD + "Copied bytes: " + bytesCopied.toString());
    		
        	// Set the permissions, etc to be the same as the source file
        	try {
        		tgtClient.setstat(tgtFile, srcStat);
        	} catch (IOException e) {
        		// This isn't fatal so we just dump it to stderr
        		System.err.println(METHOD + "Warning: Cannot set target file attributes");
        		System.err.println(METHOD + e.getMessage());
        	}
        	
        	// Set the return details
        	dest.hostname = tgtHostname;
        	dest.port = tgtPort;
        	dest.directory = tgtDirectory;
        	dest.filename = tgtFilename;
        	dest.size = bytesCopied;
    		
    	} catch (Exception e) {
    		System.err.println(METHOD + "Exception: " + e.toString());
			sftpFaultMessage = new SftpFault_Message();
			sftpFault = new SftpFault_Type(); 
			standardFault = new ExchangeFaultData_Type();
			if (e instanceof SFTPException) {
				SFTPException sftpEx = (SFTPException)e;
				standardFault.setFaultText(
					sftpEx.getServerErrorMessage() + 
					" (" + sftpEx.getServerErrorCodeSymbol() + ": " + sftpEx.getServerErrorCodeVerbose() +")");
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
    		if (null != srcClient) {
    			srcClient.close();
    		}    		
    		if (null != srcConn) {
    			srcConn.close();
    		}

    		if (null != tgtClient) {
    			tgtClient.close();
    		}    		
    		if (null != tgtConn) {
    			tgtConn.close();
    		}

    	}
    	
    	System.err.println(METHOD + "Completed");   	
    	
    	return dest;	
	}
	
	
	public void test() {
		
		Authentication_Type srcAuth = new Authentication_Type();
		Authentication_Type trgAuth = new Authentication_Type();
		Location_Type srcLocation = new Location_Type();
		Location_Type trgLocation = new Location_Type();

		srcLocation.setHostname("10.198.60.106");
		srcLocation.setPort("22");
		srcLocation.setDirectory("./out");
		srcLocation.setFilename("tes*.txt");
		srcAuth.setUsername("sftp");
		srcAuth.setPassword("Wapping1");

		trgLocation.setHostname("vd11ci.ds.newsint");
		trgLocation.setPort("22");
		trgLocation.setDirectory("/work/interfaces/D11/007/inbound/DTC");
		trgLocation.setFilename("test_mj.txt");
		trgAuth.setUsername("sapdtc");
		trgAuth.setPassword("NewsInt1");

		SftpCopy_Type.Source_Type source = new SftpCopy_Type.Source_Type();  
		SftpCopy_Type.Target_Type target = new SftpCopy_Type.Target_Type();

		source.setAuthentication(srcAuth);
		source.setLocation(srcLocation);
		target.setAuthentication(trgAuth);
		target.setLocation(trgLocation);

		try {
			SftpCopy sftp = new SftpCopy();
			Location targetLoc = sftp.copy(source, target);
			System.out.println("Bytes copied: " + targetLoc.size.toString());
			System.out.println("Target file: " + targetLoc.filename);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
		}
			
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		SftpCopy sftp = new SftpCopy();
		sftp.test();
	}

}
