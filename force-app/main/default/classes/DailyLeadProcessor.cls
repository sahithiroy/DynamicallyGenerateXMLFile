public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Query the first 200 Leads with blank LeadSource
        List<Lead> leadsToUpdate = [
            SELECT Id, LeadSource 
            FROM Lead 
            WHERE LeadSource = NULL 
            LIMIT 200
        ];

        // Update LeadSource to 'Dreamforce'
        for (Lead l : leadsToUpdate) {
            l.LeadSource = 'Dreamforce';
        }

        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}