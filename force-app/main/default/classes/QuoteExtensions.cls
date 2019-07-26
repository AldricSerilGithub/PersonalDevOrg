public with sharing class QuoteExtensions {

    public List<QuoteLineItem> quotesList {get; set;}
    
    public Map<String, List<QuoteLineItem>> quoteLineItemMap {get; set;}

    public Set<String> keys {get; set;} 


    public QuoteExtensions(ApexPages.StandardSetController controller) {

        String quoteIdUrl = ApexPages.currentPage().getURL();
        
        List<String> quoteId = quoteIdUrl.split('/?Id=');
            
        quotesList = [Select ID,Product2.Name, QuoteId, Header_Level__c,UnitPrice,Quantity,Subtotal,Discount,TotalPrice,ListPrice from QuoteLineItem where QuoteId =: quoteID[1]];
        
        quoteLineItemMap = new Map<String, List<QuoteLineItem>>();
        
        keys = new Set<String>();
        
        for(QuoteLineItem quoteLineItm : quotesList ){
            if(quoteLineItemMap.containskey(quoteLineItm.Header_Level__c)){
            
                List<QuoteLineItem> quoteLnItm = quoteLineItemMap.get(quoteLineItm.Header_Level__c);
                quoteLnItm.add(quoteLineItm);
                quoteLineItemMap.put(quoteLineItm.Header_Level__c, quoteLnItm);
            }
            else{
                quoteLineItemMap.put(quoteLineItm.Header_Level__c, new List<QuoteLineItem> { quoteLineItm});
            }
            
            keys.add(quoteLineItm.Header_Level__c);
        }
        
    
    }
    
    public Pagereference editQuoteLineItemRecord(Id QuoteLineItemId, Id QuoteId){
    
        return new PageReference(QuoteLineItemId +'/e?retURL=%2F'+ QuoteId );
    }
    
    
    
    

}