public class NewCaseListController {

    public List<Case> getNewCases(){
    
        List<Case> results = Database.query(
        'Select Id, CaseNumber, Status ' + 
        'From Case ' + 
        'WHERE STATUS = \'New\''
        );
        return results;
    }

}