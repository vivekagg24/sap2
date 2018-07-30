package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class SftpCopyResponse_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 555985588L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326820019236L) ;

    private  SftpCopyResponse_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "SftpCopyResponse", 2, 0, SftpCopyResponse_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "Return", null, null, "unqualified", null, "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "return", Return_Type.class, new Return_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "ActualTarget", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:Location", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "actualTarget", Location_Type.class, new Location_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    protected  SftpCopyResponse_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public  SftpCopyResponse_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    public SftpCopyResponse_Type.MetaData metadataSftpCopyResponse_Type() {
        return metadata;
    }

    public Return_Type getReturn() {
        return (Return_Type)baseTypeData().getElementValue(0);
    }

    public void setActualTarget(Location_Type actualTarget) {
        baseTypeData().setElementValue(1, actualTarget);
    }

    public void unsetActualTarget() {
        baseTypeData().deleteElementValue(1);
    }

    public Location_Type getActualTarget() {
        return (Location_Type)baseTypeData().getElementValue(1);
    }

    public void setReturn(Return_Type _return) {
        baseTypeData().setElementValue(0, _return);
    }

    public boolean isSetActualTarget() {
        return baseTypeData().hasElementValue(1);
    }

    public static class MetaData implements java.io.Serializable {
    
        private  SftpCopyResponse_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (SftpCopyResponse_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getReturn() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getActualTarget() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
    }

    public static class Return_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {
    
        private  static final long serialVersionUID = 180675817L ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1326820019236L) ;
    
        private  Return_Type.MetaData metadata = new MetaData(this) ;
    
        static {
            com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "", 3, 0, Return_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, -1, -1, -1, null);
            staticDescriptor = descriptor;
            descriptorSetElementProperties(descriptor, 0, "Code", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:integer", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "code", java.math.BigInteger.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
            descriptorSetElementProperties(descriptor, 1, "Message", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "message", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
            descriptorSetElementProperties(descriptor, 2, "MessageDetail", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "messageDetail", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        }
        public  Return_Type () {
            super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
            
        }
    
        protected  Return_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
            super(descriptor, staticGenerationInfo, connectionType);
        }
    
        public void unsetMessageDetail() {
            baseTypeData().deleteElementValue(2);
        }
    
        public java.lang.String getMessageDetail() {
            return (java.lang.String)baseTypeData().getElementValueAsString(2);
        }
    
        public java.lang.String getMessage() {
            return (java.lang.String)baseTypeData().getElementValueAsString(1);
        }
    
        public java.math.BigInteger getCode() {
            return (java.math.BigInteger)baseTypeData().getElementValueAsBigInteger(0);
        }
    
        public boolean isSetMessageDetail() {
            return baseTypeData().hasElementValue(2);
        }
    
        public void setMessageDetail(java.lang.String messageDetail) {
            baseTypeData().setElementValue(2, messageDetail);
        }
    
        public void unsetMessage() {
            baseTypeData().deleteElementValue(1);
        }
    
        public void setMessage(java.lang.String message) {
            baseTypeData().setElementValue(1, message);
        }
    
        public boolean isSetMessage() {
            return baseTypeData().hasElementValue(1);
        }
    
        public MetaData metadataReturn_Type() {
            return metadata;
        }
    
        public void setCode(java.math.BigInteger code) {
            baseTypeData().setElementValue(0, code);
        }
    
        public static class MetaData implements java.io.Serializable {
        
            private  Return_Type parent ;
        
            private  static final long serialVersionUID = -386313361L ;
        
            protected  MetaData (Return_Type parent) {
                this.parent = parent;
                
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getMessageDetail() {
                return parent.baseTypeMetaData().getElement(2);
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getMessage() {
                return parent.baseTypeMetaData().getElement(1);
            }
        
            public com.sap.aii.proxy.xiruntime.core.ElementMetaData getCode() {
                return parent.baseTypeMetaData().getElement(0);
            }
        
            public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
                return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
            }
        
        }
    
    }

}
