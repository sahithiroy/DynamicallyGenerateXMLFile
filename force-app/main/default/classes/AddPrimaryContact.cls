public class AddPrimaryContact implements Queueable {
    private Contact contactTemplate;
    private String stateAbbreviation;

    // Constructor
    public AddPrimaryContact(Contact contactTemplate, String stateAbbreviation) {
        this.contactTemplate = contactTemplate;
        this.stateAbbreviation = stateAbbreviation;
    }

    // Execute method
    public void execute(QueueableContext context) {
        List<Account> accountList = [
            SELECT Id FROM Account
            WHERE BillingState = :stateAbbreviation
            LIMIT 200
        ];

        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : accountList) {
            Contact clonedContact = contactTemplate.clone(false, false, false, false);
            clonedContact.AccountId = acc.Id;
            contactsToInsert.add(clonedContact);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}