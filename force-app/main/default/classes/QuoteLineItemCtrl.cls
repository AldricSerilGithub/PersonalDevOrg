public with sharing class QuoteLineItemCtrl {
    
// variables

public List<QuoteLineItem> lstQuoteLineItems {get; set;}
public List<quotelineItemHeaderClass> lstquotelineItemHeaderClass {get; set;}
public List<Quote_Line_Item_Header__c> lstquotelineitemheader {get; set;}
public Set<String> headerLevel;
public Map<String, List<QuotelineItem>> headerLineItemMap {get; set;}
public List<String> lstPickvals {get; set;}
public Id quoteId {get; set;}

public quotelineItemHeaderClass quotelineItemHeaderClassInstance {get; set;}

public QuoteLineItemCtrl(ApexPages.StandardController stdController) {

    //public QuoteLineItemCtrl(){
        Quote quote = (Quote)stdController.getrecord();
        quoteId = quote.Id;

       lstQuoteLineItems = [SELECT QuoteId,Id,Product2.Name,Product2.Id,UnitPrice, Quantity, Subtotal, Discount, TotalPrice, ListPrice ,Header_Level__c FROM QuoteLineItem WHERE QuoteId =:  quoteId];
       

        lstquotelineitemheader = [SELECT Header_Level__c, Item_Price__c, Quantity__c FROM Quote_Line_Item_Header__c WHERE   Quote_Name__c =: quoteId];
        
        Map<String,List<QuoteLineItem >> quoteLineItemMap = new Map<String,List<QuoteLineItem>>();

        Set<String> headerLevels = new Set<String>();
        
        for(QuoteLineItem qLIHeader : lstQuoteLineItems ){
            if(!quoteLineItemMap.containskey(qLIHeader.Header_Level__c)){
                quoteLineItemMap.put(qLIHeader.Header_Level__c,new List<QuoteLineItem>{qLIHeader});
            }
            
            else{
                quoteLineItemMap.get(qLIHeader.Header_Level__c).add(qLIHeader);
            }
        }
        
        Map<String, Quote_Line_Item_Header__c > quoteLineItemHeaderMap = new Map<String, Quote_Line_Item_Header__c >();
        
        for(Quote_Line_Item_Header__c quoteLineItemHeaders :lstquotelineitemheader ){
            quoteLineItemHeaderMap.put(quoteLineItemHeaders.Header_Level__c, quoteLineItemHeaders);
        }
       
       lstquotelineItemHeaderClass = new List<quotelineItemHeaderClass>();
       
       
       for(String quoteLineItemHeader : quoteLineItemMap.Keyset()){
       
           quotelineItemHeaderClassInstance = new quotelineItemHeaderClass();    
           quotelineItemHeaderClassInstance.HeaderName = quoteLineItemHeader;
           if(quoteLineItemHeaderMap.containskey(quoteLineItemHeader)){
               quotelineItemHeaderClassInstance.HeaderQty = quoteLineItemHeaderMap.get(quoteLineItemHeader).Quantity__c;
               quotelineItemHeaderClassInstance.HeaderTotalItemPrice = quoteLineItemHeaderMap.get(quoteLineItemHeader).Item_Price__c;
           }
           else{
               quotelineItemHeaderClassInstance.HeaderQty = 0;
               quotelineItemHeaderClassInstance.HeaderTotalItemPrice = 0;
           }    
           
           quotelineItemHeaderClassInstance.lstQuoteLineItem = quoteLineItemMap.get(quoteLineItemHeader);
           lstquotelineItemHeaderClass.add(quotelineItemHeaderClassInstance);
       }
                                                          
     }
     
     public class quotelineItemHeaderClass {
               public String HeaderName {get;set;}
               public Decimal HeaderQty{get;set;}
               public Decimal HeaderTotalItemPrice{get;set;}
               public List<QuoteLineItem> lstQuoteLineItem{get;set;}
               
        
    }


}