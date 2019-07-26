public class RandomContactFactory{

    public static list<contact> generateRandomContacts(integer numofContacts, String LastNameGen){
        List<Contact> con = new List<Contact>();
        for(integer i=0; i<numofContacts; i++){
        
            LastNameGen = 'Test'+ i;
            Contact a = new Contact(FirstName = LastNameGen, LastName = LastNameGen);
            con.add(a);
        }
        return con;
    
    
    }


}