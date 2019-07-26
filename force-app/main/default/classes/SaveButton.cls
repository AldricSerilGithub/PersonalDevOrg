public with sharing class SaveButton {
   
    public SaveButton(ApexPages.StandardController sc) {
    }
    
    public PageReference save() {
             Login__c con = new Login__c();
             insert con;
             
            PageReference HomePage = new PageReference('/apex/table');
            return HomePage.setRedirect(true);
    }
                    
}