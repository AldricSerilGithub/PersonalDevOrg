public class ST_ViewTranscriptController {

    private ApexPages.StandardController controller;
    private Assessment__c assessment = new Assessment__c();
    private Transcript__c transcript;
    private ExamSet__c examSet;
    public Boolean examDone {get;set;}
    public List<Question__c> QuesSetList;
    public String QuesSetId;
    public String tokenCode {get;set;}
    public String eid {get;set;}
    public Boolean takeSurvey{get; set;}
    public String selectedSurvey{get;set;}

    public List<SelectOption> getSurveyOptions() {    
        List<SelectOption> SurOptions = new List<SelectOption>();
        List<Transcript__c> trans = new List<Transcript__c>();
          
        takeSurvey = False;
           
        trans = [SELECT ID,Name,Survey_Type__c from Transcript__c where email__c =:ApexPages.currentPage().getParameters().get('eid')+ '@accenture.com'];
            if(trans[0].Survey_Type__c != Null) {
                String[] survs = trans[0].Survey_Type__c.split(',');
                              
                for(integer i=0;i<survs.size(); i++) {
                    surOptions.add(new SelectOption(survs[i],survs[i]));
                }
                      
                takeSurvey = True;   
            }else{
                surOptions.add(new SelectOption('--None--','--None--'));
            }              
        return SurOptions;
    }

    public Boolean getIsValidTranscript() {
        return (transcript.Email__c == (eid + '@accenture.com')) || (transcript.Email__c == (eid + '@accenturefederal.com'));
    }

    public Transcript__c getTranscript() {
        return transcript;
    } 

    public void setTranscript(Transcript__c transcript1) {
        this.transcript = transcript1;
    }


    public ST_ViewTranscriptController(ApexPages.StandardController stdController) {
        this.controller = stdController; 
        String transcriptId = controller.getId();
        this.transcript = [Select Name, Email__c, Certification_Track__c, Examinee_Type__c, TokenCode__c FROM Transcript__c Where id = :transcriptId];
        this.tokenCode = ApexPages.currentPage().getParameters().get('tc');
        this.eid = ApexPages.currentPage().getParameters().get('eid');
        
        if(transcript.Email__c != (eid + '@accenture.com') && transcript.Email__c != (eid + '@accenturefederal.com')) {
            Apexpages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'You do not own the Transcipt record that you are trying to view!');
            ApexPages.addMessage(msg);
        }
        
        if (ApexPages.currentPage().getParameters().get('aid') != NULL) {
            examDone = true;
            this.assessment = [SELECT id, Name, Exam_Type__c, Certification_Track__c, Score__c, Percentage__c, rating__c, TotalItems__c, Report_Type__c from Assessment__c where id =: ApexPages.currentPage().getParameters().get('aid') order by Name Desc];
        }
    }


    public PageReference checkTokenCode() {
        if(tokenCode != transcript.TokenCode__c) {
            return (new PageReference('/ST_TokenInvalid'));
        }
        else {
            return null;
        }
    }
        
    public String getUpdateLink() {
        String location;
        String basePages;
    
        basePages = URL.getSalesforceBaseUrl().toExternalForm();
    
        if(basePages.contains('visual')) {
            location = '/apex/ST_updateQuestion?eid=' + eid + '&tc=' + tokenCode ;
        }else {
            location = '/SurveyTool/ST_updateQuestion?eid=' + eid + '&tc=' + tokenCode ;
        }
        
    return location;
    }
    
    
    public String getImportLink() {
        String location;
        String basePages;
    
        basePages = URL.getSalesforceBaseUrl().toExternalForm();
    
        if(basePages.contains('visual')) {
            location = '/apex/ST_ImportDataFromCSV?eid=' + eid + '&tc=' + tokenCode ;
        }else {
            location = '/SurveyTool/ST_ImportDataFromCSV?eid=' + eid + '&tc=' + tokenCode ;
        }
        
    return location;
    }
    
    
    public String getSurveyTakerLink() {
        String location;
        String basePages;
    
        basePages = URL.getSalesforceBaseUrl().toExternalForm();
    
        if(basePages.contains('visual')) {
            location = '/apex/ST_ManageUsers?eid=' + eid + '&tc=' + tokenCode ;
        }else {
            location = '/SurveyTool/ST_ManageUsers?eid=' + eid + '&tc=' + tokenCode ;
        }
        
    return location;
    }
/*    
    public String getType() {
        return examSet.ExamType__c;
    }
*/
    public Assessment__c getAssessment() {
        return assessment;
    }

    public PageReference launchExam() {
        Id assessmentId;
        
        ExamSet__c examSet = [SELECT ID,Name from ExamSet__c where Name = : SelectedSurvey.trim()];
        
        List<Assessment__c> assess = new List<Assessment__c>();
        
        assess = [SELECT ID,CreatedDate from Assessment__c Where Transcript__c = : controller.getid() and Exam_Set__c =: examSet.ID ];
        
        Id examSetId = examSet.id;
        
        if(assess.size() != 0 ) {
            if(Date.today().daysBetween(date.valueof(assess[0].CreatedDate)) >= 30) {
                assess[0].Is_Latest__c = false;
                update assess;
                assessmentId = ST_AssessmentUtils.createAssessment(examSetId, eid, SelectedSurvey);               
            }else {
                assessmentId = assess[0].Id;
            }
        }
        else if(assess.size() == 0 ) {
            assessmentId = ST_AssessmentUtils.createAssessment(examSetId, eid, SelectedSurvey);
        }        
        
        PageReference pageRef;
        String basePages;
        basePages = URL.getSalesforceBaseUrl().toExternalForm();
        if(basePages.contains('visual')) {
            pageRef = new PageReference('/apex/ST_TakeAssessment?id=' + assessmentId + '&eid=' + eid + '&tc=' + tokenCode );            
        }else {
            pageRef = new PageReference('/SurveyTool/ST_TakeAssessment?id=' + assessmentId + '&eid=' + eid + '&tc=' + tokenCode ); 
        }
         
        return pageRef;
    }  
}