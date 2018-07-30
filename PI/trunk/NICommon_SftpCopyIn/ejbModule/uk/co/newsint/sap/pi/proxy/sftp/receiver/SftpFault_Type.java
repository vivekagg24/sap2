package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpFault_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 1946975462L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326281542753L) ;

    private  SftpFault_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpFault", 1, 0, SftpFault_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "standard", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:ExchangeFaultData", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "standard", ExchangeFaultData_Type.class, new ExchangeFaultData_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    public  SftpFault_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  SftpFault_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public void setStandard(ExchangeFaultData_Type standard) {
        baseTypeData().setElementValue(0, standard);
    }

    public ExchangeFaultData_Type getStandard() {
        return (ExchangeFaultData_Type)baseTypeData().getElementValue(0);
    }

    public MetaData metadataSftpFault_Type() {
        return metadata;
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpFault_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpFault_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getStandard() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
    }

}
