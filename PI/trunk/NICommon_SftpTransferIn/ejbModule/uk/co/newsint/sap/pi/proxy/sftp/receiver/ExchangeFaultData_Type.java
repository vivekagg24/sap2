package uk.co.newsint.sap.pi.proxy.sftp.receiver;
public class ExchangeFaultData_Type extends com.sap.aii.proxy.xiruntime.core.AbstractType implements java.io.Serializable {

    private  static final long serialVersionUID = 772423664L ;

    private  static final com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor staticDescriptor ;

    private  static final com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo = new com.sap.aii.proxy.xiruntime.core.GenerationInfo("3.0", 1300357985682L) ;

    private  ExchangeFaultData_Type.MetaData metadata = new MetaData(this) ;

    static {
        com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor = createNewBaseTypeDescriptor(com.sap.aii.proxy.xiruntime.core.XsdlConstants.XSDL_COMPLEX_TYPE, "urn:newsint.co.uk:Common:Proxy:SFTP", "ExchangeFaultData", 3, 0, uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeFaultData_Type.class, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML, null, 0, 0, 0, null);
        staticDescriptor = descriptor;
        descriptorSetElementProperties(descriptor, 0, "faultText", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 1, 1, false, null, "faultText", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 1, "faultUrl", null, null, "unqualified", "http://www.w3.org/2001/XMLSchema:string", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, 1, false, null, "faultUrl", java.lang.String.class, null, new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
        descriptorSetElementProperties(descriptor, 2, "faultDetail", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:ExchangeLogData", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, -1, false, null, "faultDetail", FaultDetail_List.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type(), new java.lang.String[][]{}, null, 0, 0, 0, -1, -1, -1, -1, 0, null);
    }
    public  ExchangeFaultData_Type () {
        super(staticDescriptor, staticGenerationInfo, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
        
    }

    protected  ExchangeFaultData_Type (com.sap.aii.proxy.xiruntime.core.BaseTypeDescriptor descriptor, com.sap.aii.proxy.xiruntime.core.GenerationInfo staticGenerationInfo, int connectionType) {
        super(descriptor, staticGenerationInfo, connectionType);
    }

    public FaultDetail_List get_as_listFaultDetail() {
        return (FaultDetail_List)baseTypeData().getElementValue(2);
    }

    public void unsetFaultUrl() {
        baseTypeData().deleteElementValue(1);
    }

    public void setFaultDetail(FaultDetail_List faultDetail) {
        baseTypeData().setElementValue(2, faultDetail);
    }

    public boolean isSetFaultDetail() {
        return baseTypeData().hasElementValue(2);
    }

    public java.lang.String getFaultUrl() {
        return (java.lang.String)baseTypeData().getElementValueAsString(1);
    }

    public java.lang.String getFaultText() {
        return (java.lang.String)baseTypeData().getElementValueAsString(0);
    }

    public void unsetFaultDetail() {
        baseTypeData().deleteElementValue(2);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type[] getFaultDetail() {
        FaultDetail_List i$ = (FaultDetail_List)baseTypeData().getElementValue(2);
        if ( i$ == null){return null;}
        return  i$.toArrayFaultDetail();
    }

    public void setFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type[] faultDetail) {
        baseTypeData().setElementValue(2, new FaultDetail_List());
        FaultDetail_List list$ = get_as_listFaultDetail();
        for (int  i$ = 0; i$ < faultDetail.length; i$++){
         list$.addFaultDetail(faultDetail[ i$]);
        }
    }

    public boolean isSetFaultUrl() {
        return baseTypeData().hasElementValue(1);
    }

    public void setFaultUrl(java.lang.String faultUrl) {
        baseTypeData().setElementValue(1, faultUrl);
    }

    public void setFaultText(java.lang.String faultText) {
        baseTypeData().setElementValue(0, faultText);
    }

    public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeFaultData_Type.MetaData metadataExchangeFaultData_Type() {
        return metadata;
    }

    public static class MetaData implements java.io.Serializable {
    
        private  ExchangeFaultData_Type parent ;
    
        private  static final long serialVersionUID = -386313361L ;
    
        protected  MetaData (ExchangeFaultData_Type parent) {
            this.parent = parent;
            
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getFaultDetail() {
            return parent.baseTypeMetaData().getElement(2);
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getFaultUrl() {
            return parent.baseTypeMetaData().getElement(1);
        }
    
        public com.sap.aii.proxy.xiruntime.core.TypeMetaData typeMetadata() {
            return (com.sap.aii.proxy.xiruntime.core.TypeMetaData)parent.baseTypeMetaData();
        }
    
        public com.sap.aii.proxy.xiruntime.core.ElementMetaData getFaultText() {
            return parent.baseTypeMetaData().getElement(0);
        }
    
    }

    public static class FaultDetail_List extends com.sap.aii.proxy.xiruntime.core.AbstractList implements java.util.List, java.io.Serializable {
    
        private  static final long serialVersionUID = 1321485555L ;
    
        private  static final com.sap.aii.proxy.xiruntime.core.XsdlElementProperties staticElementProperties = createElementProperties("faultDetail", null, null, "unqualified", "urn:newsint.co.uk:Common:Proxy:SFTP:ExchangeLogData", "urn:newsint.co.uk:Common:Proxy:SFTP", false, 0, -1, false, null, "faultDetail", uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type.class, new uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type(), new java.lang.String[][]{}, -1, -1, -1, -1, null) ;
    
        public  FaultDetail_List () {
            super(staticElementProperties, com.sap.aii.proxy.xiruntime.core.FactoryConstants.CONNECTION_TYPE_XML);
            
        }
    
        public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type removeFaultDetail(int index) {
            return (uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type)baseList().remove(index);
        }
    
        public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type[] toArrayFaultDetail() {
            return (uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type[])baseList().toArray(new uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type[] {});
        }
    
        public boolean containsAllFaultDetail(FaultDetail_List item) {
            return baseList().containsAll(item);
        }
    
        public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type setFaultDetail(int index, uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            return (uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type)baseList().set(index, item);
        }
    
        public boolean containsFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            return baseList().contains(item);
        }
    
        public FaultDetail_List subListFaultDetail(int fromIndex, int toIndex) {
            return (FaultDetail_List)baseList().subList(fromIndex, toIndex);
        }
    
        public void addFaultDetail(int index, uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            baseList().add(index, item);
        }
    
        public int indexOfFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            return baseList().indexOf(item);
        }
    
        public void addAllFaultDetail(int index, FaultDetail_List item) {
            baseList().addAll(index, item);
        }
    
        public int lastIndexOfFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            return baseList().lastIndexOf(item);
        }
    
        public void addFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            baseList().add(item);
        }
    
        public void addAllFaultDetail(FaultDetail_List item) {
            baseList().addAll(item);
        }
    
        public uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type getFaultDetail(int index) {
            return (uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type)baseList().get(index);
        }
    
        public boolean removeFaultDetail(uk.co.newsint.sap.pi.proxy.sftp.receiver.ExchangeLogData_Type item) {
            return baseList().remove(item);
        }
    
    }

}
