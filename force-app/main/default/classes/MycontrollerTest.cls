@isTest(SeeAllData=true) 
public class MycontrollerTest {

      static testMethod void LaunchV2Test() {
              
        Account accnt = [SELECT Name FROM Account where Id ='001o0000005xsBB'];
        
	    Test.startTest(); 
        PageReference pageRef = Page.LaunchV2;
        pageRef.getParameters().put('Id', accnt.id);
        Test.setCurrentPage(pageRef);
       
        Mycontroller Launch = new Mycontroller();
     	Launch.expdf();
        
        List<Opportunity> Oppor = [SELECT Name,StageName,Amount,CloseDate FROM Opportunity where Account.Id =: accnt.id];
        Test.stopTest();
    }
    
    static testMethod void LaunchV2Test2() {
              
        Contact Cntct = [SELECT Name FROM Contact where Id ='003o0000005Ni6A'];
        
	    Test.startTest(); 
        PageReference pageRef = Page.LaunchV2;
        pageRef.getParameters().put('Id', Cntct.id);
        Test.setCurrentPage(pageRef);
       
        Mycontroller Launch = new Mycontroller();
        Launch.expdf();
        
        List<Case> casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Contact.Id = :Cntct.Id ];
         Test.stopTest();
    }
	
    
   
}