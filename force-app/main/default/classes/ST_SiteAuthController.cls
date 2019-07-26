public class ST_SiteAuthController {

    public String email {get;set;}
    public String tokenCode {get;set;}
    public Boolean browserSupported {get;set;}
    public Boolean bs {get;set;}
    public String userAgent {get; set;}
    private Transcript__c transcript;
    public List<ExamSet__c> examSet {get; set;}
    public Id examSetId {get; set;}
        
    public String getInstruction() {
        return ST_Constants.LOGIN_INSTRUCTION;
    }
    
    public String getErrorBrowser() {
        return ST_Constants.ERROR_UNSUPPORTED_BROWSER;
    }
    
    public Boolean testBrowser(){
        if(Test.IsRunningTest()) {
            userAgent = ApexPages.currentPage().getHeaders().get('USER-AGENT');
            if(userAgent.contains('MSIE 8')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ST_Constants.ERROR_UNSUPPORTED_BROWSER));
                browserSupported = false;
                return false;
            }
            else {
                browserSupported = true;
                return true;
            }
        }
        else {
            browserSupported = true;
            return true;
        }
    }
    
    public ST_SiteAuthController() {
       // examset = [Select Id from ExamSet__c where Name ='ST Questionnaire'];
    }
    
    public PageReference sendToken() {
        if(checkEmail()) {
            retrieveTranscript();
            transcript.SendEmail__c = true;
            transcript.TokenCode__c = ST_AssessmentUtils.generateCode();
            update transcript; 
        }
        return null;
    }
    
    public PageReference login() {
        email = email.trim();
        if(checkEmail()) {
            retrieveTranscript();
            String eid = email.substring(0, email.indexOf('@'));  
           
            
            if(tokenCode == transcript.TokenCode__c) {
                return (new PageReference('/apex/ST_ViewTranscript?id=' + transcript.id + '&eid=' + eid + '&tc=' + transcript.TokenCode__c)); // + '&esid=' + examSetId));
            }
            else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ST_Constants.ERROR_INVALID_TOKEN_CODE));
                return null;
            }
        }
        else {
            return null;
        }
    }
    
    public Boolean checkEmail()  {
        if(ST_AssessmentUtils.checkAccentureEmail(email)) {
            return true;
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ST_Constants.ERROR_NON_ACCENTURE_EMAIL));
            return false;
        }
    }
    
    public void retrieveTranscript() {
        try {
            transcript = [SELECT Id, TokenCode__c FROM Transcript__C WHERE Email__c = :email];
            /*
            transcript.examinee_type__c = 'Survey Questionnaire';
            //transcript.TokenCode__c = ST_AssessmentUtils.generateCode();
            update transcript;
            */
        }
        catch(QueryException e) {
            insertNewTranscript();
        }
    }
    
    public void insertNewTranscript() {
        transcript = new Transcript__c(
            Email__c = email,
            Examinee_Type__c = 'Survey Questionnaire',
            User_Type__c = 'Survey Taker'
           // TokenCode__c = ST_AssessmentUtils.generateCode()            
        );
        insert transcript;
    }
    

}