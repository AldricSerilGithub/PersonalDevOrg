@isTest
private class ST_TakeAssessmentControllerTest {

    static testMethod void myUnitTest() {
        String eid;
        String email2;
        String eid2;
        List<Question__c> questionList = new List<Question__c>();         
        List<Answer__c> answerList = new List<Answer__c>();  
        ExamSet__c examSet = new ExamSet__c(
                        Name = 'Survey Questionnaire',
                        Duration__c = 90,
                        ItemCount__c = 60
        );
        insert examSet;
        Transcript__c transcript = new Transcript__c(
                        User_Type__c = 'Survey Taker',
                        Email__c='john.aldric.s.seril@accenturefederal.com',
                        TokenCode__c=ST_AssessmentUtils.generateCode()                        
        );
        insert transcript;
        Assessment__c assessment = new Assessment__c(
                        Transcript__c = transcript.Id,
                        Exam_Set__c = examSet.id
        );
        insert assessment;

        eid = (transcript.Email__c).substring(0,(transcript.Email__c).indexOf('@'));

        for(Integer x = 1; x <= 60; x++) {
            Question__c question = new Question__c(
                        ExamSet__c = examSet.Id
                        //add necessary question details here--
                        );                        
                   questionList.add(question);
        }
        insert questionList;
        for(Integer x = 1; x <= 60; x++) {
             Answer__c answer = new Answer__c(
                        Assessment__c = assessment.Id,
                        Question__c = questionList[x-1].Id
            );
            
            Decimal spreadMultiAns2 = Math.mod(x,5);
            if(spreadMultiAns2 == 0){
                answer.AssertA__c = true;
            } else if(spreadMultiAns2 == 1){
                answer.AssertB__c = true;
            } else if(spreadMultiAns2 == 2){
                answer.AssertC__c = true;
            } else if(spreadMultiAns2 == 3){
                answer.AssertD__c = true;
            } else {
                answer.AssertE__c = true;
            }
            answerList.add(answer);
        }
        insert answerList;
        
       
        Test.startTest();
        
         /*
         * Initialize the page with invalid tokenCode.
         */
        
        PageReference pageRef1 = Page.ST_TakeAssessment;  
        Test.setCurrentPage(pageRef1);
        
        ApexPages.currentPage().getParameters().put('id', assessment.Id);        
        ApexPages.currentPage().getParameters().put('eid', eid);
        ApexPages.currentPage().getParameters().put('tc', 'thisIsAnInvalidCode');
        
        ApexPages.standardController controller1 = new ApexPages.standardController(assessment); 
        
        ST_TakeAssessmentController assessmentController1 = new ST_TakeAssessmentController(controller1);
        System.assertEquals((new PageReference('/ST_TokenInvalid')).getUrl(), assessmentController1.checkTokenCode().getUrl());
        
        /*
         * Initialize the page with a valid tokenCode.
         */
        PageReference pageRef2 = Page.ST_TakeAssessment;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('id', assessment.Id);        
        ApexPages.currentPage().getParameters().put('eid', eid);
        ApexPages.currentPage().getParameters().put('tc', transcript.TokenCode__c);
        ApexPages.standardController controller2 = new ApexPages.standardController(assessment); 
        
        ST_TakeAssessmentController assessmentController2 = new ST_TakeAssessmentController(controller2);
        System.assertEquals(null, assessmentController2.checkTokenCode());
        
        /*
         * Initialize the page with invalid email.
         */
        email2 = 'test@email.com';
        eid2 = (email2).substring(0,(email2).indexOf('@'));
        PageReference pageRef3 = Page.ST_TakeAssessment;  
        Test.setCurrentPage(pageRef3);
        ApexPages.currentPage().getParameters().put('id', assessment.Id);        
        ApexPages.currentPage().getParameters().put('eid', eid2);
        ApexPages.currentPage().getParameters().put('tc', transcript.TokenCode__c);
        ApexPages.standardController controller3 = new ApexPages.standardController(assessment); 
        ST_TakeAssessmentController assessmentController3 = new ST_TakeAssessmentController(controller3);
        ApexPages.Message msg = new Apexpages.Message(ApexPages.severity.ERROR, 'You do not own the Assessment record that you are trying to view!');
        
        /*
         * Test other methods.
         */
        PageReference currentPage = Page.ST_TakeAssessment;
        Test.setCurrentPage(currentPage);
        ApexPages.currentPage().getParameters().put('id', assessment.Id);        
        ApexPages.currentPage().getParameters().put('eid', transcript.Email__c.split('@')[0]);
        ApexPages.currentPage().getParameters().put('tc', transcript.TokenCode__c);
        ApexPages.currentPage().getParameters().put('esid', examSet.id);
        ApexPages.standardController controller4 = new ApexPages.standardController(assessment); 
        ST_TakeAssessmentController assessmentController4 = new ST_TakeAssessmentController(controller4);
        assessmentController4.currentIndex = 1;
        assessmentController4.getShowPagination();
        assessmentController4.getPageSize();
        assessmentController4.getLastPage();
        assessmentController4.getCurrentPage();
        assessmentController4.getIsNotFirstPage();
        assessmentController4.getIsNotLastPage();
		assessmentController4.getAnswers();  
		assessmentController4.first();
        assessmentController4.next();
        assessmentController4.previous();
        assessmentController4.last();
        assessmentController4.closePopup();
        assessmentController4.showPopup();
            
        
        assessmentController4.getIsValidAssessment();
        
        String submitPagereference = assessmentController4.submitAssessment().getUrl();
        
        Test.stopTest();        

        System.assertEquals(submitPagereference,'/apex/ST_ViewTranscript?aid='+assessment.Id+'&eid='+eid+'&esid='+examSet.id+'&id='+assessment.Transcript__c+'&tc='+transcript.TokenCode__c);
        System.assertEquals(answerList.size(), 60);
        System.assertEquals(questionList.size(), 60); 
        
    }
    
    static testMethod void myUnitTest2() {
        String eid;
        List<Question__c> questionList2 = new List<Question__c>();         
        List<Answer__c> answerList2 = new List<Answer__c>();  
        ExamSet__c examSet2 = new ExamSet__c(
                        Name = 'Survey Questionnaire',
                        Duration__c = 90,
                        ItemCount__c = 60
        );
        insert examSet2;
        Transcript__c transcript2 = new Transcript__c(
                        User_Type__c = 'Survey Taker',
                        Email__c='john.aldric.s.seril@accenturefederal.com',
                        TokenCode__c=ST_AssessmentUtils.generateCode()                     
        );
        insert transcript2;
        Assessment__c assessment2 = new Assessment__c(
                          Transcript__c = transcript2.Id,
                        Exam_Set__c = examSet2.id
        );
        insert assessment2;
        eid = (transcript2.Email__c).substring(0,(transcript2.Email__c).indexOf('@'));

        for(Integer x = 1; x <= 60; x++) {
            Question__c question2 = new Question__c(
                        ExamSet__c = examSet2.Id
                       
                        //add necessary question details here--
                        );                        
                   questionList2.add(question2);
        }
        insert questionList2;
        for(Integer x = 1; x <= 60; x++) {
             Answer__c answer2 = new Answer__c(
                        Assessment__c = assessment2.Id,
                        Question__c = questionList2[x-1].Id
            );
            
            Decimal spreadMultiAns2 = Math.mod(x,5);
            if(spreadMultiAns2 == 0){
                answer2.AssertA__c = true;
            } else if(spreadMultiAns2 == 1){
                answer2.AssertB__c = true;
            } else if(spreadMultiAns2 == 2){
                answer2.AssertC__c = true;
            } else if(spreadMultiAns2 == 3){
                answer2.AssertD__c = true;
            } else {
                answer2.AssertE__c = true;
            }
            answerList2.add(answer2);
        }
        insert answerList2;
        
        Test.startTest();
        
        /*
         * Test other methods.
         */
        PageReference currentPage = Page.ST_ViewAssessment;
        Test.setCurrentPage(currentPage);
        ApexPages.currentPage().getParameters().put('id', assessment2.Id);        
        ApexPages.currentPage().getParameters().put('eid', transcript2.Email__c.split('@')[0]);
        ApexPages.currentPage().getParameters().put('tc', transcript2.TokenCode__c);
        ApexPages.currentPage().getParameters().put('esid', examSet2.id);
        ApexPages.standardController controller4 = new ApexPages.standardController(assessment2); 
        ST_TakeAssessmentController assessmentController4 = new ST_TakeAssessmentController(controller4);
        assessmentController4.getIsValidAssessment();
        String submitPagereference = assessmentController4.submitAssessment().getUrl();
        
        Test.stopTest();        

        System.assertEquals(submitPagereference, '/apex/ST_ViewTranscript?aid='+assessment2.Id+'&eid='+eid+'&esid='+examSet2.id+'&id='+assessment2.Transcript__c+'&tc='+transcript2.TokenCode__c);
        System.assertEquals(answerList2.size(), 60);
        System.assertEquals(questionList2.size(), 60);
    } 
    
}