public class serverController {

    @auraEnabled
    public static List<Account> accountList(){
        return [Select Id, Name, BillingCity from Account ];
        
    }
    
}