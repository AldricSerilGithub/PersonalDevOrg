public with sharing class AldricsPageController {

    public String surname {get; set;}

    public String getName(){
        String urlId = ApexPages.currentPage().getParameters().get('ID');
        return urlId;
    }
    
    public Account getAccounts(){
        Account accountRecord = [Select Id, Name from Account LIMIT 1];
        return accountRecord;
    }
    
    public void result(){
        //System.assertNotEquals(surname ,surname);
        Account accountRecord = new Account();
        accountRecord.Name = surname;
        insert accountRecord;
    }
    
    public pageReference redirectToAnother(){
        pagereference pageref = new pagereference('http://google.com');
        pageref.setRedirect(true);
        return pageref;
    
    }
    
    

}