package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public interface SftpTransferIn_PortType extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound{

    public  static final com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper helper$ = new InHelp() ;

    public  static final com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptor staticDescriptor = com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptorFactory.createNewBaseProxyDescriptor("SftpTransfer_In:urn:newsint.co.uk:Common:Proxy:SFTP", new java.lang.Object[][][]{{{"SftpTransfer_In", "sftpTransferIn", "SftpTransfer_In"}, {"SftpTransfer:urn:newsint.co.uk:Common:Proxy:SFTP", "newsintCoUkCommonProxySFTP.SftpTransferIn_PortTypeBean.SftpTransfer_Message"}, {"SftpFault:urn:newsint.co.uk:Common:Proxy:SFTP", uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message_Exception.class, uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message.class}}}, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType.class) ;

    public  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1300357985680L) ;

    public void sftpTransferIn(uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type sftpTransfer) throws uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException;

    public static class InHelp extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper{
    
        private  InHelp () {
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType requestType(java.lang.String methodName$) {
            if ("sftpTransferIn".equals(methodName$)){
            return new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType.InHelp.SftpTransfer_Message();}
            return null;
        }
    
        public boolean methodExists(java.lang.String methodName$) {
            if ("sftpTransferIn".equals(methodName$)){
            return true;}
            return false;
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType invokeMethod(java.lang.String methodName$, com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound in$, com.sap.aii.proxy.xiruntime.core.AbstractType abstractType$) throws com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
            if ("sftpTransferIn".equals(methodName$)){
            uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType proxy$ = (uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType)in$;
            uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType.InHelp.SftpTransfer_Message _0_request$ = (uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortType.InHelp.SftpTransfer_Message)abstractType$;
            uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type $request_sftpTransfer = _0_request$.getSftpTransfer();
            proxy$.sftpTransferIn($request_sftpTransfer);
            return null;
            } throw createException(methodName$);
        }
    
        private static class SftpTransfer_Message extends com.sap.aii.proxy.xiruntime.core.AbstractType implements com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote, java.io.Serializable {
        
            private  static final long serialVersionUID = -658363934L ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1300357985680L) ;
        
            private  SftpTransfer_Message.MetaData metadata = new MetaData(this) ;
        
            static {
                com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.WSDL_MESSAGE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpTransfer", 1, 0, SftpTransfer_Message.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, 0, 0, null);
                staticDescriptor = descriptor;
                descriptorSetElementProperties(descriptor, 0, "SftpTransfer", null, null, "qualified", "urn:newsint.co.uk:Common:Proxy:SFTP:SftpTransfer", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "sftpTransfer", uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type(), new java.lang.String[][]{}, null, -1, -1, -1, -1, -1, -1, -1, -1, null);
            }
            public  SftpTransfer_Message () {
                super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
                
            }
        
            protected  SftpTransfer_Message (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
                super(descriptor, staticGenerationInfo, connectionType);
            }
        
            public MetaData metadataSftpTransfer_Message() {
                return metadata;
            }
        
            public void setSftpTransfer(uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type sftpTransfer) {
                baseTypeData().setElementValue(0, sftpTransfer);
            }
        
            public uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type getSftpTransfer() {
                return (uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type)baseTypeData().getElementValue(0);
            }
        
            public static class MetaData implements java.io.Serializable {
            
                private  SftpTransfer_Message parent ;
            
                private  static final long serialVersionUID = -386313361L ;
            
                protected  MetaData (SftpTransfer_Message parent) {
                    this.parent = parent;
                    
                }
            
                public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                    return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
                }
            
                public com.sap.aii.proxy.xiruntime.core.ElementMetaData getSftpTransfer() {
                    return parent.baseTypeMetaData().getElement(0);
                }
            
            }
        
        }
    
    }

}
