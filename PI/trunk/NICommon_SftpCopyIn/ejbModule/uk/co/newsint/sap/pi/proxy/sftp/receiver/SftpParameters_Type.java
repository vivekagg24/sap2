package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpParameters_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 1355008096L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326807415818L) ;

    private  SftpParameters_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpParameters", 3, 0, SftpParameters_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "ArchiveSourceFile", "false", null, "unqualified", "http://www.w3.org/2001/XMLSchema:boolean", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "archiveSourceFile", java.lang.Boolean.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "ArchiveDirectory", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "archiveDirectory", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "OverwriteTargetFile", "true", null, "unqualified", "http://www.w3.org/2001/XMLSchema:boolean", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "overwriteTargetFile", java.lang.Boolean.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    protected  SftpParameters_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public  SftpParameters_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    public void unsetOverwriteTargetFile() {
        baseTypeData().deleteElementValue(2);
    }

    public void setArchiveDirectory(java.lang.String archiveDirectory) {
        baseTypeData().setElementValue(1, archiveDirectory);
    }

    public boolean isSetArchiveSourceFile() {
        return baseTypeData().hasElementValue(0);
    }

    public void setArchiveSourceFile(boolean archiveSourceFile) {
        baseTypeData().setElementValue(0, archiveSourceFile);
    }

    public boolean isSetOverwriteTargetFile() {
        return baseTypeData().hasElementValue(2);
    }

    public boolean getOverwriteTargetFile() {
        return baseTypeData().getElementValueAsBoolean(2);
    }

    public void unsetArchiveDirectory() {
        baseTypeData().deleteElementValue(1);
    }

    public void setOverwriteTargetFile(boolean overwriteTargetFile) {
        baseTypeData().setElementValue(2, overwriteTargetFile);
    }

    public void unsetArchiveSourceFile() {
        baseTypeData().deleteElementValue(0);
    }

    public boolean getArchiveSourceFile() {
        return baseTypeData().getElementValueAsBoolean(0);
    }

    public SftpParameters_Type.MetaData metadataSftpParameters_Type() {
        return metadata;
    }

    public java.lang.String getArchiveDirectory() {
        return (java.lang.String)baseTypeData().getElementValueAsString(1);
    }

    public boolean isSetArchiveDirectory() {
        return baseTypeData().hasElementValue(1);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpParameters_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpParameters_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getOverwriteTargetFile() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getArchiveSourceFile() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getArchiveDirectory() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
    }

}
