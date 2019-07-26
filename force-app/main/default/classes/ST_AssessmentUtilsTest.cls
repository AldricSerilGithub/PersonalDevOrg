@isTest 
public class ST_AssessmentUtilsTest {

    static testMethod void myUnitTest() {
        
        
        ExamSet__c examSet = new ExamSet__c(
            Name = 'ST Questionnaire',
            Duration__c = 30,
            ItemCount__c = 60);
            insert examSet;
        
        //Insert new Transcript        
        Transcript__c transcript = new Transcript__c(
            Survey_Type__c = 'ST Questionnaire',
            Email__c = 'john.aldric.s.seril@accenturefederal.com',
            TokenCode__c = 'xxxxxxxx'
            );
        insert transcript;

        //Insert new Assessment
        Assessment__c assessment = new Assessment__c(
            Exam_Set__c = examSet.id,
            Transcript__c = transcript.Id
            );
        insert assessment;        
       
        //Insert new Exam
        List<Question__c> questionList = new List<Question__c>();         

        
                
        for(Integer x = 1; x <= 60; x++) {
        Question__c question = new Question__c(
            Question__c = 'Question' + X,
            ExamSet__c = examSet.Id
            );
                    
        questionList.add(question);
        }
        insert questionList;
        
        for(Integer x = 1; x <= 60; x++) {
        Answer__c answer = new Answer__c(
            Assessment__c = assessment.Id, 
            Question__c = questionList[x-1].Id );
        insert answer;
        }    

        List<Assessment__c> AssessList = new List<Assessment__c>();
        insert AssessList;

        Test.startTest();
        ST_AssessmentUtils.generateCode();
        ST_AssessmentUtils.checkAccentureEmail(transcript.Email__c);
        ST_AssessmentUtils.selectTranscript(transcript.Id);
        ST_AssessmentUtils.createAssessment(examSet.Id, transcript.email__c, examSet.name);
        //ST_AssessmentUtils.computeScore(AssessList);
        test.stopTest();  
    }
    
    public static testMethod void sendTokenCodeTest() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User u = new User(Alias = 'standt', Email='c@accenturefederal.com', 
                EmailEncodingKey='UTF-8', LastName='C', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', 
                UserName='c@accenturefederal.com');
        System.runAs(u){
         /*
         * send token code email
         */
        Transcript__c transcript1 = new Transcript__c(
            Certification_Track__c = 'Developer',
            Examinee_Type__c = 'Certification',
            Email__c = 'jtest@accenturefederal.com',
            TokenCode__c = 'xxxxxxxx');
        insert transcript1;
        
        Transcript__c TS = [SELECT Id, Email__c, TokenCode__c from Transcript__c where Id = :transcript1.Id limit 1];
      
        Contact contact = new Contact(
            FirstName ='Testing', 
            LastName = 'Test',
            Email__c = 'test@accenturefederal.com');
        insert contact;

        EmailTemplate ET = [SELECT Id, Name from EmailTemplate where Name = :'ST_TokenCodeNotif2' limit 1];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(ET.Id);
        mail.setSaveAsActivity(false);
        mail.setToAddresses(new string[] {'test@accenturefederal.com', 'test@accenture.com'});
        mail.setTargetObjectId(contact.id);
        mail.setWhatId(transcript1.Id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

        ST_AssessmentUtils.sendTokenCode(TS.Email__c);       
        }
    }
}