public class MySecondController {


    public String getName(){
        return 'MyController';
    }
    
    public Position__c getPositions(){
        Position__c positionRec = [Select Id, Name, Owner.FirstName
                                        FROM Position__c
                                        WHERE ID = : ApexPages.currentPage().getParameters().get('Id')];
        return positionRec;
    }

}