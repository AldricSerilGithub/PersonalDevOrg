@isTest(SeeAllData=true) //this is to access custom settings
private class Setup360ViewController_IsTest {
    /*
        Created By: Accenture -  Kathleen Gutierrez
        Created On: 11/5/2013
        Purpose   : Test class for Setup360ViewController 
        --------------------------------------------------------------------------
        Modified By: 
        Modified On:  
        Modification: 
    */
    static User usrTest;

    static testMethod void Setup360ViewControllerTest() {

   initTest();

        Test.startTest();
        system.runAs(usrTest){
        
        PageReference pageRef = Page.Setup360View;
            Test.setCurrentPage(pageRef);
        Setup360ViewController cntrlr = new Setup360ViewController();
        
        cntrlr.getobjects();
        cntrlr.objectName = 'CaseShare';
        cntrlr.getDateFields();
        cntrlr.dateFieldName = 'LastModifiedDate';
        cntrlr.getCaseFields();
        cntrlr.caseFieldName = 'CaseId';
        cntrlr.getfields();
        cntrlr.fieldName = 'RowCause';
        cntrlr.sortOrder = '1';
        cntrlr.save360Field();
        
        cntrlr.getobjects();
        cntrlr.objectName = 'CaseShare';
        cntrlr.getDateFields();
        cntrlr.dateFieldName = 'LastModifiedDate';
        cntrlr.getCaseFields();
        cntrlr.caseFieldName = 'CaseId';
        cntrlr.getfields();
        cntrlr.fieldName = 'UserOrGroupId';
        cntrlr.sortOrder = '2';
        cntrlr.save360Field();
        
        cntrlr.getobjects();
        cntrlr.objectName = 'CaseComment';
        cntrlr.getDateFields();
        cntrlr.dateFieldName = 'LastModifiedDate';
        cntrlr.getCaseFields();
        cntrlr.caseFieldName = 'ParentId';
        cntrlr.getfields();
        cntrlr.fieldName = 'CommentBody';
        cntrlr.sortOrder = '1';
        cntrlr.save360Field();
            
            
            
            
        cntrlr.cancel();
        cntrlr.getSelectedObjects();

    }//End of system.runAs(usrTest)
    Test.stopTest();

    }//End of Setup360ViewControllerTest

    
    static testMethod void Setup360ViewControllerTest1() {
   		initTest();
        Test.startTest();
        system.runAs(usrTest){        
        PageReference pageRef = Page.Setup360View;
            Test.setCurrentPage(pageRef);
        Setup360ViewController cntrlr = new Setup360ViewController();
        
        cntrlr.getobjects();
        cntrlr.objectName = '--None--';
        cntrlr.getDateFields();
        cntrlr.dateFieldName = null;
        cntrlr.getCaseFields();
        cntrlr.caseFieldName = null;
        cntrlr.getfields();
        cntrlr.fieldName = null;
        cntrlr.sortOrder = ' ';
        cntrlr.save360Field();
            
        cntrlr.cancel();
        cntrlr.getSelectedObjects();

    }//End of system.runAs(usrTest)
    Test.stopTest();

    }//End of Setup360ViewControllerTest


    static testMethod void Setup360ViewControllerTest2() {
   		initTest();
        Test.startTest();
        system.runAs(usrTest){        
        PageReference pageRef = Page.Setup360View;
            Test.setCurrentPage(pageRef);
        Setup360ViewController cntrlr = new Setup360ViewController();
        
        cntrlr.getobjects();
        cntrlr.objectName = 'ActivityHistory';
        cntrlr.getDateFields();
        cntrlr.dateFieldName = 'LastModifiedDate';
        cntrlr.getCaseFields();
        cntrlr.caseFieldName = 'ParentId';
        cntrlr.getfields();
        cntrlr.fieldName = 'AccountID';
        cntrlr.sortOrder = '1';
        cntrlr.save360Field();
        cntrlr.cancel();
        cntrlr.getSelectedObjects();

    }//End of system.runAs(usrTest)
    Test.stopTest();

    }//End of Setup360ViewControllerTest
   
    
    private static void initTest() {

        //test User - User of this page will only be admins that will 
        //configure what fields will be shown on Launch360View page
        
        Profile p = [select id 
                            from 
                            Profile 
                            where 
                            name='System Administrator'];
        
        
        usrTest = new User(
                     alias = 'testuser', 
                     email = 'testInsert@salesforce.com', 
                     emailencodingkey = 'UTF-8', 
                     firstname = 'Insert', 
                     lastname = 'Tester', 
                     languagelocalekey = 'en_US', 
                     localesidkey = 'en_US', 
                     profileid = p.id,//CS_Key_IDs__c.getInstance('CTXS_System Administrator').Record_ID__c, 
                     timezonesidkey = 'America/Los_Angeles', 
                     username = 'testInsert@salesforce.com');
    }//End of initTest
  }//End of Setup360ViewController_IsTest