package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public interface SftpCopySyncIn_PortType extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound{

    public  static final com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper helper$ = new InHelp() ;

    public  static final com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptor staticDescriptor = com.sap.aii.proxy.xiruntime.core.BaseProxyDescriptorFactory.createNewBaseProxyDescriptor("SftpCopySync_In:urn:newsint.co.uk:Common:Proxy:SFTP", new java.lang.Object[][][]{{{"SftpCopySync_In", "sftpCopySyncIn", "SftpCopySync_In"}, {"SftpCopy:urn:newsint.co.uk:Common:Proxy:SFTP", "newsintCoUkCommonProxySFTP.SftpCopySyncIn_PortTypeBean.SftpCopy_Message"}, {"SftpCopyResponse:urn:newsint.co.uk:Common:Proxy:SFTP", "newsintCoUkCommonProxySFTP.SftpCopySyncIn_PortTypeBean.SftpCopyResponse_Message"}, {"SftpFault:urn:newsint.co.uk:Common:Proxy:SFTP", SftpFault_Message_Exception.class, SftpFault_Message.class}}}, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, SftpCopySyncIn_PortType.class) ;

    public  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326365477677L) ;

    public SftpCopyResponse_Type sftpCopySyncIn(SftpCopy_Type sftpCopy) throws SftpFault_Message_Exception, com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException;

    public static class InHelp extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound.Helper{
    
        private  InHelp () {
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType requestType(java.lang.String methodName$) {
            if ("sftpCopySyncIn".equals(methodName$)){
            return new SftpCopySyncIn_PortType.InHelp.SftpCopy_Message();}
            return null;
        }
    
        public boolean methodExists(java.lang.String methodName$) {
            if ("sftpCopySyncIn".equals(methodName$)){
            return true;}
            return false;
        }
    
        public com.sap.aii.proxy.xiruntime.core.AbstractType invokeMethod(java.lang.String methodName$, com.sap.aii.proxy.xiruntime.core.AbstractProxyInbound in$, com.sap.aii.proxy.xiruntime.core.AbstractType abstractType$) throws com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
            if ("sftpCopySyncIn".equals(methodName$)){
            SftpCopySyncIn_PortType proxy$ = (SftpCopySyncIn_PortType)in$;
            SftpCopySyncIn_PortType.InHelp.SftpCopy_Message _0_request$ = (SftpCopySyncIn_PortType.InHelp.SftpCopy_Message)abstractType$;
            SftpCopy_Type $request_sftpCopy = _0_request$.getSftpCopy();
            SftpCopyResponse_Type $response_sftpCopyResponse = proxy$.sftpCopySyncIn($request_sftpCopy);
            SftpCopySyncIn_PortType.InHelp.SftpCopyResponse_Message response$ = new SftpCopySyncIn_PortType.InHelp.SftpCopyResponse_Message();
            response$.setSftpCopyResponse($response_sftpCopyResponse);
            return response$;
            } throw createException(methodName$);
        }
    
        private static class SftpCopyResponse_Message extends com.sap.aii.proxy.xiruntime.core.AbstractType implements com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote, java.io.Serializable {
        
            private  static final long serialVersionUID = -514098611L ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326365477676L) ;
        
            private  SftpCopyResponse_Message.MetaData metadata = new MetaData(this) ;
        
            static {
                com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.WSDL_MESSAGE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpCopyResponse", 1, 0, SftpCopyResponse_Message.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, 0, 0, null);
                staticDescriptor = descriptor;
                descriptorSetElementProperties(descriptor, 0, "SftpCopyResponse", null, null, "qualified", "urn:newsint.co.uk:Common:Proxy:SFTP:SftpCopyResponse", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "sftpCopyResponse", SftpCopyResponse_Type.class, new SftpCopyResponse_Type(), new java.lang.String[][]{}, null, -1, -1, -1, -1, -1, -1, -1, -1, null);
            }
            protected  SftpCopyResponse_Message (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
                super(descriptor, staticGenerationInfo, connectionType);
            }
        
            public  SftpCopyResponse_Message () {
                super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
                
            }
        
            public MetaData metadataSftpCopyResponse_Message() {
                return metadata;
            }
        
            public void setSftpCopyResponse(SftpCopyResponse_Type sftpCopyResponse) {
                baseTypeData().setElementValue(0, sftpCopyResponse);
            }
        
            public SftpCopyResponse_Type getSftpCopyResponse() {
                return (SftpCopyResponse_Type)baseTypeData().getElementValue(0);
            }
        
            public static class MetaData implements java.io.Serializable {
            
                private  SftpCopyResponse_Message parent ;
            
                private  static final long serialVersionUID = -386313361L ;
            
                protected  MetaData (SftpCopyResponse_Message parent) {
                    this.parent = parent;
                    
                }
            
                public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                    return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
                }
            
                public com.sap.aii.proxy.xiruntime.core.ElementMetaData getSftpCopyResponse() {
                    return parent.baseTypeMetaData().getElement(0);
                }
            
            }
        
        }
    
        private static class SftpCopy_Message extends com.sap.aii.proxy.xiruntime.core.AbstractType implements com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote, java.io.Serializable {
        
            private  static final long serialVersionUID = 1365145324L ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
        
            private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326365477676L) ;
        
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
