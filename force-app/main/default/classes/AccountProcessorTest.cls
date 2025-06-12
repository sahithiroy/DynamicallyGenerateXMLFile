@isTest
public class AccountProcessorTest {
    @isTest
    Private static void testContacts(){
        List<Account> accList=new List<Account>();
        for (Integer i=0;i<5;i++){
            accList.add(new Account(Name='Test'+i));
        }
     	insert accList;
        System.debug('acclist'+accList);
        List<Contact> conList =new List<Contact>();
        List<Id> accIds=new List<Id>();
        for (Account acc: accList){
            conList.add(new Contact(FirstName='Test',LastName=acc.Name,AccountId=acc.Id));
            accIds.add(acc.Id);
        }
        insert conList;
        System.debug('conList'+conList);
        System.debug('accIds'+accIds);
        
        Test.startTest();
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
        List<Account> accs=[SELECT Id,Number_Of_Contacts__c FROM Account];
        System.debug('accs'+accs);
        System.debug('accs[0].Number_Of_Contacts__c'+accs[0].Number_Of_Contacts__c);
        System.assertequals(1,accs[0].Number_Of_Contacts__c);
    }
}