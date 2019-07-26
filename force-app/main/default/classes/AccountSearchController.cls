public class AccountSearchController {
    
    public String accountRecord {get; set;}
    public String country {get; set;}
    public String contactName {get; set;}
    public String accountType {get; set;}
    public String searchResults {get; set;}
    public List<SelectOption> accountTypeList {get; set;}
    public List<Account> accountList {get; set;}
    public List<Account> allAccounts {get; set;}
    public Map<Integer, List<Account>> accountMap {get; set;}
    public Integer pageNumber {get; set;}
    public Integer totalPage {get; set;}
    public Account accountPicklist {get; set;}

    Integer counter = 0;
    Integer page = 1;     
    Integer itemsPerPage = 10;     
    
    
    
    public AccountSearchController(){
        allAccounts = new List<Account>();
        accountMap = new Map<Integer, List<Account>>();
        accountList = new List<Account>();
        for(Account accountRec : [Select Id, BillingCountry, Type, Name, (Select Id,Name,  FirstName, LastName from Contacts) from Account]){
            counter++;
            if(counter==1 && page!=2){
                accountMap.put(page, new List<Account>{accountRec});        
            }
                 
            else if(counter<itemsPerPage){
            
                accountMap.get(page).add(accountRec);        
            }
            else{
                page++;
                accountMap.put(page, new List<Account>{accountRec});        
                counter=1;
            }
            allAccounts.add(accountRec);
            
            
        }
        accountList = accountMap.get(1);
        pageNumber=1;
        totalPage = accountMap.size();
        
    }

    public void searchButton(){
        counter = 0;
        page = 1;     
        itemsPerPage = 10;     
        accountMap = new Map<Integer, List<Account>>();
        
    
        for(account accountSearch: allAccounts){
            if((accountRecord.trim() == null || accountRecord.trim() == '') && (contactName.trim() == null || contactName.trim() == '') && (country.trim() == null || country.trim() == '')){
                addAccountRecord(accountSearch);  
            }
            
            else if( (accountRecord.trim()!=null || accountRecord.trim() != '') || (contactName.trim()!=null || contactName.trim() != '') || country!=null ){
            
                if(((accountRecord.contains('*') && accountSearch.Name.contains(accountRecord.replace('*', ''))) || accountRecord.trim() == accountSearch.Name)  && accountRecord != ''){
                    
                    if(accountSearch.BillingCountry == country.trim()){
                        if(contactName != '' && checkContact(accountSearch)){
                            addAccountRecord(accountSearch);        
                        }
                        if(contactName == ''){
                            addAccountRecord(accountSearch);    
                        }
                    }
                    
                    if(contactName != '' && checkContact(accountSearch) && country == ''){
                        addAccountRecord(accountSearch);        
                    }
                    
                    if(country == '' && contactName == ''){
                        addAccountRecord(accountSearch);    
                    }
                    
                        
                }
                else if(accountSearch.BillingCountry == country.trim()){
                    if(contactName != '' && checkContact(accountSearch)){
                        addAccountRecord(accountSearch);    
                    }
                    
                    if(contactName == ''){
                        addAccountRecord(accountSearch);    
                    }
                    
                }
                
                else if(checkContact(accountSearch)){
                    addAccountRecord(accountSearch);    
                }
                    
            }
            
        
        }
        
        accountList = accountMap.get(1);
        totalPage = accountMap.size();
        pageNumber=totalPage !=0 ? totalPage  : 0;
        
    }
    
    public boolean checkContact(Account accountSearch){
    
        for(Contact contactRecord: accountSearch.Contacts){
                
            if(contactRecord.FirstName != null){
                System.debug('Contact: ' + contactRecord.Name + ' ' +contactRecord.FirstName.trim().contains(contactName.trim()));
                if((contactName.contains('*') && contactRecord.Name.contains(contactName.replace('*', ''))) || contactName == contactRecord.Name){
                    //addAccountRecord(accountSearch);    
                    return true;
                }
            }
        } 
        return false;   
    }
    
    
    public void addAccountRecord(Account accountRec){
        counter++;
            if(counter==1 && page!=2){
                accountMap.put(page, new List<Account>{accountRec});        
            }
                 
            else if(counter<itemsPerPage){
            
                accountMap.get(page).add(accountRec);        
            }
            else{
                page++;
                accountMap.put(page, new List<Account>{accountRec});        
                counter=1;
            }
        
    
    }
    
    
    public void firstPage(){
        pageNumber = 1;
        accountList = accountMap.get(pageNumber);    
    }
    
    public void nextPage(){
        pageNumber++;
        accountList = accountMap.get(pageNumber);
        
    }
    
    public void previousPage(){
        pageNumber--;
        accountList = accountMap.get(pageNumber);
    }
    
    public void lastPage(){
        pageNumber = accountMap.size();
        accountList = accountMap.get(pageNumber);    
    } 

}