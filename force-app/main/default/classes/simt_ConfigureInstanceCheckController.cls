public class simt_ConfigureInstanceCheckController {
    public List<String> instanceList {get; set;}
    public String emailAdd {get; set;}
    public String instanceValue {get; set;}
    public List<String> instanceList2 {get; set;}
    public Set<String> instanceSet {get; set;}
    public Boolean isStarted {get; set;}
    public String emailAddToBeRemoved {get; set;}
    public List<String> selectedEmailAddresses {get; set;}
    public List<simt_emailAddresses__c> emailAddresses = new List<simt_emailAddresses__c>();
    public List<simt_instance__c> instance = new List<simt_instance__c>();
    public simt_instance__c ins = new simt_instance__c();
    
    public  simt_ConfigureInstanceCheckController(){
        generateInstanceList();
        checkIfStarted();
        selectedEmailAddresses = new List<String>();
        List<CronTrigger> jobList = [Select Id, CronExpression, CronJobDetailId From CronTrigger];
        
        emailAddresses = [Select Name From simt_emailAddresses__c];
        
        for(simt_emailAddresses__c EA: emailAddresses){
           selectedEmailAddresses.add(EA.Name);
        }
    }
    private void generateInstanceList(){
        instanceList = new List<String>();
        instanceList2 = new List<String>();
        
        instance = [SELECT Name, Active__c From simt_instance__c];
        
        for(simt_instance__c inst : instance){
            
            if(!inst.Active__c){
              instancelist.add(inst.Name);
            }else{
              instanceList2.add(inst.Name);
            }
            
        }
        instanceList.sort();
        instanceList2.sort();        
    }
    

    public void addInstance(){
        List<String> instanceVal = instanceValue.split(',');
        instanceSet = new Set<String>();
        Set<String> tempInstance = new Set<String>();
        for(String s:instanceVal){
            instanceSet.add(s);
        }
        
        tempInstance.addAll(instanceList);
        instanceList.clear();
        tempInstance.removeAll(instanceSet);
        instanceList.addAll(tempInstance);
        List<simt_instance__c> ins = [Select Name, Active__c from simt_instance__c where Name IN :instanceSet];
        
        for(simt_instance__c i:ins){
            i.Active__c = True; 
            instanceList2.add(i.Name);
        }
              
        instanceList.sort();
        instanceList2.sort();
    }
    
    public void removeInstance(){
        system.debug(instanceList2);
        List<String> instanceVal = instanceValue.split(',');
        Set<String> instanceSet = new Set<String>();
        Set<String> tempInstance = new Set<String>();
        
        for(String s:instanceVal){
            instanceSet.add(s);
        }
        
        tempInstance.addAll(instanceList2);
        instanceList2.clear();
        tempInstance.removeAll(instanceSet);
        instanceList2.addAll(tempInstance);
        
        List<simt_instance__c> ins = [Select Name, Active__c from simt_instance__c where Name IN :instanceSet];
    
        for(simt_instance__c i:ins){
            i.Active__c = False; 
            instanceList.add(i.Name);
        }
       
        instanceList.sort();
        instanceList2.sort();
    }
    
    public void checkIfStarted(){
        List<CronJobDetail> cronList = [SELECT Id, Name, JobType FROM CronJobDetail Where Name Like 'InstanceStatusCheck%'];
        if(cronList.isEmpty()){
            isStarted = false;
        }else{
            isStarted = true;
        }
    }
    
    public void addEmail(){
        Integer count = 0;         
        for(String emails : selectedEmailAddresses){
            if(emails.equalsIgnoreCase(emailAdd)){
                count++;
            }
        } 
        
        if(count<1){
            selectedEmailAddresses.add(emailAdd);
        }
        
    }
    public void removeEmail(){
        List<String> newEmailSelection = new List<String>();
        for(String em:selectedEmailAddresses){
            if(!emailAddToBeRemoved.equalsIgnoreCase(em)){
                newEmailSelection.add(em);
            }
        }
        selectedEmailAddresses = newEmailSelection;
        
    }
    public void runInstanceChecker(){
        system.debug(instanceList2);
        simt_InstanceStatusCheckScheduler instanceSchedulable = new simt_InstanceStatusCheckScheduler();
        System.schedule('InstanceStatusCheckAt0','0 0 * * * ?',instanceSchedulable);
        System.schedule('InstanceStatusCheckAt15','0 15 * * * ?',instanceSchedulable);
        System.schedule('InstanceStatusCheckAt30','0 30 * * * ?',instanceSchedulable);
        System.schedule('InstanceStatusCheckAt45','0 45 * * * ?',instanceSchedulable);
        isStarted = true;
        generateInstanceList();

    }
    public void stopInstanceChecker(){
        List<CronTrigger> cronList = [SELECT Id FROM CronTrigger Where CronJobDetail.Name Like 'InstanceStatusCheck%'];
        try{
            for(CronTrigger ct:cronList){
                system.abortJob(ct.id);
            }
            isStarted = false;
            generateInstanceList();
        }catch(Exception ex){
        
        }
    }
    
    public void saveInfo(){
        
        if(selectedEmailAddresses.size()>0){

           Map<String, simt_emailAddresses__c> mail = new Map<String, simt_emailAddresses__c>();
           
           for(String EmailAd : selectedEmailAddresses){
                mail.put(EmailAd,new simt_emailAddresses__c (Name = EmailAd));  
           }
           upsert mail.values() Name;            
        }  
          
        if(selectedEmailAddresses.size()>=0){
          
           List<simt_emailAddresses__c> removeEmail = new List<simt_emailAddresses__c>();           
           Map<String, String> delMail = new Map<String, String>(); 
           
           for(String emaila : selectedEmailAddresses){
               delMail.put(emaila,emaila);
           }
           
           for(simt_emailAddresses__c EmailAd : [Select Name from simt_emailAddresses__c]){
               if(!delMail.containsKey(EmailAd.Name)){
                   removeEmail.add(Emailad);         
               } 
           }
           delete removeEmail; 
        }
        
           List<simt_instance__c> insList = new List<simt_instance__c>();           
           Map<Id, simt_instance__c> instamap = new Map<Id, simt_instance__c>(); 
           Set<String> tempInstance = new Set<String>();
           tempInstance.addAll(instanceList);
         
            for(simt_instance__c insta : [Select Id, Name From simt_instance__c]){
                instamap.put(insta.Id, insta);
                if(tempInstance.contains(instamap.get(insta.Id).Name)){
                    insta.active__c = False;
                } 
                else{
                    insta.active__c = True;
                } 
            }
            update instamap.values();
           
            generateInstanceList();

        ApexPages.addMessage(new APexPages.Message(ApexPages.severity.CONFIRM, 'Changes successfully saved.'));
         
    }
    
    
}