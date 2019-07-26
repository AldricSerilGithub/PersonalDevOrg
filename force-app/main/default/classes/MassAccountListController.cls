public class MassAccountListController {

    @AuraEnabled
    public Static List<Account> getAccountList(){
    	return [Select Id, Name, Industry, Type, Phone from Account order by createddate];    
    
    }
    
    @AuraEnabled
    public Static List<String> getTypePicklist(){
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
   
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		List<String> picklistType = new List<String>();
        for( Schema.PicklistEntry f : ple)
   		{
      		picklistType.add(f.getValue());
   		}       

        return picklistType;        

    }
    
    @AuraEnabled
    public Static List<String> getIndustryPicklist(){
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
   
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		List<String> picklistIndustry = new List<String>();
        for( Schema.PicklistEntry f : ple)
   		{
      		picklistIndustry.add(f.getValue());
   		}       

        return picklistIndustry;        

    }
    
    @AuraEnabled
    public Static String insertAccountList(String AccountLists){
        System.debug(AccountLists);
        List<Account> accountList = (List<Account>)JSON.deserialize(AccountLists, List<Account>.class);
        System.debug(accountList);
        try{
            upsert accountList;
            
            return 'Inserted Successfully';
        }catch(exception ex){
        	System.debug('Aldric' + ex.getMessage());
            return ex.getMessage();
        }
        
    }
    
    @AuraEnabled
    public Static String deleteAccountList(String AccountLists){
        List<Account> accountList = (List<Account>)JSON.deserialize(AccountLists, List<Account>.class);
        System.debug(accountList);
        try{
            List<ID> accountID = new List<ID>();
            List<Account> deleteAccountLists = new List<Account>(); 
            for(Account acc : accountList){
                accountID.add(acc.id);
            }
            deleteAccountLists = [Select ID, Name from account where ID NOT IN:accountID];
			System.debug(deleteAccountLists);
            if(deleteAccountLists.size()>0){
                delete deleteAccountLists;
            }
             
            return 'Deleted Successfully';
        }catch(exception ex){
            return ex.getMessage();
        }
        
    }
    
}