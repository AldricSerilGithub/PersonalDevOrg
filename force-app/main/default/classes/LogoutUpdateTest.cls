@isTest(SeeAllData=true) 
public class LogoutUpdateTest {

     static testMethod void LogoutUpdate(){

         Test.startTest(); 
       	
        PageReference pageRef = Page.table;
        Test.setCurrentPage(pageRef);
        
        LogoutUpdate Logout = new LogoutUpdate(null);
        Logout.Gener();
        Logout.Lout();
     }    
}