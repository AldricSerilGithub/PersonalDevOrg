public class Objectrecords{

public Objectrecords(ApexPages.StandardController controller) {
            Login = [SELECT Timein__c,Timeout__c,Total_Hours__c,Status__c,Over_Time__c,Under_Time__c 
            FROM Login__c WHERE ownerID =: UserInfo.getUserId() ORDER BY Timein__c DESC NULLS LAST LIMIT 15];
       } 


    public List<Login__c> Login { get; set; }     
    public ID LoginId { get; set; }    
     
    public PageReference Logins() {
        Login__c Logini = [SELECT Id FROM Login__c WHERE Id=:LoginID and ownerID =: UserInfo.getUserId() LIMIT 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + Logini.id);
        return HomePage.setRedirect(true);
        }
        
    public PageReference Stand() {   
        PageReference GeneratPage = new PageReference('/apex/launch2');
        return GeneratPage.setRedirect(true);
    }
}