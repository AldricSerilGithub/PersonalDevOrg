public class GetterAndSetterSample {

    public Account accountRecord {get; set;}
    public List<Account> accountList {get; set;}
    /*
    public List<Account> getAccountList(){
        return [Select Id, Name from Account];
    
    }*/
    
    
    
    public GetterAndSetterSample (){
        accountRecord = new Account();
        accountList = [Select Id, Name from account];
    }
    
    public String getFirstName(){
       return UserInfo.getFirstName() ;
     }
    
    public void saveButton(){
        System.debug('Account Name: ' + accountRecord.Name);
        System.assertEquals('Aldric', accountRecord.Name);
    }
    


}