package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpCopy_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = -1909978507L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326807415817L) ;

    private  SftpCopy_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpCopy", 3, 0, SftpCopy_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "Parameters", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:SftpParameters", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "parameters", SftpParameters_Type.class, new SftpParameters_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "Source", null, null, "unqualified", null, "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "source", Source_Type.class, new Source_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "Target", null, null, "unqualified", null, "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "target", Target_Type.class, new Target_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    public  SftpCopy_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  SftpCopy_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public boolean isSetTarget() {
        return baseTypeData().hasElementValue(2);
    }

    public void setParameters(SftpParameters_Type parameters) {
        baseTypeData().setElementValue(0, parameters);
    }

    public Source_Type getSource() {
        return (Source_Type)baseTypeData().getElementValue(1);
    }

    public void unsetSource() {
        baseTypeData().deleteElementValue(1);
    }

    public Target_Type getTarget() {
        return (Target_Type)baseTypeData().getElementValue(2);
    }

    public SftpCopy_Type.MetaData metadataSftpCopy_Type() {
        return metadata;
    }

    public boolean isSetSource() {
        return baseTypeData().hasElementValue(1);
    }

    public SftpParameters_Type getParameters() {
        return (SftpParameters_Type)baseTypeData().getElementValue(0);
    }

    public boolean isSetParameters() {
        return baseTypeData().hasElementValue(0);
    }

    public void setSource(Source_Type source) {
        baseTypeData().setElementValue(1, source);
    }

    public void unsetParameters() {
        baseTypeData().deleteElementValue(0);
    }

    public void unsetTarget() {
        baseTypeData().deleteElementValue(2);
    }

    public void setTarget(Target_Type target) {
        baseTypeData().setElementValue(2, target);
    }

    public static class Source_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {
    
        private  static final long serialVersionUID = 1582290142L ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326807415818L) ;
    
        private  Source_Type.MetaData metadata = new MetaData(this) ;
    
        static {
            com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "", 2, 0, Source_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, -1, -1, null);
            staticDescriptor = descriptor;
            descriptorSetElementProperties(descriptor, 0, "Location", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Location", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "location", Location_Type.class, new Location_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
            descriptorSetElementProperties(descriptor, 1, "Authentication", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Authentication", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "authentication", Authentication_Type.class, new Authentication_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        }
        protected  Source_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
            super(descriptor, staticGenerationInfo, connectionType);
        }
    
        public  Source_Type () {
            super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
            
        }
    
        public Authentication_Type getAuthentication() {
            return (Authentication_Type)baseTypeData().getElementValue(1);
        }
    
        public boolean isSetLocation() {
            return baseTypeData().hasElementValue(0);
        }
    
        public boolean isSetAuthentication() {
            return baseTypeData().hasElementValue(1);
        }
    
        public void setAuthentication(Authentication_Type authentication) {
            baseTypeData().setElementValue(1, authentication);
        }
    
        public MetaData metadataSource_Type() {
            return metadata;
        }
    
        public Location_Type getLocation() {
            return (Location_Type)baseTypeData().getElementValue(0);
        }
    
        public void unsetLocation() {
            baseTypeData().deleteElementValue(0);
        }
    
        public void setLocation(Location_Type location) {
            baseTypeData().setElementValue(0, location);
        }
    
        public void unsetAuthentication() {
            baseTypeData().deleteElementValue(1);
        }
    
        public static class MetaData implements java.io.Serializable {
        
            private  Source_Type parent ;
        
            private  static final long serialVersionUID = -386313361L ;
        
            protected  MetaData (Source_Type parent) {
                this.parent = parent;
                
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getAuthentication() {
                return parent.baseTypeMetaData().getElement(1);
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getLocation() {
                return parent.baseTypeMetaData().getElement(0);
            }
        
            public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
            }
        
        }
    
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpCopy_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpCopy_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getParameters() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getSource() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getTarget() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
    }

    public static class Target_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {
    
        private  static final long serialVersionUID = -417643224L ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326807415818L) ;
    
        private  Target_Type.MetaData metadata = new MetaData(this) ;
    
        static {
            com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "", 2, 0, Target_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, -1, -1, null);
            staticDescriptor = descriptor;
            descriptorSetElementProperties(descriptor, 0, "Location", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Location", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "location", Location_Type.class, new Location_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
            descriptorSetElementProperties(descriptor, 1, "Authentication", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Authentication", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "authentication", Authentication_Type.class, new Authentication_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        }
        public  Target_Type () {
            super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
            
        }
    
        protected  Target_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
            super(descriptor, staticGenerationInfo, connectionType);
        }
    
        public Authentication_Type getAuthentication() {
            return (Authentication_Type)baseTypeData().getElementValue(1);
        }
    
        public boolean isSetLocation() {
            return baseTypeData().hasElementValue(0);
        }
    
        public boolean isSetAuthentication() {
            return baseTypeData().hasElementValue(1);
        }
    
        public void setAuthentication(Authentication_Type authentication) {
            baseTypeData().setElementValue(1, authentication);
        }
    
        public Location_Type getLocation() {
            return (Location_Type)baseTypeData().getElementValue(0);
        }
    
        public void unsetLocation() {
            baseTypeData().deleteElementValue(0);
        }
    
        public void setLocation(Location_Type location) {
            baseTypeData().setElementValue(0, location);
        }
    
        public void unsetAuthentication() {
            baseTypeData().deleteElementValue(1);
        }
    
        public MetaData metadataTarget_Type() {
            return metadata;
        }
    
        public static class MetaData implements java.io.Serializable {
        
            private  Target_Type parent ;
        
            private  static final long serialVersionUID = -386313361L ;
        
            protected  MetaData (Target_Type parent) {
                this.parent = parent;
                
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getAuthentication() {
                return parent.baseTypeMetaData().getElement(1);
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getLocation() {
                return parent.baseTypeMetaData().getElement(0);
            }
        
            public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
            }
        
        }
    
    }

}
