@isTest
public class UpdateContactAddressesTest {
    @testSetup
    static void setup(){
        List<Account> accounts=new List<Account>();
        List <Contact> contacts=new List<Contact>();
        for(Integer i=0;i<10;i++){
            accounts.add(new Account(Name='Account'+i,billingcity='New York', billingcountry='USA'));
        }
        insert accounts;
        for(Account account : [SELECT id FROM account]){
            contacts.add(new Contact(firstname='first',
                lastname='last', accountId=account.id));
        }
        insert contacts;
    }
    @isTest
    static void UpdateContactTest(){
        Test.StartTest();
        UpdateContactAddresses obj=new UpdateContactAddresses();
        Id batchId=Database.executeBatch(obj);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
        
    }

}