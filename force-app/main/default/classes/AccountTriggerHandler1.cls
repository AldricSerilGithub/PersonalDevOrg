public class AccountTriggerHandler1 {

    public static void updateAccount(Map<Id,Account> accountMap){
    
        List<Contact> contactList = new List<Contact>();
        contactList = [Select Id, AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry from Contact where AccountId IN: accountMap.keyset()];  
        
        for(Contact contactRecord : contactList){
            if(accountMap.Containskey(contactRecord.AccountId)){
                contactRecord.MailingStreet = accountMap.get(contactRecord.AccountId).BillingStreet;
                contactRecord.MailingCity = accountMap.get(contactRecord.AccountId).BillingCity;
                contactRecord.MailingState = accountMap.get(contactRecord.AccountId).BillingState;
                contactRecord.MailingPostalCode = accountMap.get(contactRecord.AccountId).BillingPostalCode;
                contactRecord.MailingCountry = accountMap.get(contactRecord.AccountId).BillingCountry;
            }
        }
        
        update contactList;
    }

}