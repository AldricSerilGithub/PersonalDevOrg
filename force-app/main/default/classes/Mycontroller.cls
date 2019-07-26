public class Mycontroller {
    public list<Contact> contak {get; set;} 
    public list<Opportunity> Oppor {get; set;}
    public list<Case> Casee {get; set;}
    public list<Login__c> po {get; set;}
   
    public string objec {get; set;}
    
    
    public Mycontroller() {     
      
    String obj = ApexPages.currentPage().getParameters().get('Id');
      
      if(obj.startsWith('001'))
        {
        objec = 'Account';
        contak = [SELECT Name,Department,LeadSource,Title FROM Contact WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id')];
        Oppor = [SELECT Name,Amount,Type,Probability FROM Opportunity WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id')];
        casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id') ];
        }
   
      
      if(obj.startsWith('003'))
        {
         objec = 'Contact';
        casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Contact.Id = :ApexPages.currentPage().getParameters().get('Id') ];
        }
  /*      
      if(obj.startsWith('a00'))
      {
       objec = 'Login';
       po = [SELECT Timein__c,Timeout__c,Total_Hours__c,Status__c,Over_Time__c,Under_Time__c FROM Login__c WHERE ownerID =: UserInfo.getUserId() ORDER BY Timein__c DESC NULLS LAST LIMIT 15];
      }  
    */    
   }

   public PageReference expdf() {
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/apex/exporttoPDF?id=' + ApexPages.currentPage().getParameters().get('Id') );
        return HomePage.setRedirect(true);
        }

}