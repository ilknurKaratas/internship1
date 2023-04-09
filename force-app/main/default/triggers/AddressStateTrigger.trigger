trigger AddressStateTrigger on Lead (before insert,before update) {
               
           AddressTriggerHandler.updateLead(Trigger.New);
}