@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead> lis=new List<Lead>();
        for(Integer i=0;i<200;i++){
            lis.add(new Lead(Company='Company'+i,LastName='Test'+i,Status='Closed - Converted'));
        }
        insert lis;
    }
    @isTest
    static void leadTest(){
        Test.StartTest();
        LeadProcessor obj =new LeadProcessor();
        Id batchId=Database.executeBatch(obj);
        Test.StopTest();
        for (Lead lis: [SELECT LeadSource FROM Lead]){
            System.assertEquals('Dreamforce',lis.LeadSource);
        }
        
    }

}