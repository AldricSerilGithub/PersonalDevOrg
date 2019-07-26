public with sharing class AldricPageController {

    public List<AldricWrapper> aldricWrapperList{get; set;}
    public List<Account> accountList {get;set;}
    
    public class AldricWrapper{
        public Boolean selected {get; set;}
        public Account accountRecord {get; set;}
        public List<Contact> contactList {get; set;}    
    }

    public AldricPageController(){
        aldricWrapperList = new List<AldricWrapper>();
        List<Contact> accountContacts = new List<Contact>();
        
        Map<Id, List<Contact>> contactMap = new Map<Id,List<Contact>>();
        
        for(Contact contactRecord: [Select Id, FirstName, AccountId from Contact ]){
            if(contactMap.Containskey(contactRecord.AccountId)){
                contactMap.get(contactRecord.AccountId).add(contactRecord);                
            }
            else{
                contactMap.put(contactRecord.accountId, new List<Contact>{contactRecord});
            }
        }
        
        for(Account accountRec : [Select Id, Name from Account]){
            AldricWrapper aldricWrapperRecord = new AldricWrapper();
                aldricWrapperRecord.selected = False;
                aldricWrapperRecord.accountRecord = accountRec;
                aldricWrapperRecord.contactList = contactMap.get(accountRec.ID);
            aldricWrapperList.add(aldricWrapperRecord);    
        }
        
        
        
    

}


public void selectedAccount(){
     accountList = new List<Account>();
     
     for(AldricWrapper aldricWrapRecord : aldricWrapperList){
         if(aldricWrapRecord.selected){
             accountList.add(aldricWrapRecord.accountRecord);
         }
     
     }


}


}