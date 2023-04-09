public class BatchApexBirthdayCelebration implements Database.Batchable<SObject> , Schedulable {
    
    
   public Database.QueryLocator start(Database.BatchableContext bc) {
        
        Date today = Date.today();
       String st = 'SELECT Id,FirstName,LastName,Email,BirthDate FROM Contact WHERE BirthDate = today';
   
        return Database.getQueryLocator(st);
       
                  
    }

   public void execute(Database.BatchableContext bc, List<Contact> clist) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for (Contact c : clist) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Happy Birthdate ' + c.FirstName + ' ' + c.LastName + '!');
            email.setToAddresses(new List<String>{c.Email});
            email.setPlainTextBody('As Silverline family, we wish you a very happy birthday and send you best wishes for much happiness in your life!');
            emails.add(email);
        }
       
        Messaging.sendEmail(emails);
       
    }

    public void finish(Database.BatchableContext bc) {
        system.debug('Email has been sent');
    }
    public void execute(SchedulableContext sc){
        BatchApexBirthdayCelebration batchjob = new BatchApexBirthdayCelebration();
        Database.executeBatch(batchjob);
    }
}