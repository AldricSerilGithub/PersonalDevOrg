public class Setup360ViewController {
     /*
        Created By: Accenture - Marvin Bonifacio
        Created On: 10/23/2013
        Purpose   : Setup 360 View Object and Fields.
        --------------------------------------------------------------------------
        Modified By:    
        Modified On:  
        Modification: 
    */  
    
    public String objectName {get;set;}
    public String fieldName {get;set;}
    public String caseFieldName {get;set;}
    public String dateFieldName {get;set;}
    public String sortOrder {get;set;}
    public List<SelectOption> objects;
    public List<SelectOption> fields;
    public List<SelectOption> caseFields;
    public List<SelectOption> dateFields;
    public List<Case_View_Object__c> selectedObjects;
    
    public static final String GENERIC_ERROR = System.Label.SC_GenericSaveError;
    
    public List<Case_View_Object__c> getSelectedObjects() {
        List<Case_View_Object__c> allSelectedObjects = [SELECT Name, (SELECT Name, Case_View_Object__c, Field__c from Case_View_Fieldss__r 
         ORDER BY NAME ASC) from Case_View_Object__c ORDER BY NAME ASC];
        return allSelectedObjects;
    }//END getSelectedObjects()
    
    public List<SelectOption> getfields() {
        if(objectName<>null && objectName<>'--None--'){
            List<SelectOption> options = new List<SelectOption>();
            Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
            try {
                fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
                 
                for (String fieldMapKey: fieldMap.keySet()) {
                     String flabel = fieldMap.get(fieldMapKey).getDescribe().getLabel();
                     String fname = fieldMap.get(fieldMapKey).getDescribe().getName();
                     options.add(new SelectOption(fname,flabel) );
                     options.sort();
                }
            }//END try block
            catch(Exception e){
                system.debug('=>Exception on getfields(): ' + e.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, e.getMessage())); 
            }//END catch(Exception e)
            return options;
         }//END if(objectName<>null && objectName<>'--None--')
         return null;
    }//END getfields()
    
    public List<SelectOption> getCaseFields (){
        if(objectName<>null && objectName<>'--None--'){
            List<SelectOption> options = new List<SelectOption>();
            Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
            
            try {    
                fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
                 
                for (String fieldMapKey: fieldMap.keySet()) {
                    Boolean isCase = false;
                    Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldMapKey).getDescribe();
                    for (Schema.sObjectType objType: fieldDescribe.getReferenceTo()) {
                        if (objType == Case.sObjectType) {
                            isCase = true;
                        }
                    }
                    if (isCase) {
                         String flabel = fieldDescribe.getLabel();
                         String fname = fieldDescribe.getName();
                         options.add(new SelectOption(fname,flabel) );
                         options.sort();
                   }
                }
            }// try block
            catch(Exception e){
                system.debug('=>Exception on getCaseFields(): ' + e.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, e.getMessage())); 
            }//END catch(Exception e)
            return options;
         }//END if(objectName<>null && objectName<>'--None--')
         return null;
    }//END getCaseFields()
    
    public List<SelectOption> getDateFields (){
        if(objectName<>null && objectName<>'--None--'){
            List<SelectOption> options = new List<SelectOption>();
            Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
            
            try {
                fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
                 
                 for (String fieldMapKey: fieldMap.keySet()) {
                    Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldMapKey).getDescribe();
                    if (fieldDescribe.getType() == Schema.DisplayType.DateTime) {
                         String flabel = fieldDescribe.getLabel();
                         String fname = fieldDescribe.getName();
                         options.add(new SelectOption(fname,flabel) );
                         options.sort();
                    }
                     
                 }
            }//END try block
            catch(Exception e){
                system.debug('=>Exception on getDateFields(): ' + e.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, e.getMessage())); 
            }//END catch(Exception e)
            return options;
         }
         return null;
    }
    
    public List<SelectOption> getobjects (){
        
        List<SelectOption> options = new List<SelectOption>();
        List<String> l1=new List<String>();
        
        try {
            for (Schema.ChildRelationship s : Case.SObjectType.getDescribe().getChildRelationships()) {
                String x=''+s.getChildSObject();
                l1.add(x);            
            }
            l1.sort();
            options.add(new SelectOption('--None--','--None--'));
            for(Integer i=0;i<l1.size();i++) {
                options.add(new SelectOption(l1[i],l1[i]));
                System.debug('>> ' + l1[i]);
            }
        }//END try block
        catch(Exception e){
                system.debug('=>Exception on getDateFields(): ' + e.getMessage());
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, e.getMessage())); 
            }//END catch(Exception e)
        return options;
    }
    
    public pageReference save360Field() {
        
        if(objectName=='--None--'){
        apexpages.addmessage(new Apexpages.message(ApexPages.Severity.Error,'Please select Object'));
        return null;
        }
        
        
        Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
        Schema.DescribeSObjectResult objectDescribe = Schema.getGlobalDescribe().get(objectName).getDescribe(); 
        fieldMap = objectDescribe.fields.getMap();
        
        List<Case_View_Object__c> x360Objects = [SELECT Id from Case_View_Object__c where Name = :objectName LIMIT 1];
        Case_View_Object__c x360Object;
        if (x360Objects.isEmpty()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(dateFieldName).getDescribe();
            x360Object = new Case_View_Object__c(Name = objectName,
                             Label__c = objectDescribe.getLabel(),
                             Related_Case_Field__c = caseFieldName,
                             Sort_By_Date_Label__c = fieldDescribe.getLabel(),
                             Sort_By_Date_Field__c = dateFieldName);
            //upsert x360Object;
            
            Database.UpsertResult sr = Database.upsert(x360Object);
            if(!sr.isSuccess()){
                String errorMsgs = '';
                for(Database.Error err : sr.getErrors()){
                    errorMsgs += err.getMessage();
                }//END for(Database.Error err : sr.getErrors())
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, GENERIC_ERROR + errorMsgs));
                system.debug('=> Error on save(): '+ errorMsgs);
                return null;
            }
        }
        else {
            x360Object = x360Objects[0];
        }
        
        List<Case_View_Fields__c> x360Fields = [SELECT Id FROM Case_View_Fields__c WHERE Case_View_Object__c = :x360Object.Id AND Field__c = :fieldName LIMIT 1];
        Integer fieldCount = [SELECT count() FROM Case_View_Fields__c WHERE Case_View_Object__c = :x360Object.Id];
        
        if (fieldCount > 9) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, GENERIC_ERROR + ' Maximum of 9 fields can be added per object.'));
            return null;
        }
        
        if (x360Fields.isEmpty()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
            Case_View_Fields__c x360Field = new Case_View_Fields__c(
                                                Case_View_Object__c = x360Object.Id,
                                                Field__c = fieldName,
                                                Label__c = fieldDescribe.getLabel(),
                                                Name = sortOrder);
            //insert x360Field;
            Database.SaveResult sr = Database.insert(x360Field);
            if(!sr.isSuccess()){
                String errorMsgs = '';
                for(Database.Error err : sr.getErrors()){
                    errorMsgs += err.getMessage();
                }//END for(Database.Error err : sr.getErrors())
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, GENERIC_ERROR + errorMsgs));
                system.debug('=> Error on save(): '+ errorMsgs);
                return null;
            }
            objectName = '--None--';
            sortOrder = '';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Case view successfully updated.'));
            return new PageReference('/apex/'+ 'Setup360View' );//PageReference('/'+ x360Field.id);
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, GENERIC_ERROR + ' 360 Field is already added.'));
            return null;
        }  
    
        
    }
    
    public pageReference cancel() {
       return null;
    }
}