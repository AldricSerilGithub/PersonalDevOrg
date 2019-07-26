global class ExchangeGiftRandom implements Database.Batchable<sObject>{


  
   global Database.QueryLocator start(Database.BatchableContext BC){
      
      String query = 'Select ID, Name, Tagged__c, ExchangeGift__c from ExchangeGift__c';
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<ExchangeGift__c> exChanList){
     
       Integer counter = exChanList.size();
       Integer Ii;
       ExchangeGift__c tempExchan = exChanList[0];    
       List<ExchangeGift__c> updateExchange = new List<ExchangeGift__c>();
       Integer holder = 0;
       
       for(Integer i = 0 ;counter>i ; ){   
           Ii = Math.round(Math.floor(Math.random() * counter));
           
           if(tempExchan.Id != exChanList[Ii].Id && !exChanList[Ii].tagged__c){
               //tempExchan.tagged__c = true;
               //tempExchan.ExchangeGift__c = exChanList[Ii].Id;
               //updateExchange.add(tempExchan);
               tempExchan = exChanList[Ii];
               exChanList[holder].tagged__c = true;
               exChanList[holder].ExchangeGift__c = exChanList[Ii].Id;
               holder = Ii;
               
               i++; 
               System.debug('hello.....'+ i + counter );       
           }
           
           if(i==(counter-1)){
               exChanList[holder].tagged__c = true;
               exChanList[holder].ExchangeGift__c = exChanList[0].id;
               i++;
           }
           
           System.debug('hello.out'+ i);
       }
        
       update exChanList;
   }

   global void finish(Database.BatchableContext BC){
   }
}