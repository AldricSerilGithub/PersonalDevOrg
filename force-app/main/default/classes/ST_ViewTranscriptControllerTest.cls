@isTest
private class ST_ViewTranscriptControllerTest {

    static testMethod void myUnitTest() {
        String eid;
        Boolean isValidTranscript;
        String nextPage, assessmentId;
        
        ExamSet__c examSet = new ExamSet__c(
                    Name = 'Survey Questionnaire',
                    Duration__c = 500,
                    ItemCount__c = 60);
        insert examSet;
        
        Transcript__c transcript = new Transcript__c(
                        Survey_Type__c = 'Survey Questionnaire',
                        Email__c = 'john.aldric.s.seril@accenture.com',
                        TokenCode__c = ST_AssessmentUtils.generateCode());
        insert transcript;
        Assessment__c assessment = new Assessment__c(
                        Transcript__c = transcript.Id,
                        Exam_Set__c = examSet.Id);
        insert assessment;

        List<Question__c> questionList = new List<Question__c>();

        for(Integer x = 1; x <= 60; x++) {
            Question__c question = new Question__c(
                        ExamSet__c = examSet.Id
                        );
            questionList.add(question);
        }
        insert questionList;
 
        Profile profile = [SELECT Id FROM Profile WHERE Name='System Administrator' limit 1];/*Custom: SaaS Assessments2*/
        User user = new User(
                        Alias = 'try',
                        Email = 'portalTester@assmt.com', 
                        EmailEncodingKey = 'UTF-8',
                        LastName = 'Tester',
                        LanguageLocaleKey = 'en_US',
                        LocaleSidKey = 'en_US',
                        ProfileId = profile.Id,
                        TimeZoneSidKey = 'America/Los_Angeles',
                        UserName = 'portalTester@assmt.com');
        insert user;
        eid = (transcript.Email__c).substring(0,(transcript.Email__c).indexOf('@'));
        System.runAs(user) {
            /*
             * Initialize the page with invalid 'eid' and 'tc' parameters
             */
            PageReference currentPage = Page.ST_ViewTranscript;
            Test.setCurrentPage(currentPage);
            ApexPages.currentPage().getParameters().put('tc', 'thisIsAnInvalidTokenCOde');
            ApexPages.currentPage().getParameters().put('eid', 'test@invalidEmail.com');
            ApexPages.currentPage().getParameters().put('aid', assessment.Id);
            ApexPages.standardController stdController = new ApexPages.standardController(transcript);
            ST_ViewTranscriptController controller = new ST_ViewTranscriptController(stdController);
            System.assertEquals('/ST_TokenInvalid', controller.checkTokenCode().getUrl());
            System.assertEquals(false, controller.getIsValidTranscript());
            /*
             * Initialize the page with VALID 'eid' and 'tc' parameters
             */
            PageReference currentPage2 = Page.ST_ViewTranscript;
            Test.setCurrentPage(currentPage2);
            ApexPages.currentPage().getParameters().put('tc', transcript.TokenCode__c);
            ApexPages.currentPage().getParameters().put('eid', eid);
            ApexPages.currentPage().getParameters().put('aid', assessment.Id);
            stdController = new ApexPages.standardController(transcript);
            controller = new ST_ViewTranscriptController(stdController);
            System.assertEquals(null, controller.checkTokenCode());
            System.assertEquals(true, controller.getIsValidTranscript());
            controller.getTranscript();
            controller.getAssessment();
            controller.setTranscript(transcript);
          	controller.getAssessment();
            controller.getImportLink();
            controller.getSurveyOptions();
            controller.getSurveyTakerLink();
            controller.getUpdateLink(); 
            controller.selectedSurvey = 'Survey Questionnaire';
            
            Transcript__c transcript2 = new Transcript__c (
            Email__c='test@accenture.com',
            TokenCode__c='123'             
          ); 
          insert transcript2; 
          
          nextPage = controller.launchExam().getUrl();
	      
          System.assertEquals('/SurveyTool/ST_TakeAssessment?eid='+eid+'&id=' + assessment.Id + '&tc=' + transcript.TokenCode__c, nextPage);
        }
    }
    
    
    static testMethod void myUnitTest2() {
        String eid;
        Boolean isValidTranscript;
        String nextPage, assessmentId;
        
        ExamSet__c examSet = new ExamSet__c(
                    Name = 'Survey Questionnaire',
                    Duration__c = 500,
                    ItemCount__c = 60);
        insert examSet;
        
        Transcript__c transcript = new Transcript__c(
                        Survey_Type__c = 'Survey Questionnaire',
                        Email__c = 'john.aldric.s.seril@accenture.com',
                        TokenCode__c = ST_AssessmentUtils.generateCode());
        insert transcript;
        
        List<Question__c> questionList = new List<Question__c>();

        for(Integer x = 1; x <= 60; x++) {
            Question__c question = new Question__c(
                        ExamSet__c = examSet.Id
                        );
            questionList.add(question);
        }
        insert questionList;
 
        Profile profile = [SELECT Id FROM Profile WHERE Name='System Administrator' limit 1];/*Custom: SaaS Assessments2*/
        User user = new User(
                        Alias = 'try',
                        Email = 'portalTester@assmt.com', 
                        EmailEncodingKey = 'UTF-8',
                        LastName = 'Tester',
                        LanguageLocaleKey = 'en_US',
                        LocaleSidKey = 'en_US',
                        ProfileId = profile.Id,
                        TimeZoneSidKey = 'America/Los_Angeles',
                        UserName = 'portalTester@assmt.com');
        insert user;
        eid = (transcript.Email__c).substring(0,(transcript.Email__c).indexOf('@'));
        System.runAs(user) {
            /*
             * Initialize the page with VALID 'eid' and 'tc' parameters
             */
            PageReference currentPage2 = Page.ST_ViewTranscript;
            Test.setCurrentPage(currentPage2);
            ApexPages.currentPage().getParameters().put('tc', transcript.TokenCode__c);
            ApexPages.currentPage().getParameters().put('eid', eid);
            //ApexPages.currentPage().getParameters().put('aid', assessment.Id);
            ApexPages.standardController stdController = new ApexPages.standardController(transcript);
            stdController = new ApexPages.standardController(transcript);
            ST_ViewTranscriptController controller = new ST_ViewTranscriptController(stdController);
            controller = new ST_ViewTranscriptController(stdController);
            System.assertEquals(null, controller.checkTokenCode());
            System.assertEquals(true, controller.getIsValidTranscript());
            controller.getTranscript();
            controller.getAssessment();
            controller.setTranscript(transcript);
          	controller.getAssessment();
            controller.getImportLink();
            controller.getSurveyOptions();
            controller.getSurveyTakerLink();
            controller.getUpdateLink(); 
            controller.selectedSurvey = 'Survey Questionnaire';
            
                     
          nextPage = controller.launchExam().getUrl();
	      
          //System.assertEquals('/SurveyTool/ST_TakeAssessment?eid='+eid+'&id=' + assessment.Id + '&tc=' + transcript.TokenCode__c, nextPage);
        }
    }
}