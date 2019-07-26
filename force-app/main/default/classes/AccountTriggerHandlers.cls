public with sharing class AccountTriggerHandlers {

accountHelper helper= new accountHelper();
    public AccountTriggerHandlers(){
        
    }
        
    public void OnBeforeInsert(Account[] newAccounts){
        //Call your helper class
    }
    
    public void OnAfterInsert(Account[] newAccounts){
        //Call your helper class
    }
                    
    public void OnBeforeUpdate(Map<Id, Account> oldAccountMap,  Map<Id, Account> newAccountMap){
         //helper.CheckBilling(oldAccountMap.values());
         
         Set<String> accountName = new Set<String>();
         Map<String, Id> accountMap = new Map<String, Id>();
         
         for(Account accountRec : newAccountMap.values()){
             if(newAccountMap.get(accountRec.Id).Name != oldAccountMap.get(accountRec.Id).Name){
                 accountName.add(accountRec.name);
             }
             accountMap.put(accountRec.Name, accountRec.Id);
         }
         Set<String> accountSet = new Set<String>();
         
         for(Account accountRec: [Select Id, Name from Account where Name IN: accountMap.keyset()]){
             accountSet.add(accountRec.Name);
         }
         
         for(Account accountRec : newAccountMap.values()){
             if(accountSet.contains(accountRec.Name)){
                 //accountRec.addError('The Account Name Exist');
             }
             
         }
         
         List<Account> newAccountList = new List<Account>();
         
         for(Account newAccountRec : (List<Account>)Trigger.new){
             newAccountList.add(newAccountRec);
         }
         
         for(Account newAccRec : newAccountList){
             //newAccRec.name = 'Testing this Account';
         }
         
         
         
         
    }
    
    public void OnAfterUpdate(Map<Id, Account> oldAccountMap,  Map<Id, Account> newAccountMap){
        //Call your helper class
    }
    
    
    public void OnBeforeDelete(Account[] accountsToDelete, Map<ID, Account> accountMap){
                                       //Call your helper class
    }
    
    public void OnAfterDelete(Account[] deletedAccounts, Map<ID, Account> accountMap){
        //Call your helper class
    }
    
    
    public void OnUndelete(Account[] restoredAccounts){
        
    }
    
}