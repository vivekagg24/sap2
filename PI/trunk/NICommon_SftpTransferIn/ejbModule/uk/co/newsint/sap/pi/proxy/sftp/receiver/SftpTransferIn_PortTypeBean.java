package uk.co.newsint.sap.pi.proxy.sftp.receiver;
/** 
* @ejbHome <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundHome4}>
* @ejbRemote <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundRemote4}>
* @ejbLocal <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundLocal4}>
* @ejbLocalHome <{com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundLocalHome4}>
* @stateless
*/
public class SftpTransferIn_PortTypeBean extends com.sap.aii.proxy.xiruntime.core.AbstractProxyInboundBean4{

    private  uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortTypeImpl proxy$ = new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortTypeImpl() ;

    private  uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortTypeBean.SftpTransfer_Message _0_request$ = new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortTypeBean.SftpTransfer_Message() ;

    public com.sap.aii.proxy.xiruntime.core.MessageSpecifier $messageSpecifier() {
        proxy$.messageSpecifier.clear();
        return proxy$.messageSpecifier;
    }

    public com.sap.aii.proxy.xiruntime.core.AbstractTypeRemote requestType(java.lang.String methodName$) {
        if ("sftpTransferIn".equals(methodName$)){
        return _0_request$;}
        return null;
    }

    public com.sap.aii.proxy.xiruntime.core.BeanMessage4 invokeMethod(java.lang.String methodName$, com.sap.aii.proxy.xiruntime.core.BeanMessage4 beanMessage$) throws com.sap.aii.proxy.xiruntime.core.SystemFaultException, com.sap.aii.proxy.xiruntime.core.ApplicationFaultException{
        if ("sftpTransferIn".equals(methodName$)){
        proxy$.setMessageSpecifier$(beanMessage$.getMessageSpecifier());
        try {
        uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type $request_sftpTransfer = _0_request$.getSftpTransfer();
        proxy$.sftpTransferIn($request_sftpTransfer);
        return new com.sap.aii.proxy.xiruntime.core.BeanMessage4(proxy$.messageSpecifier);
        }catch (com.sap.aii.proxy.xiruntime.core.FaultException e$) {
        com.sap.aii.proxy.xiruntime.core.FaultException4 e4$ = new com.sap.aii.proxy.xiruntime.core.FaultException4(e$);
        return new com.sap.aii.proxy.xiruntime.core.BeanMessage4((com.sap.aii.proxy.xiruntime.core.FaultExceptionRemote)e4$ , proxy$.messageSpecifier);}
        finally { _0_request$ = new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransferIn_PortTypeBean.SftpTransfer_Message();}
        }
        return createException(methodName$);
    }

    public void $messageSpecifier(com.sap.aii.proxy.xiruntime.core.MessageSpecifier messageSpecifier) {
        proxy$.setMessageSpecifier$(messageSpecifier);
    }

    public boolean methodExists(java.lang.String methodName$) {
        if ("sftpTransferIn".equals(methodName$)){
        return true;}
        return false;
    }

    public com.sap.aii.proxy.xiruntime.core.MessageSpecifier $messageSpecifierRead() {
        return proxy$.messageSpecifier;
    }

    public java.lang.Object $runtime(int selector, Object[] args) {
        return proxy$.runtime$(selector, args);
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
