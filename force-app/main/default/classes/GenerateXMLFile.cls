public with sharing class GenerateXMLFile {
    @AuraEnabled
    public static string methodName(){
        try {
            System.debug('Succesfully');
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}