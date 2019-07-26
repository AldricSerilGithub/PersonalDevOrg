public with sharing class CampingListController{

    @AuraEnabled
    public static List<Camping_Item__c> getItems(){
        List<Camping_Item__c> campItemsList = new List<Camping_Item__c>();
        campItemsList = [Select Id,Name, Packed__c,Price__c, Quantity__c from Camping_Item__c];
        return campItemsList;
    }     
    
    @AuraEnabled
    public static void saveItem(Camping_Item__c items){
        upsert items;
    }
}