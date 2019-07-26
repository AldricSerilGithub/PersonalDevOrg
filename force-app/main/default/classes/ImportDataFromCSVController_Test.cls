/**
   @Author Lovely Aquino
   @name ImportDataFromCSVController_Test
   @CreateDate 02/11/2015
   @Description Test the functionalities involved
		in Importing, Upserting, and Deleting data/record(Set of Questions)
		in Question__c(Custom Object) through CSV.
   @Version 1.0
   @reference ImportDataFromCSVController
  */
@isTest
private class ImportDataFromCSVController_Test{
    
    static testMethod void testImportCSVFile(){
        
        String csvLine1 = 'QUESTION,CHOICE A,CHOICE B,CHOICE C,CHOICE D,CHOICE E,ExamSet,IsMultiple';
        String csvLine2 = 'question 1,A,B,C,D,E,Questionnaire Name,TRUE';
        String csvLine3 = 'question 2,A,B,C,D,E,Questionnaire Name,TRUE';
        
        String csvBlobStr = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine3;
        
        Blob csvBlob = Blob.valueOf(csvBlobStr);

        Test.startTest();
        
        ImportDataFromCSVController importDataController = new ImportDataFromCSVController();
        
        //When no file is imported,
        //show error message in VF page
        importDataController.importCSVFile();
        
        System.assertEquals(0, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(0,[SELECT COUNT() FROM Survey_Types__c]);
        
        //When there is no error in the file imported,
        //insert List<Questions__c>
        //insert List<Survey_Type__c>
        importDataController.CsvFileBody = csvBlob;
        importDataController.importCSVFile();
        
        System.assertEquals(2, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(1,[SELECT COUNT() FROM Survey_Types__c]);

        Test.stopTest();
    }
    
    static testMethod void testDeleteCSVFile(){
        
        String csvLine1 = 'QUESTION,CHOICE A,CHOICE B,CHOICE C,CHOICE D,CHOICE E,ExamSet,IsMultiple';
        String csvLine2 = 'question 1,A,B,C,D,E,Questionnaire Name,TRUE';
        String csvLine3 = 'question 2,A,B,C,D,E,Questionnaire Name,TRUE';
        
        String csvBlobStr = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine3;
      
        Test.startTest();
        
        Blob csvBlob = Blob.valueOf(csvBlobStr);
        
        ImportDataFromCSVController importDataController = new ImportDataFromCSVController();
        importDataController.CsvFileBody = csvBlob;
       
        //When the rows in the file to be deleted does not exist
        importDataController.deleteCSVFile();
        
        //When the rows in the file to be deleted exist
        importDataController.importCSVFile();
        importDataController.deleteCSVFile();
        
        System.assertEquals(0, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(1,[SELECT COUNT() FROM Survey_Types__c]);
        
	    Test.stopTest();
    }

    static testMethod void testUpsertCSVFile(){
        
        String csvLine1 = 'QUESTION,CHOICE A,CHOICE B,CHOICE C,CHOICE D,CHOICE E,ExamSet,IsMultiple';
        String csvLine2 = 'question 1,A,B,C,D,E,Questionnaire Name,TRUE';
        String csvLine3 = 'question 2,A,B,C,D,E,Questionnaire Name,TRUE';
        String csvLine4 = 'question 3,A,B,C,D,E,Questionnaire Name,TRUE';
        String csvLine5 = 'question 3,A,B,C,D,E,QN,TRUE';
        
        String csvBlobStr = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine3;
        String csvBlobStr2 = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine4;
        String csvBlobStr3 = csvLine1 + '\r\n' + csvLine5;
        
        Blob csvBlob = Blob.valueOf(csvBlobStr);
        Blob csvBlob2 = Blob.valueOf(csvBlobStr2);
        Blob csvBlob3 = Blob.valueOf(csvBlobStr3);
      
        Test.startTest();
        
        ImportDataFromCSVController importDataController = new ImportDataFromCSVController();
        
        //No file, show error message in VF page
        importDataController.upsertCSVFile();
        System.assertEquals(0, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(0,[SELECT COUNT() FROM Survey_Types__c]);
        
        //All rows do not exist, show error message in VF page
        importDataController.csvAsString = csvBlobStr;
        importDataController.csvFileBody = csvBlob;
        importDataController.upsertCSVFile();
        System.assertEquals(0, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(0,[SELECT COUNT() FROM Survey_Types__c]);
        
        //Mix update and insert
        //with one row 
        importDataController.csvFileBody = csvBlob;
        importDataController.importCSVFile();
        
        importDataController.CsvFileBody = csvBlob2;
        importDataController.csvAsString = csvBlobStr2;
        importDataController.upsertCSVFile();
        
        System.assertEquals(3, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(1,[SELECT COUNT() FROM Survey_Types__c]);
        
        //Mix update and insert
        //no existing Exam_Set__c
        importDataController.CsvFileBody = csvBlob3;
        importDataController.csvAsString = csvBlobStr3;
        importDataController.upsertCSVFile();
        
        System.assertEquals(3, [SELECT COUNT() FROM Question__c]);
        System.assertEquals(1,[SELECT COUNT() FROM Survey_Types__c]);
        
	    Test.stopTest();
    }
}