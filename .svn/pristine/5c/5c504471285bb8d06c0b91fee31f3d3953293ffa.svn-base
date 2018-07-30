package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class Location_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = -998582908L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326281542762L) ;

    private  Location_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "Location", 4, 0, Location_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "Hostname", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "hostname", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "Port", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "port", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "Directory", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "directory", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 3, "Filename", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "filename", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    protected  Location_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public  Location_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    public void setDirectory(java.lang.String directory) {
        baseTypeData().setElementValue(2, directory);
    }

    public java.lang.String getHostname() {
        return (java.lang.String)baseTypeData().getElementValueAsString(0);
    }

    public void setFilename(java.lang.String filename) {
        baseTypeData().setElementValue(3, filename);
    }

    public void unsetPort() {
        baseTypeData().deleteElementValue(1);
    }

    public void setHostname(java.lang.String hostname) {
        baseTypeData().setElementValue(0, hostname);
    }

    public void unsetHostname() {
        baseTypeData().deleteElementValue(0);
    }

    public java.lang.String getPort() {
        return (java.lang.String)baseTypeData().getElementValueAsString(1);
    }

    public java.lang.String getFilename() {
        return (java.lang.String)baseTypeData().getElementValueAsString(3);
    }

    public void unsetFilename() {
        baseTypeData().deleteElementValue(3);
    }

    public boolean isSetPort() {
        return baseTypeData().hasElementValue(1);
    }

    public void unsetDirectory() {
        baseTypeData().deleteElementValue(2);
    }

    public java.lang.String getDirectory() {
        return (java.lang.String)baseTypeData().getElementValueAsString(2);
    }

    public boolean isSetHostname() {
        return baseTypeData().hasElementValue(0);
    }

    public void setPort(java.lang.String port) {
        baseTypeData().setElementValue(1, port);
    }

    public boolean isSetFilename() {
        return baseTypeData().hasElementValue(3);
    }

    public Location_Type.MetaData metadataLocation_Type() {
        return metadata;
    }

    public boolean isSetDirectory() {
        return baseTypeData().hasElementValue(2);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  Location_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (Location_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getDirectory() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getHostname() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getPort() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getFilename() {
            return parent.baseTypeMetaData().getElement(3);
        }
    
    }

}
