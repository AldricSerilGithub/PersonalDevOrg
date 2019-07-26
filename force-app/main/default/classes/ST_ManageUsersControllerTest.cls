/**
   @Author: Edwin Reyes
   @Name: ST_ManageUsersControllerTest
   @CreateDate: 2/11/2015
   @Description: For testing purposes
   @Version 1.0
*/

@isTest 
private class ST_ManageUsersControllerTest {

    /*
    *  Execution method
    *  @name: manageUsersControllerTest
    *  @param: none
    *  @return: void
    *  @throws: exception none
    */
    static testMethod void manageUsersControllerTest() {
        
        /*****************CREATE RECORDS HERE*******************/
         
        //Create transcriptList record
        List<Transcript__c> transcriptList= new List<Transcript__c>();
        
        for(Integer i=1; i<=200; i++) {     
               
            Transcript__c transcript= new Transcript__c();            
            Decimal moduloCount = Math.mod(i, 4);     
                   
            if(moduloCount == 0) {  
                transcript.Email__c = 'a.'+i+'.b.c.saastest@accenture.com';
                transcript.Survey_Type__c = 'surveyType'+moduloCount;
                transcript.Examinee_Type__c = 'Certification';
            } else if(moduloCount == 1) {
                transcript.Email__c = 'a.'+i+'.b.c.saastest@accenture.com';
                transcript.Survey_Type__c = 'surveyType'+moduloCount;
                transcript.Examinee_Type__c = 'Boot Camp';           
            } else if(moduloCount == 2) {
                transcript.Email__c = 'a.'+i+'.b.c.saastest@accenture.com';
                transcript.Survey_Type__c = 'surveyType'+moduloCount;
                transcript.Examinee_Type__c = 'CAMS Questionnaire';            
            } else{
                transcript.Email__c = 'a.'+i+'.b.c.saastest@accenture.com';
                transcript.Survey_Type__c = 'surveyType'+moduloCount;
                transcript.Examinee_Type__c = 'Survey Questionnaire';            
            }   
                     
            transcriptList.add(transcript);
        }  
              
        insert transcriptList; 

        //Create surveyTypesList record
        List<Survey_Types__c> surveyTypesList = new List<Survey_Types__c>();
        
        for(Integer i=1; i<=200; i++) {     
               
            Survey_Types__c surveyTypes = new Survey_Types__c();            
            Decimal moduloCount = Math.mod(i, 4);     
                   
            if(moduloCount == 0) {  
                surveyTypes.Description__c = 'Description'+i;
                surveyTypes.Name = 'Survey Name '+i;
            } else if(moduloCount == 1) {          
                surveyTypes.Description__c = 'Description'+i;
                surveyTypes.Name = 'Survey Name '+i;
            } else if(moduloCount == 2) {   
                surveyTypes.Description__c = 'Description'+i;
                surveyTypes.Name = 'Survey Name '+i;
            } else{  
                surveyTypes.Description__c = 'Description'+i;
                surveyTypes.Name = 'Survey Name '+i;
            }   
                     
            surveyTypesList.add(surveyTypes);
        }  
              
        insert surveyTypesList; 

        /*****************START TEST HERE*******************/
        Test.startTest();
        
        PageReference currentPage = new PageReference('/apex/ST_ManageUsers');
        Test.setCurrentPage(currentPage);
        
        ST_ManageUsersController manageUsersController= new ST_ManageUsersController();
        
        System.assertEquals(manageUsersController.transcriptList.size(),manageUsersController.transcriptMap.size());
        
        manageUsersController.selectedTranscript = transcriptList.get(2).Email__c;
        manageUsersController.selectedTypes = surveyTypesList.get(2).Name;
        
        manageUsersController.updateTranscript();
        manageUsersController.updateAll();
        
        //For DMLException
        manageUsersController.transcriptMap.get(transcriptList.get(2).Email__c).Email__c = 'test';
        manageUsersController.updateAll();
        
        Test.stopTest();  

    }
    


}