public class ST_ViewAssessmentController {
    ApexPages.StandardController controller;
    public List<Answer__c> myQandA {get; set;}
    private String eid;
    Set<String> TopicItemSet = new Set<String>();
    Set<String> TopicSet = new Set<String>();
    public List<Question__c> Capabs = new List<Question__c>();
    public List<Answer__c> CapabSFDC {get;set;}
/*
    public List<Answer__c> CapabJava {get;set;}
    public List<Answer__c> CapabTools {get;set;}
    public List<Answer__c> CapabLang {get;set;}
    public List<Answer__c> CapabTesting {get;set;}
    public List<Answer__c> CapabOthers {get;set;}
 */

    Boolean isAdded;
    Boolean topicExist;
    integer i=0;
    integer x=0;
        
    public ST_ViewAssessmentController(ApexPages.StandardController stdController) {
       
        this.controller = stdController;
        eid = ApexPages.currentPage().getParameters().get('eid');
        myQandA = [SELECT Id, Name, Question__r.question__c,Question__r.Choice_A__c,
                            Question__r.Choice_B__c, Question__r.Choice_C__c, Question__r.Choice_D__c, Question__r.Source__c, AssertA__c,
                            AssertB__c,AssertC__c,AssertD__c,AssertE__c, AssertedAnswer__c, AssCorrect__c,Correct_Input__c,Marked_for_Review__c,Assessment__c,
                            Topic_Name__c, Topic_Item_Name__c, Question__r.TopicItem__r.TopicName__c, Question__r.TopicItem__r.TopicItemName__c, CAMS_Answer__c,
                            ST_Answer__c from Answer__c WHERE 
                            Assessment__c =:ApexPages.currentPage().getParameters().get('id')
                            order by Question__r.Capabilitiy__c];
          
        CapabSFDC = [SELECT Id,Question__r.IsMultiple__c,AssertA__c,
                            AssertB__c,AssertC__c,AssertD__c,AssertE__c, AssertedAnswer__c,Question__r.IsOneAnswer__c, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,ST_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id')];
         
     /*
        CapabJava = [SELECT Id, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') And Question__r.Capabilitiy__c =: 'JAVA'];

     
        CapabTesting = [SELECT Id, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') And Question__r.Capabilitiy__c =: 'TESTING'];

        CapabTools = [SELECT Id, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') And Question__r.Capabilitiy__c =: 'TOOLS'];
        
        CapabLang = [SELECT Id, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') And Question__r.Capabilitiy__c =: 'OTHER LANGUAGES'];
    
        CapabOthers = [SELECT Id, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') And Question__r.Capabilitiy__c =: 'OTHERS'];
      */
        

           /* 
        for(Answer__c answer : [Select Topic_Name__c, Topic_Item_Name__c from Answer__c where Assessment__c =:ApexPages.currentPage().getParameters().get('id')]) {
            isAdded = TopicItemSet.add(answer.Topic_Item_Name__c);

            i++;
        }*/
 
    }
    
    public PageReference checkTokenCode() {
        String email = eid + '@accenture.com';
        Transcript__c transcript;
        try {
            transcript = [SELECT TokenCode__c from Transcript__c WHERE Email__c = :email];
            }
        catch(QueryException e) {
            email = eid + '@accenturefederal.com';
            transcript = [SELECT TokenCode__c from Transcript__c WHERE Email__c = :email];
        }
        if(ApexPages.currentPage().getParameters().get('tc') != transcript.TokenCode__c) {
            return (new PageReference('/ST_TokenInvalid'));
        }
        else {
            return null;
        }
    }
    
    public List<Answer__c> getAnswers() {
        return (List<Answer__c>) myQandA;
    }

   
}