public with sharing class recordTypeSample{
 
    public String selectedRT {get;set;}
    public List<SelectOption> recordTypeList {get;set;}
    public Contact customer {get;set;}
     
    public recordTypeSample(){
     
        customer = new Contact();
        recordTypeList = new List<SelectOption>();
        getRecordTypeList();
     
    }
     
    public void getRecordTypeList(){
          
        List<RecordType> rtList = [SELECT Id,Name FROM RecordType WHERE SObjectType='Contact'];
        recordTypeList.add(new SelectOption('--None--', '--None--'));
        for(RecordType rt : rtList)
        {
            recordTypeList.add(new SelectOption(rt.Id, rt.Name));
        }
    }
     
     public void getPickListValues(){
      
        if(selectedRT != null){
            customer = new Contact(RecordTypeId = selectedRT);
            
        }
    }
}