public with sharing class AccountTriggerHandler {

    public AccountTriggerHandler(){
        
    }
        
    public void OnBeforeInsert(Account[] newAccounts){
        //Call your helper class
    }
    
    public void OnAfterInsert(Account[] newAccounts){
        //Call your helper class
    }
                    
                    public void OnBeforeUpdate(Map<Id, Account> oldAccountMap,  Map<Id, Account> newAccountMap){
        //Call your helper class
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