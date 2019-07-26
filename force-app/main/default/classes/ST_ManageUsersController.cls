public class ST_ManageUsersController {
    private final static String EXAM_TYPE_NAME = 'Survey Questionnaire';
    public List<Transcript__c> transcriptList {get; set;}
    public List<TranscriptWrapper> trList {get; set;}
    public Map<String, Transcript__c> transcriptMap {get; set;}
    public List<SelectOption> surveyList {get; set;}
    public String selectedTranscript {get; set;}
    public String selectedTypes {get; set;}
    public class TranscriptWrapper{
        public string email {get; set;}
        public string eid {get; set;}
        public string surveyType {get; set;}
    }
    public ST_ManageUsersController(){
        transcriptList = [Select Id, Email__c, Name, Survey_Type__c from Transcript__c Where Examinee_Type__c=: EXAM_TYPE_NAME LIMIT 50000];
        trList = new List<TranscriptWrapper>();
        transcriptMap = new Map<String, Transcript__c>();
        for(Transcript__c tr: transcriptList){
            TranscriptWrapper tw = new TranscriptWrapper();
            tw.email = tr.Email__c;
            tw.eid = tr.Email__c.substring(0, tr.Email__c.indexOf('@'));
            tw.surveyType = tr.Survey_Type__c;
            trList.add(tw);
            transcriptMap.put(tr.Email__c, tr);
        }
        Map<String, Survey_Types__c> surveyMap = Survey_Types__c.getAll();
        surveyList = new List<SelectOption>();
        for(String sr: surveymap.keyset()){
            surveyList.add(new SelectOption(sr, sr));
        }
    }
    
    public PageReference updateTranscript(){
        //Transcript__c tranRecord = transcriptMap.get(selectedTranscript);
        //tranRecord.Survey_Type__c = selectedTypes;
        for(TranscriptWrapper tr: trList){
            transcriptMap.get(tr.email);
            if(tr.Email == selectedTranscript){
                tr.surveyType = selectedTypes.replace('[','').replace(']','');
            }
        }
        return null;
    }
    public PageReference updateAll(){
        transcriptList = new List<Transcript__c>();
        for(TranscriptWrapper tr: trList){
            Transcript__c tran = transcriptMap.get(tr.email);
            tran.Survey_Type__c = tr.surveyType;
            transcriptList.add(tran);
        }
        try{
            update transcriptList;
            Apexpages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, 'Records successfully updated.');
            ApexPages.addMessage(msg);
        }catch(DMLException dex) {
            Apexpages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to update records. Please try again later.');
            ApexPages.addMessage(msg);
        }
        return null;
    }

}