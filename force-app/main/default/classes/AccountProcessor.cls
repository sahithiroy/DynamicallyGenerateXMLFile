public class AccountProcessor {
     @future
    public static void countContacts(List<Id> accIds){
        List<Account> acclis=[SELECT Id,(SELECT Id FROM Contacts)
                             from Account where Id IN: accIds];
        System.debug('MainFunction');
        System.debug('acclis'+acclis);
        for (Account acc:acclis){
            acc.Number_Of_Contacts__c=acc.Contacts.size();
        }
        if(!acclis.isEmpty()){
            update acclis;
            System.debug('Update Successfully');
        }
        
    }

}