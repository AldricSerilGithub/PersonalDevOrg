@isTest
private class LoginTime_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Login__c login_Obj = new Login__c();
    Insert login_Obj; 
    test.stopTest();
  }
  static testMethod void test_gettotalOT_UseCase1(){
    List<Login__c> login_Obj  =  [SELECT Id from Login__c];
    System.assertEquals(true,login_Obj.size()>0);
    LoginTime obj01 = new LoginTime(new ApexPages.StandardController(login_Obj[0]));
    obj01.po = login_Obj;
    //j01.Today = Date.today();
    obj01.IsLogin = false;
    obj01.IsLogout = false;
    obj01.gettotalOT();
  }
  static testMethod void test_gettotalUT_UseCase1(){
    List<Login__c> login_Obj  =  [SELECT id from Login__c];
    System.assertEquals(true,login_Obj.size()>0);
    LoginTime obj01 = new LoginTime(new ApexPages.StandardController(login_Obj[0]));
    obj01.po = login_Obj;
    //obj01.Today = Date.today();
    obj01.IsLogin = false;
    obj01.IsLogout = false;
    obj01.gettotalUT();
  }
  static testMethod void test_gettotalTBO_UseCase1(){
    List<Login__c> login_Obj  =  [SELECT id from Login__c];
    System.assertEquals(true,login_Obj.size()>0);
    LoginTime obj01 = new LoginTime(new ApexPages.StandardController(login_Obj[0]));
    obj01.po = login_Obj;
    //obj01.Today = Date.today();
    obj01.IsLogin = false;
    obj01.IsLogout = false;
    obj01.gettotalTBO();
  }
}