trigger AccountTriggers on Account (after update, Before Insert) {

    if(Trigger.isUpdate && Trigger.isAfter){
        /*
        List<Contact> contactList = new List<Contact>();
        contactList = [Select Id, AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry from Contact where AccountId IN: Trigger.New];  
        
        for(Contact contactRecord : contactList){
            if(Trigger.NewMap.Containskey(contactRecord.AccountId)){
                contactRecord.MailingStreet = Trigger.NewMap.get(contactRecord.AccountId).BillingStreet;
                contactRecord.MailingCity = Trigger.NewMap.get(contactRecord.AccountId).BillingCity;
                contactRecord.MailingState = Trigger.NewMap.get(contactRecord.AccountId).BillingState;
                contactRecord.MailingPostalCode = Trigger.NewMap.get(contactRecord.AccountId).BillingPostalCode;
                contactRecord.MailingCountry = Trigger.NewMap.get(contactRecord.AccountId).BillingCountry;
            }
        }
        
        update contactList;
        */
        AccountTriggerHandler1.updateAccount(trigger.NewMap);    
    }

}