public with sharing class ContactController {
    @AuraEnabled
    public static List<aldricWrapper> getContacts() {
        List<Contact> contacts = 
                [SELECT Id, Name, Phone, Email, Account.Name FROM Contact];
        //Add isAccessible() check
        List<aldricWrapper> aldricWrapperList = new List<aldricWrapper>();
        
        for(Contact contactRecord:contacts){
            aldricWrapper aldricWrapperRecord = new aldricWrapper();
            aldricWrapperRecord.contactName = contactRecord.Name;
            aldricWrapperRecord.contactPhone = contactRecord.Phone;
            aldricWrapperRecord.contactEmail = contactRecord.Email;
            aldricWrapperRecord.accountName = contactRecord.Account.Name;
            aldricWrapperList.add(aldricWrapperRecord);
        }
        
        
        return aldricWrapperList;
    }
    
    public class aldricWrapper{
        @auraEnabled
        public String contactName {get; set;}
        @auraEnabled
        public String contactPhone {get; set;}
        @auraEnabled
        public String contactEmail {get; set;}
        @auraEnabled
        public String accountName {get; set;}
    
    }
        
}