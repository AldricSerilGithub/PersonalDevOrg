@isTest(SeeAllData=true) 
public class SaveButtonTest {

    static testMethod void LoginTime(){

        Test.startTest(); 
       	
        PageReference pageRef = Page.table;
        Test.setCurrentPage(pageRef);
        
        SaveButton SB = new SaveButton(null);
        SB.save();
    }    
}