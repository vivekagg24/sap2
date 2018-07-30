package uk.co.newsint.sap.pi.proxy.sftp.common;

import ch.ethz.ssh2.InteractiveCallback;

public class SftpInteractiveCallback implements InteractiveCallback {

	private String username = null;
	private String password = null;
	
	SftpInteractiveCallback(String user, String pass) {
		username = user;
		password = pass;
	}
	
	/**
	 * Response to keyboard interactive authentication request
	 * 
	 */
	public String[] replyToChallenge(String name, String instruction,
			int numPrompts, String[] prompt, boolean[] echo) throws Exception {
		
		String[] result = new String[numPrompts];
		
		for (int i = 0; i < numPrompts; i++) {
			if (prompt[i].toLowerCase().startsWith("password")) {
				result[i] = password;
			}
		}
		return result;
	}

}
