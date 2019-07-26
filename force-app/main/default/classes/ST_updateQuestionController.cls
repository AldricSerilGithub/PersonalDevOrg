public class ST_updateQuestionController {

    public String Text{get; set;}
    public List<Question__c> quest {get;set;}
    public List<Question__c> searchList {get;set;}
    public ID questionId { get; set; }
    public examset__c exset{get; set;}
    public String tokenCode {get;set;}
    public String eid {get;set;}
    public List<Question__c> selectedQuestions{get;set;}
    public String selectedfilter{get;set;}

    public List<SelectOption> getSurveyfilter() {    
        List<SelectOption> SurFilter = new List<SelectOption>();
            for(ExamSet__c examset : [Select Id,Name from ExamSet__c]) {
                    surFilter.add(new SelectOption(examset.Name,examset.Name));
            }
        return SurFilter;
    }

    public boolean displayTable {
        get{
            boolean displayTheTable;
            
            if(quest.isEmpty() || quest == NULL) {
                displayTheTable = FALSE;
            }else {
                displayTheTable = TRUE;
            }
            return displayTheTable;
        }
    }


    public ST_updateQuestionController() {
        quest = New List<Question__C>(); 
    }

    public void Search() {        
        if(Text != null || Text != ' ') {       
            String searchData = Text;  
            quest = New List<Question__C>();     
            ExSet = [SELECT ID,Name from ExamSet__c where Name =: SelectedFilter];
       
            for( Question__C Sear : [SELECT Id,Name,Question__c,Choice_A__c,Choice_B__c,Choice_C__c,Choice_D__c,Choice_E__c,ExamSet__c,ExamType__c,IsMultiple__c From Question__c where Examset__c =: exset.id]) {
                if( (Sear.Question__c.containsIgnoreCase(Text.trim())) || (Sear.Choice_A__c.containsIgnoreCase(Text.trim())) || (Sear.Choice_B__c.containsIgnoreCase(Text.trim())) || (Sear.Name.containsIgnoreCase(Text.trim())) ) {
                    quest.add(Sear);
                }
            }
        }              
    }
/*
    public PageReference questions() {
        Question__c questid = [SELECT Id,Name FROM Question__C WHERE Id=:questionID Limit 1];
                   
        PageReference HomePage = new PageReference('/apex/ST_updateQuestionPage?id=' + questid.id);
        return HomePage.setRedirect(true);
    }
*/                
    public String getNewLink() {
        String location;
        String basePages;
    
        basePages = URL.getSalesforceBaseUrl().toExternalForm();

        if(basePages.contains('visual')) {
            location = '/apex/ST_updateQuestionPage';
        }else {
            location = '/SurveyTool/ST_updateQuestionPage';
        }
        
    return location;
    }           
        
        
    public String getEditLink(){
        String location;
        String basePages;
    
        basePages = URL.getSalesforceBaseUrl().toExternalForm();

        //Question__c questid = [SELECT Id,Name FROM Question__C WHERE Id=:questionID Limit 1];
    
        if(basePages.contains('https://c.cs8.visual.force.com')) {
            location = '/apex/ST_updateQuestionPage?id=';// + questid.id ;
        }else {
            location = '/SurveyTool/ST_updateQuestionPage?id=';// + questid.id ;
        }
        
    return location;
    }        
        
    public void deleteButton() {       
        Question__c questid = [SELECT Id,Name FROM Question__C WHERE Id=:questionID Limit 1];
        Delete questid;
        Search();
    }        


    public PageReference checkTokenCode() {         
        tokenCode = ApexPages.currentPage().getParameters().get('tc');
        eid = ApexPages.currentPage().getParameters().get('eid');
        Transcript__c transcript = [Select Id,TokenCode__c from Transcript__c where Email__c =: eid.trim()+'@accenture.com'];
 
        if(tokenCode != transcript.TokenCode__c) {
            return (new PageReference('/ST_TokenInvalid'));
        }else {
            return null;
        }
    }
    
}