@isTest
private class ST_ViewAssessmentControllerTest {
     
    static testMethod void myUnitTest() {
        Boolean isAdded;
        List<Question__c> questionList = new List<Question__c>();
        List<Answer__c> testAnswerList = new List<Answer__c>();
        String eid;
        PageReference currentPage;
        ApexPages.standardController stdController;
        ST_ViewAssessmentController assessmentTestController;
        Transcript__c testtranscript = new Transcript__c(
                        Examinee_Type__c = 'CAMS',
                        Email__c = 'dianne.i.g.castillo@accenturefederal.com',
                        TokenCode__c = ST_AssessmentUtils.generateCode());
        insert testtranscript;
                
        Assessment__c testassessment = new Assessment__c(
                        Transcript__c = testtranscript.Id,
                        Exam_Type__c = 'CAMS Questionnaire',
                        Score__c = 0);                        
        insert testassessment;
        eid = (testtranscript.Email__c).substring(0,(testtranscript.Email__c).indexOf('@'));
    
        for(Integer x = 1; x <= 60; x++) {
            Question__c question = new Question__c(
                        ExamType__c = 'CAMS Questionnaire'
                        //add necessary question details here--
                        );
            questionList.add(question);
        }
        insert questionList;
        for(Integer x = 1; x <= 60; x++) {
            Answer__c testAnswer = new Answer__c(
                        Assessment__c = testassessment.Id,
                        Question__c = questionList[x-1].Id
            );
            Decimal spreadMultiAns2 = Math.mod(x,5);
            if(spreadMultiAns2 == 0){
                testAnswer.AssertA__c = true;
                testAnswer.Topic_Name__c = 'A';
                testAnswer.Topic_Item_Name__c = 'A1';
            } else if(spreadMultiAns2 == 1){
                testAnswer.AssertB__c = true;
                testAnswer.Topic_Name__c = 'B';
                testAnswer.Topic_Item_Name__c = 'B1';
            } else if(spreadMultiAns2 == 2){
                testAnswer.AssertC__c = true;
                testAnswer.Topic_Name__c = 'B';
                testAnswer.Topic_Item_Name__c = 'B2';
            } else if(spreadMultiAns2 == 3){
                testAnswer.AssertD__c = true;
                testAnswer.Topic_Name__c = 'B';
                testAnswer.Topic_Item_Name__c = 'B3';
            } else {
                testAnswer.AssertE__c = true;
                testAnswer.Topic_Name__c = 'A';
                testAnswer.Topic_Item_Name__c = 'A2';
            }
            testAnswerList.add(testAnswer);
        }
        insert testAnswerList;       
                  
                
        /*
         * Initialize the page with invalid tokenCode.
         */
        currentPage = Page.ST_ViewTranscript;
        Test.setCurrentPage(currentPage);
        ApexPages.currentPage().getParameters().put('tc', 'thisIsAnInvalidCode');
        ApexPages.currentPage().getParameters().put('eid', eid);
        stdController = new ApexPages.standardController(testassessment); 
        assessmentTestController = new ST_ViewAssessmentController(stdController);
        System.assertEquals((new PageReference('/ST_TokenInvalid')).getUrl(), assessmentTestController.checkTokenCode().getUrl());
        
        /*
         * Initialize the page with a valid tokenCode.
         */
        currentPage = Page.ST_ViewTranscript;
        Test.setCurrentPage(currentPage);
        ApexPages.currentPage().getParameters().put('tc', testtranscript.TokenCode__c);
        ApexPages.currentPage().getParameters().put('eid', eid);
        stdController = new ApexPages.standardController(testassessment); 
        assessmentTestController = new ST_ViewAssessmentController(stdController);
        System.assertEquals(null, assessmentTestController.checkTokenCode());
        System.assertEquals(0, assessmentTestController.getAnswers().size());
             
        /*
         *  Test Score and Percentage Computations
         
        PageReference pageRef = Page.ST_ViewAssessment;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('tc', testtranscript.TokenCode__c);
        ApexPages.currentPage().getParameters().put('eid', eid);
        ApexPages.currentPage().getParameters().put('id', testassessment.Id);
        stdController = new ApexPages.standardController(testassessment); 
        assessmentTestController = new ST_ViewAssessmentController(stdController);
        assessmentTestController.isAdded();
        assessmentTestController.getTopicItemMap();
        assessmentTestController.getTopicMap();
        assessmentTestController.getScores();
        assessmentTestController.getTotal();
        assessmentTestController.getPer();
         */                                   
    }
}