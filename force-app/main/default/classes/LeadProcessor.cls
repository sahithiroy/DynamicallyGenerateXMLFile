public class LeadProcessor implements Database.Batchable<sObject>,Database.Stateful {
    public Integer Records=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,LeadSource FROM Lead]);
    }
    public void execute(Database.BatchableContext bc,List<Lead> scope){
        for(Lead lis : scope){
            lis.LeadSource='Dreamforce';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Records'+Records);
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
    

}