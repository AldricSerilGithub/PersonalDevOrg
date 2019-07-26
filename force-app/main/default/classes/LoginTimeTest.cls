@isTest(SeeAllData=true) 
public class LoginTimeTest {

  /*  static testMethod void LoginTime(){

        List<Login__c> po = new List<Login__c>();        
        
        for(integer a=0;a<10;a++)
        {
        Login__c poa = new Login__c( Timein__c=datetime.newInstance(2008, 12, 1, 12, 30, 1));
        po.add(poa);
        }
       	
        Test.startTest(); 
       	insert po;
		
        PageReference pageRef = Page.table;
        pageRef.getParameters().put('Id', po[0].Id);
		Test.setCurrentPage(pageRef);
        
        LoginTime Login = new LoginTime(null);
        Login.gettotalOT();
        Login.gettotalTBO();
        Login.gettotalUT();
        
        
        List<Login__c> insertedLogins = [SELECT Date_of_Time_Out__c,Date_of_Time_In__c,Time_of_Time_Out__c,Time_of_Time_In__c,Timeout__c,Timein__c,Total_Hours__c,Status__c,Over_Time__c,Under_Time__c FROM Login__c WHERE ownerID = :po[0].ownerID ];		
        Integer but = [SELECT count()FROM Login__c WHERE ownerID =: po[0].ownerID and Timeout__c=null LIMIT 1]; 
        SObject totalOT = [SELECT SUM(Over_Time__c) OT FROM Login__c WHERE ownerID =:po[0].ownerId];
      	SObject totalUT = [SELECT SUM(Under_Time__c) UT FROM Login__c WHERE ownerID =:po[0].ownerId];
        SObject totalTBO = [SELECT SUM(Over_Time__c) OT,SUM(Under_Time__c) UT FROM Login__c WHERE ownerID =:po[0].ownerId];
        
        for(Login__c e : insertedLogins)
        { 
        System.assertEquals('Over Time',e.Status__c);
        System.assertNotEquals(0,but);
        }
        test.stopTest();
    }
 
    */
    static testMethod void LoginTimes(){
        Test.startTest(); 
        PageReference pageRef = Page.table;
	    Test.setCurrentPage(pageRef);
        
        LoginTime Login = new LoginTime(null);
        Login.gettotalOT();
        Login.gettotalTBO();
        Login.gettotalUT();
        Integer but = 0;//[SELECT count()FROM Login__c WHERE ownerID =: pos[0].ownerID and Timeout__c=null  LIMIT 1]; 
        //System.assertEquals(0,but);
        test.stopTest();
    }
    
       
}