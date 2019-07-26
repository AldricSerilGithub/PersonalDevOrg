/*
 *       author: John Aldric Seril
 *       created date: February 27, 2018
 *       description: trigger for case object
 *
*/
trigger CaseTriggers on Case (after insert, after update, before insert, before update)
{   
    //Get all the list in the AccountApexSwitch
    //Map<String, AccountApexSwitch__c> apexSwitch = AccountApexSwitch__c.getAll();
    
    //Check if the Apex Switch Field is True
    //if(apexSwitch.get('Case').APEX_Switch__c) {
        
        if( Trigger.isInsert )
        {
            if(Trigger.isBefore)
            {
                CaseTriggerHandler.OnBeforeInsert(trigger.New);
            }
            else
            {
                CaseTriggerHandler.OnAfterInsert(trigger.New);
            }
        }
        else if ( Trigger.isUpdate )
        {
            if(Trigger.isBefore)
            {
                CaseTriggerHandler.OnBeforeUpdate(trigger.New, trigger.old);
            }
            else
            {
                CaseTriggerHandler.OnAfterUpdate(trigger.New, trigger.old);
            }
        }
    //}  
}