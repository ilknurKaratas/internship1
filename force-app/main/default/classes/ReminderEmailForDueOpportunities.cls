public class ReminderEmailForDueOpportunities implements Database.Batchable <sObject>, Schedulable {
      public List<String> errorMessages = new List<String>();
    
	 public Database.QueryLocator start(Database.BatchableContext BC){
 		return Database.getQueryLocator([SELECT Id,name,closeDate,Owner.Email,Owner.Name From Opportunity WHERE CloseDate = NEXT_N_DAYS:3]);
 }
    
 	public void execute(Database.BatchableContext BC, List<Opportunity> opplist){
        list <messaging.SingleEmailMessage> mailList = new list <messaging.SingleEmailMessage>();
        
     	for(opportunity opp : opplist){
         messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {opp.Owner.Email};
            mail.setToAddresses(toAddresses); 
            mail.setSubject(opp.name + ' Opportunity required action!');
mail.setHtmlBody('Hello '+ opp.owner.name + ', '+opp.name+ ' Opportunity has to be closed before '+ opp.closeDate +' Please finalize your sales process.');
            mailList.add(mail);
     }
           if(!mailList.isEmpty()) {
                try{
                    Messaging.sendEmail(mailList);
                }
                catch (Exception ex) {
                    errorMessages.add('Unable to send email to Opp. Owner: '+ ex.getStackTraceString());
                }
            }
 }
    
	public void finish(Database.BatchableContext BC){
 }
    
    public void execute(SchedulableContext sc) {        
        ReminderEmailForDueOpportunities ReminderEmail = new ReminderEmailForDueOpportunities();
        Database.executeBatch(ReminderEmail);
}
}