public class sampleController {
	
    @AuraEnabled
    public static Account getAccount(String name){
       return [Select Id, Name from Account WHERE Name = : name LIMIT 1]; 
    }
    
}