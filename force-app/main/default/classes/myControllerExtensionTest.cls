@isTest(SeeAllData=true) 
public class myControllerExtensionTest {

    
    static testMethod void myControllerExtensionTest() {
		Test.startTest(); 
       
        
        myControllerExtension Launch = new myControllerExtension(null);
     	Launch.Custom();
        
        Account accnt = [SELECT Name FROM Account where Id ='001o0000005xsBB'];
        Launch.Accts();
        Launch.camps();
        Launch.cases();
        Launch.contaks();
        Launch.Leas();
        Launch.Oppors();
        
       	PageReference pageref = new PageReference('/apex/AccountPage?aId=' + accnt.Id);
    	Test.setCurrentPage(pageRef);
        test.stopTest();
    
    }
    
  
    
   
}