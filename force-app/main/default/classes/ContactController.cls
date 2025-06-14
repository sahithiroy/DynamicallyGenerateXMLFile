public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            return [SELECT FirstName,Lastname,Email FROM Contact];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}