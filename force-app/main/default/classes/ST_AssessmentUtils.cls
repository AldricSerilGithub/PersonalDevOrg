public class ST_AssessmentUtils {

    public static boolean checkAccentureEmail(String email) {
    String emailAdd = email.trim();
    return emailAdd.endsWith('@accenture.com') || emailAdd.endsWith('@accenturefederal.com'); 
    } 

/*
    public static void computeScore(List<Assessment__c> assessments) {
        for (Assessment__c assessment : assessments) {
            AggregateResult agg = [SELECT SUM(Correct2__c)tot, count(id)items FROM Answer__c WHERE Assessment__c =:assessment.Id];
            assessment.Score__c = (Decimal) agg.get('tot');
            assessment.TotalItems__c = (Decimal) agg.get('items');
            }
        update assessments;
    } */

    public static Id createAssessment(Id examSetId, String eid, String SelectedSurvey) {
        List<Answer__c> answers = new List<Answer__c>();
        Assessment__c assessment = new Assessment__c();
        List<ExamSet__c> examSet = [Select Id from ExamSet__c where Name =: SelectedSurvey];
        
        for (ExamSet__c exam :examSet) {
                examSetId = exam.Id;
        }

        Integer rnd = 1, i = 0;
        Boolean isAdded;
        Set<Integer> indexSet = new Set<Integer>();
        Map<Integer, Integer> indexMap = new  Map<Integer, Integer>();
        assessment.Transcript__c = ST_AssessmentUtils.selectTranscript(eid);
        assessment.Exam_Set__c = examSetId;
        assessment.Is_Latest__c = true;
        insert assessment;
    
        for(Question__c question : [Select Id, TopicItem__r.TopicItemName__c, TopicItem__r.TopicName__c from Question__c where ExamSet__r.Name =: SelectedSurvey.trim()]) {
            Answer__c ans = new Answer__c();
            ans.Question__c = question.Id;
            ans.Assessment__c = assessment.id;
            ans.Topic_Item_Name__c = question.TopicItem__r.TopicItemName__c;
            ans.Topic_Name__c = question.TopicItem__r.TopicName__c;
            answers.add(ans);
        }

        while(indexSet.size() < answers.size() + 1) {    
            isAdded = indexSet.add(rnd);
            if(isAdded) {
                indexMap.put(i, rnd);
                i++;
                rnd++;
            }
        }           
        
        for(Integer j = 0; j < answers.size(); j++) {
            if(String.valueof(indexMap.get(j)).length() == 1) {
                answers[j].Name = String.valueof('0' + indexMap.get(j));
            }
            else {
                answers[j].Name = String.valueof(indexMap.get(j));
            }
        }    

        answers.sort();
        insert answers;
        return assessment.id;
        
    }

/*---------------------------------------added for REQ-06------------------------------------------------*/

    public static id selectTranscript(String eid) {
        Set<String> email = new Set<String>{eid + '@accenture.com', eid + '@accenturefederal.com'};
        List<Transcript__c> transcripts = [Select id From Transcript__c Where Email__c IN :email];
            if(transcripts.size() == 1) {
                return transcripts[0].id;
            }
            else {
                return null;
            }
    }

    public static String generateCode() {
        Integer len = ST_Constants.TOKEN_CODE_LENGTH;
        Blob blobKey = crypto.generateAesKey(128);
        return EncodingUtil.convertToHex(blobKey).substring(0, len);
    }
    
    public static void sendTokenCode(String email) {
        Transcript__c transcript = [SELECT Id, Email__c, TokenCode__c FROM Transcript__c WHERE Email__c = :email] ;
        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE Name = 'ST_TokenCodeNotif2'];
        List<String> recipients = new List<String>{email};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.SetTemplateId(template.Id);
        mail.setSaveAsActivity(false);
        mail.setToAddresses(recipients);
        mail.setTargetObjectId(ST_Constants.TARGET_OBJECT_ID);
        mail.setWhatId(transcript.Id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

/*---------------------------------------------------------------------------------------------------------*/

}