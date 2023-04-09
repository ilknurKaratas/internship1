@isTest
public class ReminderEmailForDueOpportunitiesTest {

    @isTest
    
    public static void testopp(){
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.CloseDate=System.today().addDays(3);
        opp.OwnerId =UserInfo.getUserId();
        opp.StageName='Prospecting';
        insert opp;
        
        Test.startTest();
        
        ReminderEmailForDueOpportunities batch = new ReminderEmailForDueOpportunities();
        Database.executeBatch(batch);
        
         String jobName = 'Opportunity Reminder';
        String cronExpression = '0 0 1 * * ?'; 
        ReminderEmailForDueOpportunities reminderSch = new ReminderEmailForDueOpportunities();
        System.schedule(jobName, cronExpression, reminderSch);
      
        Test.stopTest();
        
 /*List<EmailMessage> emails = [SELECT Id, ToAddress, Subject, HtmlBody FROM EmailMessage WHERE toAddress =: userinfo.getUserEmail()];
        
        System.assertEquals(1, emails.size());
        System.assertEquals(opp.owner.Email, emails[0].ToAddress);
        System.assertEquals(opp.Name + ' Opportunity required action!', emails[0].Subject);
        System.assertEquals('Hello ' + opp.owner.Name , emails[0].HtmlBody.substring(0,14));*/
       
    }
  
}