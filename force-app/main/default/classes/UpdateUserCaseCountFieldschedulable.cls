/*
 * Name: UpdateUserCaseCountFieldschedulable
 * @description: Schedulable class that clear number case created by user 
 * Created by: John Aldric Seril
 * Created Date: 23-Oct-2015
 */
global class UpdateUserCaseCountFieldschedulable implements Schedulable {
	global void execute(SchedulableContext ctx) {
		List <User> userToUpdate = new list<User>();
		for(User u :[SELECT Id, case_count__c FROM user WHERE IsActive = true])
		{  
			u.case_count__c = null;
			userToUpdate.add(u);
		}
		if(!userToUpdate.isEmpty())
		{
			update userToUpdate;	
		}
   }   
}