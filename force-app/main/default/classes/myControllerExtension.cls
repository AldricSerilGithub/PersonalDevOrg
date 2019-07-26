public class myControllerExtension {

    public list<Account> acct {get; set;} 
    public list<Contact> contak {get; set;} 
    public list<Case> casee {get; set;}
    public list<Campaign> camp {get; set;} 
    public list<Lead> Lea {get; set;}  
    public list<Opportunity> Oppor {get; set;}  

       
    public myControllerExtension(ApexPages.StandardController stdController) {
        
        acct = [SELECT Name,AccountNumber,Industry,Type,Rating,Ownership FROM Account ];
        contak = [SELECT Name,Department,LeadSource,Title FROM Contact];
        casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case];
        camp = [SELECT Name,Type,Status,StartDate,EndDate FROM Campaign];
        Lea = [SELECT Name,Company,Status,Title FROM Lead];
        Oppor = [SELECT Name,Amount,Type,Probability FROM Opportunity];
    }

        public PageReference Custom() {   
        PageReference GeneratPage = new PageReference('/apex/launchView');
        return GeneratPage.setRedirect(true);
    }


     public ID AcctId { get; set; }
     public ID contakId { get; set; }
     public ID casesId { get; set; }
     public ID campID {get; set;}
     public ID LeaID {get; set;}
     public ID OpporID {get; set;}
 
     
     public PageReference Accts() {
        Account Accti = [SELECT Name FROM Account WHERE Id=:AcctID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + Accti.id);
        return HomePage.setRedirect(true);
        }


    public PageReference contaks() {
        Contact contaki = [SELECT Name FROM Contact WHERE Id=:contakID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + contaki.id);
        return HomePage.setRedirect(true);
        }
    
    
    public PageReference cases() {
        Case casei = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Id=:casesID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + casei.id);
        return HomePage.setRedirect(true);
        }

    
       public PageReference camps() {
        Campaign campi = [SELECT Name FROM Campaign WHERE Id=:campID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + campi.id);
        return HomePage.setRedirect(true);
        }

       public PageReference Leas() {
        Lead leadi = [SELECT Name FROM Lead WHERE Id=:LeaID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + leadi.id);
        return HomePage.setRedirect(true);
        }
        
        
        public PageReference Oppors() {
        Opportunity Oppori = [SELECT Name FROM Opportunity WHERE Id=:OpporID Limit 1];
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/' + Oppori.id);
        return HomePage.setRedirect(true);
        }
     
}