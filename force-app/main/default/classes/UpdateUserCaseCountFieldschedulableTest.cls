/*
 * Name: UpdateUserCaseCountFieldschedulableTest
 * @description: test class for UpdateUserCaseCountFieldschedulable
 * Created By: John Aldric Seric
 * Created Date: 23-Oct-2015 
 */ 

@isTest
private class UpdateUserCaseCountFieldschedulableTest {

    static testMethod void myUnitTest() {
            Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
            User u = new User(Alias = 'testuser', Email='testuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, case_count__c = 10,
            TimeZoneSidKey='America/Los_Angeles', UserName='testuser@testorg.com');
        
            Test.startTest();
                    String CRON_EXP = '0 0 0 1 1 ? 2025';  
                    String jobId = System.schedule('testScheduledApex', CRON_EXP, new UpdateUserCaseCountFieldschedulable() );

                    CronTrigger ct = [select id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id = :jobId];

                    System.assertEquals(CRON_EXP, ct.CronExpression); 
                    System.assertEquals(0, ct.TimesTriggered);
                    System.assertEquals('2025-01-01 00:00:00', String.valueOf(ct.NextFireTime));
            Test.stopTest();
    }
}