public class exchangeGiftController {

    public ExchangeGift__c ExChan {get; set;}
    public String DesiredGift {get; set;}
    public String emailAddress {get; set;}
    public exchangeGiftController(ApexPages.StandardController controller) {

    list<exchangegift__c> nameList = new list<exchangeGift__c>();
        ExChan = new ExchangeGift__c();
        emailAddress = ApexPages.currentPage().getParameters().get('Id');
        nameList  = [select id, name,email__c,full_name__c,request_gift__c from exchangeGift__c where Id =: emailAddress];
       
        ExChan.full_Name__c = nameList[0].full_name__c;
        ExChan.email__c = nameList[0].email__C;
        ExChan.request_gift__c = nameList[0].request_gift__c;

    }
    
    public void saveRecord(){
        list<exchangegift__c> saveList  = [select id, name,email__c,full_name__c,request_gift__c from exchangeGift__c where Id =: emailAddress ];
        savelist[0].request_gift__c = ExChan.request_gift__c;
        savelist[0].email__c = ExChan.email__c;
        
        if(ExChan.email__c  == null && ExChan.request_gift__c!= null &&  ExChan.full_name__c!= null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
        }
        if(savelist.size()>0){
            update savelist; 
              ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Saved! You can still update your email and wish list'));   
        }
    
    }
    
    
    public PageReference namePick(){
        PageReference redirectPage = new PageReference('/apex/ExchangeGiftPicker?Id='+emailAddress);
        return redirectPage.setRedirect(true);    
    }
    
    
    


    
    

}