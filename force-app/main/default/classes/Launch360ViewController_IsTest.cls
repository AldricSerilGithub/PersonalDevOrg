@isTest(SeeAllData=true)
   //SeeAllData used to gain access to the Custom Settings Values
private class Launch360ViewController_IsTest {

    /*
        Created By: Accenture - Kathleen Gutierrez    
        Created On: 11/5/2013
        Purpose   : Test class for Launch360ViewController.
        --------------------------------------------------------------------------
        Modified By: Accenture - John Aldric Seril
        Modified On: 12/22/2014
        Modification: 
    */

    static User usrTest;
   	static Case CaseItem;
	
    static testMethod void Launch360ViewControllerTest() {
        initTest();
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
        
       
        
        System.runAs(usrTest) {
            Test.startTest();
            initRecords();
            PageReference pageRef = Page.Launch360View;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', caseItem.Id);//ca_1.Id);
            Launch360ViewController cntrlr = new Launch360ViewController();
            cntrlr.backToCase();
            cntrlr.exportToPDF(); 
            cntrlr.getPageSize();
            cntrlr.getShowPagination();
           
            cntrlr.previous();
            cntrlr.next();
            cntrlr.toggleSinglePage();
            cntrlr.refreshList();
            cntrlr.first();
			
           System.assertEquals(1, cntrlr.getCurrentPage());
            
            if(cntrlr.getIsNotLastPage()) {
                System.assert(cntrlr.hasNext);
                cntrlr.next();
            }//END if(cntrlr.getIsNotLastPage())
            
            cntrlr.last();
            System.assertEquals(cntrlr.getLastPage(), cntrlr.getCurrentPage());

            if(cntrlr.getIsNotFirstPage()) {
                System.assert(cntrlr.hasPrevious);
                cntrlr.previous();
            }//END if(cntrlr.getIsNotFirstPage())
            
            System.assert(cntrlr.sObjectList.size() > 0);
           
            ApexPages.currentPage().getParameters().put('id', p.Id);//ca_2.Id);
            cntrlr.refreshList();
            cntrlr.backToCase();
            cntrlr.exportToPDF();
            Test.stopTest();     
        }//END System.runAs(usrTest)
    }//END Launch360ViewControllerTest

    static Case_View_Object__c getTestObj360(String obj, String cas, String dat) {
        Case_View_Object__c obj360 = new Case_View_Object__c(
                            Name = obj,
                            Label__c = obj,
                            Related_Case_Field__c = cas,
                            Sort_By_Date_Label__c = dat,
                            Sort_By_Date_Field__c = dat);

        return obj360;
    } // END getTestObj360()
    
    static Case_View_Fields__c getTestField360(Id objId, String fld) {
        Case_View_Fields__c field360 = new Case_View_Fields__c(
                            Case_View_Object__c = objId,
                            Field__c = fld,
                            Label__c = fld,
                            Name = '1'); 

        return field360;
    } // END getTestField360()

    static void initTest() {
        List<Case_View_Object__c> obj360List = new List<Case_View_Object__c>{

            getTestObj360('Task', 'WhatId', 'CreatedDate'),
            getTestObj360('CaseComment', 'ParentId', 'CreatedDate'),
            getTestObj360('CaseHistory', 'CaseId', 'CreatedDate')
        }; //END obj360List

        Database.insert(obj360List);
        
        List<Case_View_Fields__c> field360List = new List<Case_View_Fields__c>{
            getTestField360(obj360List[0].Id, 'Subject'),
            getTestField360(obj360List[1].Id, 'CommentBody'),
            getTestField360(obj360List[2].Id, 'Field')
        };

        Database.insert(field360List);

    }//END static void initTest() {

    
    static void initrecords(){
        List<sObject> genObjectList = new List<sObject>();
        string strRT = 'Suspect Account';
        string strStatus = 'Suspect';
       
        Account acct = new Account(
            Name = 'test', 
            BillingStreet='851 Cypress Creek Rd',
            BillingCity = 'Fort Lauderdale',
            BillingPostalCode = '33309'
            );
        insert acct;
        
        Contact cont = new Contact(
                AccountId = acct.Id,
                FirstName = 'FirstName' + string.valueOf(0),
                LastName = 'LastName' + string.valueOf(0),
               email = 'FirstName' + string.valueOf(0) + '.LastName' + string.valueOf(0) + '@test-citrix.com',
                MailingStreet = acct.BillingStreet,
                MailingCity = acct.BillingCity,
                MailingPostalCode = acct.BillingPostalCode
                );
        insert cont;
        
        
        caseItem = new Case(
                AccountId = acct.ID,
                ContactId = cont.ID
                );
        insert caseItem;
        
        caseItem.status = 'Approved';
        update caseItem;
        
        
        Case child = caseItem.clone();
        child.ParentId = caseItem.Id;
        insert child; 
        
        for (Integer i = 0; i < 10; i++) {
            genObjectList.add(new CaseComment(ParentId = caseItem.Id, CommentBody = 'This is another task.'));
            genObjectList.add(new CaseComment(ParentId = child.Id, CommentBody = 'This is another task.'));
        }
        //insert new List<CaseComment>{ cs1, cs2};
        
        //Create activities for the two cases. These must all be retrieved by the page.
        Task t1 = new Task(Subject = 'This is a test.', WhatId = caseItem.Id);
        genObjectList.add(t1);
        Task t2 = t1.clone();
        t2.Status = 'Completed';
        genObjectList.add(t2);
        Task t3 = new Task(Subject = 'This is a test.', WhatId = child.Id);
        genObjectList.add(t3);
        Task t4 = t3.clone();
        t4.Status = 'Completed';
        genObjectList.add(t4);
        //insert new List<Task> { t1, t2, t3, t4 };
        Database.insert(genObjectList);
       
    } 
    
}//End Launch360ViewController_IsTest