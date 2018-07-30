package uk.co.newsint.sap.pi.proxy.sftp.receiver;
/** 
* @ejbHome <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundHome4}>
* @ejbRemote <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundRemote4}>
* @ejbLocal <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundLocal4}>
* @ejbLocalHome <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundLocalHome4}>
* @stateless
*/
public class SftpCopySyncIn_PortTypeBean extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundBean4{

    private  SftpCopySyncIn_PortTypeImpl proxy$ = new SftpCopySyncIn_PortTypeImpl() ;

    private  SftpCopySyncIn_PortTypeBean.SftpCopy_Message _0_request$ = new SftpCopySyncIn_PortTypeBean.SftpCopy_Message() ;

    public com.sap.aii.proxy.xiruntime.core.MessageSpecifier $messageSpecifier() {
        proxy$.messageSpecifier.clear();
        return proxy$.messageSpecifier;
    }

    public com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote requestType(java.lang.String methodName$) {
        if ("sftpCopySyncIn".equals(methodName$)){
        return _0_request$;}
        return null;
    }

    public com.sap.aii.proxy.xiruntime.core.BeanMessage4 invokeMethod(java.lang.String methodName$, com.sap.aii.proxy.xiruntime.core.BeanMessage4 beanMessage$) throws com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
        if ("sftpCopySyncIn".equals(methodName$)){
        proxy$.setMessageSpecifier$(beanMessage$.getMessageSpecifier());
        try {
        SftpCopy_Type $request_sftpCopy = _0_request$.getSftpCopy();
        SftpCopyResponse_Type $response_sftpCopyResponse = proxy$.sftpCopySyncIn($request_sftpCopy);
        SftpCopySyncIn_PortTypeBean.SftpCopyResponse_Message response$ = new SftpCopySyncIn_PortTypeBean.SftpCopyResponse_Message();
        response$.setSftpCopyResponse($response_sftpCopyResponse);
        return new com.sap.aii.proxy.xiruntime.core.BeanMessage4(response$, proxy$.messageSpecifier);
        }catch (com.sap.aii.proxy.xiruntime.core.FaultException e$) {
        com.sap.aii.proxy.xiruntime.core.FaultException4 e4$ = new com.sap.aii.proxy.xiruntime.core.FaultException4(e$);
        return new com.sap.aii.proxy.xiruntime.core.BeanMessage4((com.sap.aii.proxy.xiruntime.core.FaultExceptionRemote)e4$ , proxy$.messageSpecifier);}
        finally { _0_request$ = new SftpCopySyncIn_PortTypeBean.SftpCopy_Message();}
        }
        return createException(methodName$);
    }

    public void $messageSpecifier(com.sap.aii.proxy.xiruntime.core.MessageSpecifier messageSpecifier) {
        proxy$.setMessageSpecifier$(messageSpecifier);
    }

    public boolean methodExists(java.lang.String methodName$) {
        if ("sftpCopySyncIn".equals(methodName$)){
        return true;}
        return false;
    }

    public com.sap.aii.proxy.xiruntime.core.MessageSpecifier $messageSpecifierRead() {
        return proxy$.messageSpecifier;
    }

    public java.lang.Object $runtime(int selector, Object[] args) {
        return proxy$.runtime$(selector, args);
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
