package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public interface SftpCopyIn_PortType extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound{

    public  static final com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper helper$ = new InHelp() ;

    public  static final com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptor staticDescriptor = com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptorFactory.createNewBaseProxyDescriptor("SftpCopy_In:urn:newsint.co.uk:Common:Proxy:SFTP", new java.lang.Object[][][]{{{"SftpCopy_In", "sftpCopyIn", "SftpCopy_In"}, {"SftpCopy:urn:newsint.co.uk:Common:Proxy:SFTP", "newsintCoUkCommonProxySFTP.SftpCopyIn_PortTypeBean.SftpCopy_Message"}, {"SftpFault:urn:newsint.co.uk:Common:Proxy:SFTP", SftpFault_Message_Exception.class, SftpFault_Message.class}}}, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, SftpCopyIn_PortType.class) ;

    public  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326281542750L) ;

    public void sftpCopyIn(SftpCopy_Type sftpCopy) throws SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException;

    public static class InHelp extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper{
    
        private  InHelp () {
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType requestType(java.lang.String methodName$) {
            if ("sftpCopyIn".equals(methodName$)){
            return new SftpCopyIn_PortType.InHelp.SftpCopy_Message();}
            return null;
        }
    
        public boolean methodExists(java.lang.String methodName$) {
            if ("sftpCopyIn".equals(methodName$)){
            return true;}
            return false;
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType invokeMethod(java.lang.String methodName$, com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound in$, com.sap.aii.proxy.xiruntime.core.AbstractType abstractType$) throws com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
            if ("sftpCopyIn".equals(methodName$)){
            SftpCopyIn_PortType proxy$ = (SftpCopyIn_PortType)in$;
            SftpCopyIn_PortType.InHelp.SftpCopy_Message _0_request$ = (SftpCopyIn_PortType.InHelp.SftpCopy_Message)abstractType$;
            SftpCopy_Type $request_sftpCopy = _0_request$.getSftpCopy();
            proxy$.sftpCopyIn($request_sftpCopy);
            return null;
            } throw createException(methodName$);
        }
    
        private static class SftpCopy_Message extends com.sap.aii.proxy.xiruntime.core.AbstractType implements com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote, java.io.Serializable {
        
            private  static final long serialVersionUID = 1365145324L ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326281542749L) ;
        
            private  SftpCopy_Message.MetaData metadata = new MetaData(this) ;
        
            static {
                com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.WSDL_MESSAGE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpCopy", 1, 0, SftpCopy_Message.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, 0, 0, null);
                staticDescriptor = descriptor;
                descriptorSetElementProperties(descriptor, 0, "SftpCopy", null, null, "qualified", "urn:newsint.co.uk:Common:Proxy:SFTP:SftpCopy", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "sftpCopy", SftpCopy_Type.class, new SftpCopy_Type(), new java.lang.String[][]{}, null, -1, -1, -1, -1, -1, -1, -1, -1, null);
            }
            public  SftpCopy_Message () {
                super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
                
            }
        
            protected  SftpCopy_Message (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
                super(descriptor, staticGenerationInfo, connectionType);
            }
        
            public MetaData metadataSftpCopy_Message() {
                return metadata;
            }
        
            public SftpCopy_Type getSftpCopy() {
                return (SftpCopy_Type)baseTypeData().getElementValue(0);
            }
        
            public void setSftpCopy(SftpCopy_Type sftpCopy) {
                baseTypeData().setElementValue(0, sftpCopy);
            }
        
            public static class MetaData implements java.io.Serializable {
            
                private  SftpCopy_Message parent ;
            
                private  static final long serialVersionUID = -386313361L ;
            
                protected  MetaData (SftpCopy_Message parent) {
                    this.parent = parent;
                    
                }
            
                public com.sap.aii.proxy.xiruntime.core.ElementMetaData getSftpCopy() {
                    return parent.baseTypeMetaData().getElement(0);
                }
            
                public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                    return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
                }
            
            }
        
        }
    
    }

}
