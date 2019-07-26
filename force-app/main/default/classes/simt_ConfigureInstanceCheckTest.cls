@istest
private class simt_ConfigureInstanceCheckTest {
    
    static testMethod void Test1(){ 
        Test.startTest();
        
        simt_ConfigureInstanceCheckController CICC = new simt_ConfigureInstanceCheckController();
        
        
        CICC.selectedEmailAddresses = new List<String>{'sample1@sample.com','sample2@sample.com'};
        
        simt_instance__c inst = new simt_instance__c(name='test',active__c=true);
    insert inst;
        
        CICC.instanceValue = 'test1,test2';
        List<String> instanceList = new List<String>{'test'};
        Set<String> instanceSet = new Set<String>{'test1','test2'};
        CICC.addInstance();
        
        
        CICC.instanceValue = 'test1,test2';
        List<String> instanceList2 = new List<String>{'test'};
        Set<String> instanceSet2 = new Set<String>{'test1','test2'};
        Set<String> tempInstance = new Set<String>{'test1','test2'};
        CICC.removeInstance();
        
        CICC.addEmail();
        
        
        CICC.emailAddToBeRemoved = 'test1,test2';
        List<String> newEmailSelection = new List<String>();
        CICC.removeEmail();
        
        Map<String, simt_emailAddresses__c> mail = new Map<String, simt_emailAddresses__c>();
        mail.put('sample1@sample.com', new simt_emailAddresses__c(Name='sample1@sample.com'));
        upsert mail.values() name;
        
        List<simt_emailAddresses__c> removeEmail = new List<simt_emailAddresses__c>();
        Map<String, String> delMail = new Map<String, String>();   
        CICC.selectedEmailAddresses = new List<String>{'sample1@sample.com','sample2@sample.com'};        
    CICC.saveInfo();
        
        simt_InstanceStatusCheckScheduler intChk = new simt_InstanceStatusCheckScheduler();
        System.schedule('InstanceStatusCheckAt0','0 0 * * * ?',intChk);
        System.schedule('InstanceStatusCheckAt15','0 15 * * * ?',intChk);
        System.schedule('InstanceStatusCheckAt30','0 30 * * * ?',intChk);
        System.schedule('InstanceStatusCheckAt45','0 45 * * * ?',intChk);
        CICC.stopInstanceChecker();
        
        Test.stopTest();
    } 
    

    static testMethod void test2(){
        Test.StartTest();
        simt_ConfigureInstanceCheckController CICC = new simt_ConfigureInstanceCheckController();
        //CICC.runInstanceChecker();
        Test.stopTest();
    }

}