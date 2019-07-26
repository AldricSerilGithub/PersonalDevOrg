public class LogoutUpdate {


    public LogoutUpdate(ApexPages.StandardController controller) {
  }         
                    
     public PageReference Lout() {
        
           for(Login__c accountToUpdate: [SELECT Timeout__c FROM Login__c WHERE Timeout__c = null and ownerID =: UserInfo.getUserId()])
           {
           accountToUpdate.Timeout__c = Datetime.now();
                   
           update accountToUpdate;
           }
                   
        PageReference HomePage = new PageReference('/apex/table');
        return HomePage.setRedirect(true);
        }     
     
     public PageReference Gener() {   
        PageReference GeneratPage = new PageReference('/apex/generat');
        return GeneratPage.setRedirect(true);
        }
            
}