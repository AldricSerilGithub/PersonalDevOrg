public class launchver2 {

    public list<Contact> contak {get; set;} 
    public list<Opportunity> Oppor {get; set;}
    public list<Case> Casee {get; set;}
    public list<Account> acc {get; set;}
    
    Contact con = new Contact();
    Account accnt = new Account();
        
   public List<OpenActivity> Activ {get; set;}
   public List<ActivityHistory> ActivH {get; set;}
   public List<CombinedAttachment> Note {get; set;}
   public List<AccountPartner> Part {get; set;}
   
  
String obj;    
    

     public List<OpenActivity> getOpen()
          {
            obj = ApexPages.currentPage().getParameters().get('Id');
      
                if(obj.startsWith('001'))
                {
                  SObject[] Cuenta = [SELECT Name,(Select Subject,Description,Status,Priority FROM OpenActivities ) 
                  From Account WHERE id=:ApexPages.currentPage().getParameters().get('Id')];
                  
                  Activ = (List<OpenActivity>)Cuenta.get(0).getSObjects('OpenActivities');
                } 
        
        
          return Activ;
      }
    
    
    
    public List<ActivityHistory> getHist()
       {
            obj = ApexPages.currentPage().getParameters().get('Id');
      
            if(obj.startsWith('001'))
            {
              SObject[] Cuenta = [SELECT Name,(Select Subject,Description,Status,Priority FROM ActivityHistories )
              From Account WHERE id=:ApexPages.currentPage().getParameters().get('Id')];
              
              ActivH = (List<ActivityHistory>)Cuenta.get(0).getSObjects('ActivityHistories');
            } 
          
           return ActivH;
      }
  
    
    
      public List<CombinedAttachment> getNoteA()
          {
            obj = ApexPages.currentPage().getParameters().get('Id');
      
          if(obj.startsWith('001'))
            {
              SObject[] Cuenta = [SELECT Name,(Select title FROM CombinedAttachments )
              From Account WHERE id=:ApexPages.currentPage().getParameters().get('Id')];
              
              Note = (List<CombinedAttachment>)Cuenta.get(0).getSObjects('CombinedAttachments');
            } 
          return Note;
        
      }
  
      
      public List<AccountPartner> getPartn()
          {
            obj = ApexPages.currentPage().getParameters().get('Id');
      
          if(obj.startsWith('001'))
            {
              SObject[] Cuenta = [SELECT Name,(Select Role,AccounttoId FROM AccountPartnersFrom )
              From Account WHERE id=:ApexPages.currentPage().getParameters().get('Id')];
              
              Part = (List<AccountPartner>)Cuenta.get(0).getSObjects('AccountPartnersFrom');
            } 
          return Part;
        
      }
  
  
    

    

  
    
    
    
    public launchver2() {     
      
    String obj = ApexPages.currentPage().getParameters().get('Id');
      
      if(obj.startsWith('001'))
        {
        contak = [SELECT Name,Department,LeadSource,Title FROM Contact WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id')];
        Oppor = [SELECT Name,Amount,Type,Probability FROM Opportunity WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id')];
        casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Account.Id = :ApexPages.currentPage().getParameters().get('Id') ];
        }
   
      
      if(obj.startsWith('003'))
        {
        casee = [SELECT Reason,Status,Origin,Subject,Priority FROM Case WHERE Contact.Id = :ApexPages.currentPage().getParameters().get('Id') ];
 
        con = [SELECT AccountId FROM Contact Where Id =: ApexPages.currentPage().getParameters().get('Id')];
        accnt = [SELECT Id FROM Account Where Id =: con.AccountId];
        Oppor = [SELECT Name,Amount,Type,Probability From Opportunity WHERE Account.Id =: accnt.Id];
        }
   }

   public PageReference expdf() {
                   
        PageReference HomePage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/apex/exporttoPDF?id=' + ApexPages.currentPage().getParameters().get('Id') );
        return HomePage.setRedirect(true);
        }
       
}