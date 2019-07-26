public class ContactSearch {
    public Static List<Contact> searchForContacts(String lastName, String postalCode){
        
        List<Contact> contactList = new List<Contact>();
        contactList = [Select Id, LastName from Contact where LastName =: lastName AND MailingPostalCode = :postalCode];
        
        return contactList;
    }
}