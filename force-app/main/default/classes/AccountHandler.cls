public class AccountHandler {

    public static Account insertNewAccount(String insertString){
        
        Account newAccount = new Account();
        newAccount.Name = insertString;
        
        try{
        	insert newAccount;
        }catch(exception e){
            return null;
        }
        return newAccount;
        
    }
}