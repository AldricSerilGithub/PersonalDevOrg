public class MyBootcampJuly {
    
    public List<contactAccount> contactAccountList {get; set;}
   
    public MyBootcampJuly(){
        contactAccountList = new List<contactAccount>();
        for(Account accountRec : [Select Id, Name, BillingCity, (Select Id, FirstName, LastName from Contacts) from Account]){
            contactAccount contactAccountRecord = new contactAccount();
            contactAccountRecord.Name = accountRec.Name;
            contactAccountRecord.accountRec = accountRec;
            if(accountRec.Contacts.size()>0){
               contactAccountRecord.contactRec = new List<Contact>();
               contactAccountRecord.contactRec.addAll(accountRec.Contacts);
            }
            contactAccountList.add(contactAccountRecord); 
        }    
    }
   
    public String getName(){
        return ApexPages.currentPage().getParameters().get('bootcamp');
    }
    
    public Position__c getPositions(){
        Position__c positionRec = [Select Id, Name, Owner.FirstName
                                        FROM Position__c
                                        WHERE ID = : ApexPages.currentPage().getParameters().get('Id')];
        return positionRec;
    }
    
    
    public String userInputName {get; set;}
    
    
    public pagereference checkInput(){
        List<String> selectAccount = new List<String>();
        for(contactAccount recordWrapper : contactAccountList ){
            if(recordWrapper.isChecked){
                selectAccount.add(recordWrapper.Name);
            }
        }
        System.assertNotequals(selectAccount,selectAccount);
        return null;
    }
    
    public class contactAccount{
        public String name{get; set;}
        public Boolean isChecked{get; set;}
        public Account accountRec{get; set;}
        public List<Contact> contactRec {get; set;}
    }
    
}