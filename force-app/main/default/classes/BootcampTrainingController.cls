public class BootcampTrainingController {

    public Account accountRecord {get; set;}
    public Contact contactRecord {get; set;}

    public BootcampTrainingController(ApexPages.StandardController controller) {
    
        accountRecord = new Account();
        contactRecord = new Contact();
    }
    
    public void Save(){
    
        insert accountRecord;
        
        contactRecord.AccountId = accountRecord.Id;
        
        insert contactRecord;
    
    }
    
    public void aldric(){
        System.assertEquals('Aldric Method', 'Testing');
    }

}