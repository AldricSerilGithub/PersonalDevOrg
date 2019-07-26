/*
 * Name: caseTriggerTest
 * @description: test class for ticket creation
 * Created by: John Aldric Seril
 * Created date: 23-Oct-2015
 */ 

@isTest
private class caseTriggerTest {
    
static testMethod void createCase(){
	MaxCaseCount__c mc = new MaxCaseCount__c(Max_Case__c = 100);
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    User u = new User(Alias = 'test123', Email='testuser123@testorg.com', 
                      EmailEncodingKey='UTF-8', LastName='Test User', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, case_count__c = 100,
                      TimeZoneSidKey='America/Los_Angeles', UserName='testuser123@testorg.com');
	insert mc;
    Test.startTest();
    try
    {
        system.runAs(u)
        {
            Case c = new Case(Subject = 'TestCase', Origin = 'Email');
            insert c;
        }
    }
    catch(Exception e)
    {
        system.assert(e.getMessage().contains('Too many case created for user ' + u.LastName), 'message=' + e.getMessage());
        
    }
    Test.stopTest();
	}
}