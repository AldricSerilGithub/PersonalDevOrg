/*
 * Name: caseTrigger
 * @description: before insert trigger to validate if user creating the case exceeded the max number of case per month
 * Created by: John Aldric Seril
 * Created date: 23-Oct-2015
 */ 
trigger caseTrigger on Case (before insert) 
{ 
    MaxCaseCount__c mhc = MaxCaseCount__c.getInstance();
	decimal maxCase = mhc.Max_Case__c.intValue();
	User u = [select id, name, case_count__c from User where id = :Userinfo.getUserId()];
    for(Case c: trigger.new)
    {      
        if(u.case_count__c == maxCase)
        {
            c.addError('Too many case created for user ' + u.Name + '(' + u.Id +'). Only ' + maxCase +' cases created per user each month.');
        }
    }
}