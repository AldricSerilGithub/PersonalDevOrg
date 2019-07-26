/*
 *       author: Donette Litan
 *       created date: February 1,2018
 *       description: test data factory
 *       history: January 31,2018 Donette Litan - Created
 *                                                
*/

@isTest
public class TestDataFactory{
    public static List<Account> createAccountTestData(Integer j) 
    {
        List<Account> accts = new List<Account>();
        for(Integer i=1;i<=j;i++) 
        {
            Account ListOfNewAccount = new Account(Name='ABCD Company ' + i, BillingStreet = 'Orchard ' + i
                                   , BillingCountry = 'US', BillingCity = 'Alaska' + i
                                   , BillingPostalCode = '33445' + i
                                   , BillingState = 'NH' + i);
            
            accts.add(ListOfNewAccount);
        }
        return accts;

    }
    public static List<Contact> createContactTestData(Integer j)
    {
        List<Contact> con = new List<Contact>();
        for (Integer i=1;i<=j;i++) 
        {
            Contact ListOfNewContact = new Contact(FirstName = 'Gerard' + i
                                    , LastName = 'Timothy' + i);
            con.add(ListOfNewContact);
        }
        return con;
    }
}