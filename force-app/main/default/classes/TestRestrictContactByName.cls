@isTest
private class TestRestrictContactByName{

    @isTest static void testInsert(){
        Contact d = new Contact(
        LastName = 'INVALIDNAME',
        FirstName = 'Error'
        );
        
        Test.Starttest();
        
        try{
             insert d;
        }
        catch(exception e){
            test.stoptest();
        }
        
    }


}