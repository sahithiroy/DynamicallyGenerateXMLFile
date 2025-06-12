@isTest
public class DailyLeadProcessorTest {
    @isTest
    static void testDailyLeadProcessor() {
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(
                FirstName = 'Test',
                LastName = 'User' + i,
                Company = 'TestCompany'
            ));
        }
        insert testLeads;
        String cronExp = '0 0 0 1 5 ? 2025';
        Test.startTest();
        String jobId = System.schedule('Test DailyLeadProcessor', cronExp, new DailyLeadProcessor());
        Test.stopTest();
        List<Lead> updatedLeads = [
            SELECT LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'
        ];

        System.assertEquals(200, updatedLeads.size(), 'All 200 Leads should have LeadSource set to Dreamforce');
    }
}