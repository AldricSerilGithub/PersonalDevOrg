public class ImportDataFromCSVController {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public String tokenCode {get;set;}
    public String eid {get;set;}
    public List<examset__c> exset{get; set;}
    public List<Question__c> questionList {get; set;}
    public List<Question__c> delQuestionList {get; set;}
    public List<Question__c> delQuestionList1 {get; set;}
    public List<Question__c> updQuestionList {get; set;}
    public List<Transcript__c> transcriptList {get; set;}
    public String questionnaireName{get;set;}
    public String itemCount{get;set;}
    public String duration{get;set;}

    public ImportDataFromCSVController() {          
        csvFileLines = new String[]{};
        questionList = New List<Question__c>();
        delQuestionList = New List<Question__c>();
        updQuestionList = New List<Question__c>();
    }
  
    public void importCSVFile() {       
       try {       
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n');
           questionList = new List<Question__c>();
               
           string[] csvRecordData = csvFileLines[1].split(',');
           String RecData = csvRecordData[6];
           ExSet = [SELECT ID,Name from ExamSet__c where Name =: RecData];
              
           ExamSet__c questionName = new ExamSet__c();
  
           ID ExSets;
  
               if(ExSet.size()==0) {               
                  questionName.Name = RecData.trim();
                  questionName.itemCount__c = 100;
                  questionName.duration__c = 90;
    
                  Insert questionName;
      
                  ExSets = questionName.id;
      
                  Survey_Types__c csST = new Survey_Types__c();
                  csST.Name = RecData.trim();
                  Insert csSt; 
               }
      
               else {              
                  ExSets = ExSet[0].id;
               }
               
               String tralse;
           
               for(Integer i=1 ; i<csvFileLines.size() ; i++) {               
                   Question__c queObj = new Question__c();
                   csvRecordData = csvFileLines[i].split(',');
                   queObj.Question__c = csvRecordData[0];            
                   queObj.Choice_A__c = csvRecordData[1];
                   queObj.Choice_B__c = csvRecordData[2];
                   queObj.Choice_C__c = csvRecordData[3];  
                   queObj.Choice_D__c = csvRecordData[4];
                   queObj.Choice_E__c = csvRecordData[5];              
                   tralse = csvRecordData[7].trim();
               
                       if(tralse.equalsIgnoreCase('true')) {
                           queObj.IsMultiple__c = true;
                       }
               
                   queObj.Examset__c = ExSets;
                   questionList.add(queObj);  
               }
           
           insert questionList;
       }catch(Exception e) {       
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importing data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
       } 
   }
  
    public void DeleteCSVFile() {
        try {
            delQuestionList = New List<Question__c>();
            csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n');
            delQuestionList = new List<Question__c>();
           
            for(Integer i=1;i<csvFileLines.size();i++) {
                Question__c DelqueObj = new Question__c() ;
                string[] csvRecordData = csvFileLines[i].split(',');
                
                String RecData = csvRecordData[6].trim();
                ExSet = [SELECT ID,Name from ExamSet__c where Name =: RecData];
                
                String Quest = csvRecordData[0];
                String Choice = csvRecordData[1];
               
                delQuestionList1 = [SELECT ID,Choice_A__c,Choice_B__c,Choice_C__c,Choice_D__c,Choice_E__c,ExamSet__c,Examtype__c,Question__c,IsMultiple__c from Question__c where ExamSet__c =: Exset[0].ID];
               
                    for( Question__C Ddelqueobj : delQuestionList1) {
                         if( (Ddelqueobj.Question__c == Quest )&&( Ddelqueobj.Choice_A__c == Choice)) {
                             delQuestionList.add(DdelqueObj);
                         }
                    }
            }
            Delete delQuestionList;
        }catch(Exception e) {
             ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
             ApexPages.addMessage(errorMessage);
        } 
    }
  
    public void upsertCSVFile() {  
        Map<String, Question__c> questionMap = new Map<String, Question__c> {};
        updQuestionList = New List<Question__c>();
          
            if(csvAsString!=Null) {
                csvAsString = csvFileBody.toString();
                csvFileLines = csvAsString.split('\n');
   
                string[] csvRecordData2 = csvFileLines[1].split(',');
                String RecData = csvRecordData2[6];
   
                ExSet = [SELECT ID,Name from ExamSet__c where Name =: RecData Limit 1];
    
                if(ExSet.size() > 0) {       
                    for(Question__c quest: [SELECT Id,question__c from Question__c where ExamSet__c =: ExSet[0].Id]) {
                        questionMap.put(quest.question__c, quest);
                    }
                  
                    questionList = new List<Question__c>();
      
                    String tralse;
      
                    for(Integer i=1;i<csvFileLines.size();i++) {
                        Question__c queObj = new Question__c() ;
                        string[] csvRecordData = csvFileLines[i].split(',');
                        queObj.Question__c = csvRecordData[0] ;            
                        queObj.Choice_A__c = csvRecordData[1];
                        queObj.Choice_B__c = csvRecordData[2];
                        queObj.Choice_C__c = csvRecordData[3];  
                        queObj.Choice_D__c = csvRecordData[4];
                        queObj.Choice_E__c = csvRecordData[5];
                        queObj.ExamType__c = csvRecordData[7];
                   
                        tralse = csvRecordData[7].trim();
                            if(tralse.equalsIgnoreCase('true')) {
                                queObj.IsMultiple__c = true;
                            }
                   
                            if(questionMap.containsKey(csvRecordData[0])) {
                                queObj.ID = questionMap.get(csvRecordData[0]).id;
                            }
                      
                        queObj.ExamSet__c = exSet[0].id;
                        updQuestionList.add(queObj);
                    }
    
                  try {  
                      upsert updQuestionList;
                  }catch(DMLException dex) {
                      ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,dex.getMessage());
                      ApexPages.addMessage(errorMessage);
                  }
              }else {
                  ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'Exam Set is not yet defined. Please define first Exam Set before inserting Questionnaire');
                  ApexPages.addMessage(errorMessage);
              }
          }else {          
              ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importing data. Please make sure input .csv file is correct');
              ApexPages.addMessage(errorMessage);
          }
    }
  
    public PageReference checkTokenCode() {         
        tokenCode = ApexPages.currentPage().getParameters().get('tc');
        eid = ApexPages.currentPage().getParameters().get('eid');
        Transcript__c transcript = [Select Id,TokenCode__c from Transcript__c where TokenCode__c =:tokenCode];
 
            if(tokenCode != transcript.TokenCode__c) {
                return (new PageReference('/ST_TokenInvalid'));
            }else {
                return null;
            }
    } 
}