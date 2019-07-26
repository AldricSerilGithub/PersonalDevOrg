public class BootcampLightningController {
    
    @auraEnabled
    public static string insertContact(String firstName, String lastName){
        
        Contact contactRecord = new Contact();
        contactRecord.FirstName = firstName;
        contactRecord.LastName = lastName;
        
        insert contactRecord;
            
        return contactRecord.Id;
    }

}