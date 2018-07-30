package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpFault_Message extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 620765915L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1300357985680L) ;

    private  SftpFault_Message.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.WSDL_MESSAGE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpFault", 1, 0, uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Message.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "SftpFault", null, null, "qualified", "urn:newsint.co.uk:Common:Proxy:SFTP:SftpFault", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "sftpFault", uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Type(), new java.lang.String[][]{}, null, -1, -1, -1, -1, -1, -1, -1, -1, null);
    }
    public  SftpFault_Message () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  SftpFault_Message (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Type getSftpFault() {
        return (uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Type)baseTypeData().getElementValue(0);
    }

    public MetaData metadataSftpFault_Message() {
        return metadata;
    }

    public void setSftpFault(uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpFault_Type sftpFault) {
        baseTypeData().setElementValue(0, sftpFault);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpFault_Message parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpFault_Message parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getSftpFault() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
    }

}
