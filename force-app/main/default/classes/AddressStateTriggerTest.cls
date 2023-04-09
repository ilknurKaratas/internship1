@isTest
public class AddressStateTriggerTest {
  @isTest
    public static void testAddressStateTrigger() {
       Lead testLead = new Lead();
            testLead.FirstName = 'Test';
            testLead.LastName = 'Lead';
            testLead.State__c = 'NY : New York';
        insert testLead;
             
        testLead.State__c = 'CA : California';
        update testLead;
        

        
         Lead uLead = [SELECT LastName,State,State__c FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals(testLead.State__c, uLead.State);
 
     
}
    }