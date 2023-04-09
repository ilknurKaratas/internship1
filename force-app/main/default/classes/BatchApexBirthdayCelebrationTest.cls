@isTest
public class BatchApexBirthdayCelebrationTest {

    @isTest 
    public static void testBatch() {
        
       contact testc = new contact();
        testc.FirstName = 'testAA';
        testc.LastName = 'Test';
        testc.Email = 'ranafrasila@gmail.com';
        testc.Birthdate = date.today();
        insert testc;
        
        Test.startTest();
        
        BatchApexBirthdayCelebration batch = new BatchApexBirthdayCelebration();
        Database.executeBatch(batch);
        
        String jobName = 'Birthday Celebration';
        String cronExpression = '0 0 0 * * ?';
        BatchApexBirthdayCelebration batchBd = new BatchApexBirthdayCelebration();
        System.schedule(jobName, cronExpression, batchBd);
        
        Test.stopTest();
        
        
        List<EmailMessage> emails = [SELECT Id, ToAddress, Subject, TextBody FROM EmailMessage WHERE Subject = 'Happy Birthdate testAA Test!' AND ToAddress='ranafrasila@gmail.com'];
        System.assertEquals(1, emails.size());
      

    }
}