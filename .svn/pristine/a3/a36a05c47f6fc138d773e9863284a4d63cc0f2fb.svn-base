package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpTransfer_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 1194076991L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1300357985683L) ;

    private  SftpTransfer_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpTransfer", 3, 0, uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "Location", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Location", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "location", uk.co.newsint.sap.pi.proxy.sftp.receiver.Location_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.Location_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "Authentication", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Authentication", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "authentication", uk.co.newsint.sap.pi.proxy.sftp.receiver.Authentication_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.Authentication_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "Payload", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Payload", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "payload", uk.co.newsint.sap.pi.proxy.sftp.receiver.Payload_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.Payload_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    public  SftpTransfer_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  SftpTransfer_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public boolean isSetLocation() {
        return baseTypeData().hasElementValue(0);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.Authentication_Type getAuthentication() {
        return (uk.co.newsint.sap.pi.proxy.sftp.receiver.Authentication_Type)baseTypeData().getElementValue(1);
    }

    public boolean isSetAuthentication() {
        return baseTypeData().hasElementValue(1);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.Payload_Type getPayload() {
        return (uk.co.newsint.sap.pi.proxy.sftp.receiver.Payload_Type)baseTypeData().getElementValue(2);
    }

    public void unsetPayload() {
        baseTypeData().deleteElementValue(2);
    }

    public void unsetLocation() {
        baseTypeData().deleteElementValue(0);
    }

    public void setPayload(uk.co.newsint.sap.pi.proxy.sftp.receiver.Payload_Type payload) {
        baseTypeData().setElementValue(2, payload);
    }

    public boolean isSetPayload() {
        return baseTypeData().hasElementValue(2);
    }

    public void setAuthentication(uk.co.newsint.sap.pi.proxy.sftp.receiver.Authentication_Type authentication) {
        baseTypeData().setElementValue(1, authentication);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.Location_Type getLocation() {
        return (uk.co.newsint.sap.pi.proxy.sftp.receiver.Location_Type)baseTypeData().getElementValue(0);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.SftpTransfer_Type.MetaData metadataSftpTransfer_Type() {
        return metadata;
    }

    public void setLocation(uk.co.newsint.sap.pi.proxy.sftp.receiver.Location_Type location) {
        baseTypeData().setElementValue(0, location);
    }

    public void unsetAuthentication() {
        baseTypeData().deleteElementValue(1);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpTransfer_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpTransfer_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getAuthentication() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getPayload() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getLocation() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
    }

}
