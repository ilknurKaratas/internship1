public class AddressTriggerHandler {
    public static void updateLead(List<Lead> leadList){
        
        for(Lead ld : leadList){
        if(ld.State__c != null && ld.LeadSource == 'Website'){
          ld.State = ld.State__c.substringAfter(' : ');
        }
    }
}
}