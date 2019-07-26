@isTest(SeeAllData=true)
public class ST_updateQuestionControllerTest{

    static testMethod void myUnitTest() {
    
    List<Question__c> questionList = new List<Question__c>();
    List<Answer__c> testAnswerList = new List<Answer__c>();
    PageReference currentPage;
    String eid;
    ApexPages.standardController stdController;    
        
    Transcript__c testtranscript = new Transcript__c(
                        Email__c = 'john.s.seril@accenture.com',
                        TokenCode__c = ST_AssessmentUtils.generateCode());
        insert testtranscript;
        
    ExamSet__c testExamSet = new ExamSet__c(
                        Name = 'ST Questionnaires', 
                        Duration__c = 150,
                        ItemCount__c = 100
                        );                        
        insert testExamSet;    
        
                
    Assessment__c testassessment = new Assessment__c(
                        Transcript__c = testtranscript.Id,
                        Exam_Set__c = testExamSet.id
                        );                        
        insert testassessment;
    
    for(Integer x = 1; x <= 60; x++) {
            Question__c question = new Question__c(
                        Question__c = 'Question' + x,
                        ExamSet__c = testExamSet.id,
                		Choice_A__c = 'A',
                		Choice_B__c = 'B'
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
            } else if(spreadMultiAns2 == 1){
                testAnswer.AssertB__c = true;
            } else if(spreadMultiAns2 == 2){
                testAnswer.AssertC__c = true;               
            } else if(spreadMultiAns2 == 3){
                testAnswer.AssertD__c = true;
            } else {
                testAnswer.AssertE__c = true;
            }
            testAnswerList.add(testAnswer);
        }
        insert testAnswerList;    
    
      eid = (testtranscript.Email__c).substring(0,(testtranscript.Email__c).indexOf('@'));
      
         
    
    currentPage = Page.ST_updateQuestion;
    Test.setCurrentPage(currentPage);
    ApexPages.currentPage().getParameters().put('tc', 'invalidtoken');
    ApexPages.currentPage().getParameters().put('eid', eid);
    ST_updateQuestionController uQC = new ST_updateQuestionController();
    
    System.assertEquals('/ST_TokenInvalid', uqc.checkTokenCode().getUrl());        
        
       
    currentPage = Page.ST_updateQuestion;
    Test.setCurrentPage(currentPage);
    ApexPages.currentPage().getParameters().put('tc', testTranscript.id);
    ApexPages.currentPage().getParameters().put('eid', eid);
  
    uQC = new ST_updateQuestionController();
      
          
    uQc.getNewLink();    
    
    boolean testdisplayTable = uQC.displayTable;
    
        
    uQc.getSurveyfilter();
    uQc.getEditLink();
    	
    uQc.Text = 'Question1';
    uQc.selectedfilter = 'ST Questionnaires';
    
    List<ExamSet__c> examList = [Select ID,Name from ExamSet__c WHERE Name=: uqc.selectedfilter];
    
    List<Question__c> questList = [Select ID,Name,Question__c from Question__c where ExamSet__c =: examList[0].id];
    List<Question__c> quest = new List<Question__c>();    
    
    for(Question__c que : questList)
    {
        if(que.Question__c.containsIgnoreCase(uQc.Text.trim()) )
        {
           quest.add(que);
        }            
    }
    uQc.Search();
    
    uQc.questionId = quest[0].id;
    uQc.deleteButton();  
         
	    
    testdisplayTable = uQC.displayTable;
    }
}