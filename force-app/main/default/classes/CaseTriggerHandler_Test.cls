@isTest
private class CaseTriggerHandler_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Case case_Obj = new Case(IsEscalated = false);
    Insert case_Obj; 
    test.stopTest();
  }
  static testMethod void test_OnBeforeInsert_UseCase1(){
    List<Case> case_Obj  =  [SELECT IsEscalated from Case];
    System.assertEquals(true,case_Obj.size()>0);
    CaseTriggerHandler obj01 = new CaseTriggerHandler();
    CaseTriggerHandler.OnBeforeInsert(case_Obj);
  }
  static testMethod void test_OnAfterInsert_UseCase1(){
    List<Case> case_Obj  =  [SELECT IsEscalated from Case];
    System.assertEquals(true,case_Obj.size()>0);
    CaseTriggerHandler obj01 = new CaseTriggerHandler();
    CaseTriggerHandler.OnAfterInsert(case_Obj);
  }
  static testMethod void test_OnAfterUpdate_UseCase1(){
    List<Case> case_Obj  =  [SELECT IsEscalated from Case];
    System.assertEquals(true,case_Obj.size()>0);
    CaseTriggerHandler obj01 = new CaseTriggerHandler();
    CaseTriggerHandler.OnAfterUpdate(case_Obj,case_Obj);
  }
  static testMethod void test_OnBeforeUpdate_UseCase1(){
    List<Case> case_Obj  =  [SELECT IsEscalated from Case];
    System.assertEquals(true,case_Obj.size()>0);
    CaseTriggerHandler obj01 = new CaseTriggerHandler();
    CaseTriggerHandler.OnBeforeUpdate(case_Obj,case_Obj);
  }
  static testMethod void test_checkChildStatus_UseCase1(){
    List<Case> case_Obj  =  [SELECT IsEscalated from Case];
    System.assertEquals(true,case_Obj.size()>0);
    CaseTriggerHandler obj01 = new CaseTriggerHandler();
    CaseTriggerHandler.checkChildStatus(case_Obj);
  }
}