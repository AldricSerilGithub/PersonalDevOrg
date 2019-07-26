@isTest(seeAllData=true)
public class SsampleDetailPageConTest {

    static testMethod void SampleDetailPageConTest() {
       Test.startTest();
        PageReference pageRef = Page.try;
        Test.setCurrentPage(pageRef);
        
         Account accnt = [SELECT Name FROM Account where Id ='001o0000005xsBB'];
        Contact contak = [SELECT Name,Department,LeadSource,Title FROM Contact WHERE ID='003o0000005Ni6A'];
       
        ApexPages.StandardController sc = new ApexPages.standardController(contak);
        
              SampleDetailPageCon Launch = new SampleDetailPageCon(sc);
     	Launch.getOppz();
        Test.stopTest();
    
    }
    
    
    static testMethod void SampleDetailPageConTest2() {
       Test.startTest();
        PageReference pageRef = Page.try;
        Test.setCurrentPage(pageRef);
        
         Account accnt = [SELECT Name FROM Account where Id ='001o0000005xsBB'];
        Contact myContact = new Contact (FirstName='Joe',LastName='Schmoe');
		insert myContact;
        
        ApexPages.StandardController sc = new ApexPages.standardController(myContact);
        
              SampleDetailPageCon Launch = new SampleDetailPageCon(sc);
     	Launch.getOppz();
        Test.stopTest();
    
    }
    
    
}