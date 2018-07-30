package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class Authentication_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = -1697551199L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326281542763L) ;

    private  Authentication_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "Authentication", 3, 0, Authentication_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "Username", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "username", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "Password", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "password", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "Key", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "key", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    public  Authentication_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  Authentication_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public java.lang.String getPassword() {
        return (java.lang.String)baseTypeData().getElementValueAsString(1);
    }

    public boolean isSetPassword() {
        return baseTypeData().hasElementValue(1);
    }

    public boolean isSetKey() {
        return baseTypeData().hasElementValue(2);
    }

    public java.lang.String getUsername() {
        return (java.lang.String)baseTypeData().getElementValueAsString(0);
    }

    public void setPassword(java.lang.String password) {
        baseTypeData().setElementValue(1, password);
    }

    public void setKey(java.lang.String key) {
        baseTypeData().setElementValue(2, key);
    }

    public java.lang.String getKey() {
        return (java.lang.String)baseTypeData().getElementValueAsString(2);
    }

    public Authentication_Type.MetaData metadataAuthentication_Type() {
        return metadata;
    }

    public boolean isSetUsername() {
        return baseTypeData().hasElementValue(0);
    }

    public void setUsername(java.lang.String username) {
        baseTypeData().setElementValue(0, username);
    }

    public void unsetKey() {
        baseTypeData().deleteElementValue(2);
    }

    public void unsetPassword() {
        baseTypeData().deleteElementValue(1);
    }

    public void unsetUsername() {
        baseTypeData().deleteElementValue(0);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  Authentication_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (Authentication_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getPassword() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getUsername() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getKey() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
    }

}
