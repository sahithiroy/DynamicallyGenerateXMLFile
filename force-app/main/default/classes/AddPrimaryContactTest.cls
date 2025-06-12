@isTest
public class AddPrimaryContactTest {
    @isTest
    static void testAddPrimaryContact_CA() {
        List<Account> caAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }
        List<Account> nyAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
        }

        insert caAccounts;
        insert nyAccounts;
        Contact contactTemplate = new Contact(FirstName = 'Primary', LastName = 'Contact', Email = 'primary@example.com');
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(contactTemplate, 'CA'));
        Test.stopTest();
        List<Contact> caContacts = [
            SELECT Id, AccountId 
            FROM Contact 
            WHERE Email = 'primary@example.com'
        ];

        System.assertEquals(50, caContacts.size(), 'There should be 50 contacts for CA accounts.');
    }
}