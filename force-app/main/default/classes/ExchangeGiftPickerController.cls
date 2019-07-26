public with sharing class ExchangeGiftPickerController {

    public ID pickerID {get; set;}
    public exchangeGift__c exChange {get; set;}


    public ExchangeGiftPickerController(ApexPages.StandardController controller) {
        pickerID = ApexPages.currentPage().getParameters().get('Id');
        exChange = [select id, name,exchangeGift__r.request_gift__c, exchangeGift__r.full_name__c from exchangeGift__c where Id =: pickerID limit 1];
        

    }


    
    public String getNamePick(){
    
        
        pickerID = ApexPages.currentPage().getParameters().get('Id');
        exchangeGift__c exChanges = [select id, name,exchangeGift__r.request_gift__c, exchangeGift__r.full_name__c from exchangeGift__c where Id =: pickerID limit 1];
        String finalName =  exChanges.exchangeGift__r.full_name__c;
        //String pickName = 'John Aldric Seril';
        
        return finalName;
    }


}