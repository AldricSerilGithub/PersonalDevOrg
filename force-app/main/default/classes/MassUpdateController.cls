public class MassUpdateController {

    public List<Account> accountList {get; set;}

    public MassUpdateController(){
    
        accountList = new List<Account>();
        accountList = [Select Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry from Account];
    
    }
    
    public void Save(){
    
        Upsert accountList;
        
    }
    
    public pagereference cancel(){
        
        PageReference homePage = new PageReference('/home/home.jsp');
        homePage.setRedirect(true);
        return homePage;
    }
    
}