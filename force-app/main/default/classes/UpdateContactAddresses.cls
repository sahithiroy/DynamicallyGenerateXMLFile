public class UpdateContactAddresses implements Database.Batchable<sObject>,Database.Stateful {
    public Integer Records=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT ID, BillingStreet, BillingCity, BillingState,BillingPostalCode, (SELECT ID, MailingStreet, MailingCity,
            MailingState, MailingPostalCode FROM Contacts) FROM Account Where BillingCountry = 'USA']);
    }
    public void execute(Database.BatchableContext bc,List<Account> scope){
         List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                contacts.add(contact);
                Records = Records + 1;
            }
        }
        update contacts;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(Records + ' records processed.');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        //EmailUtils.sendMessage(job, Records);
    }

}