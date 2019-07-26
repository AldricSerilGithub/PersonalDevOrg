trigger ClosedOpportunityTrigger on Opportunity (after insert) {

    List<Task> taskListToInsert = new List<Task>();
    
    for(Opportunity opp: trigger.new){
        if(opp.stageName == 'Closed Won'){
            Task t = new Task();
            t.Subject = 'Follow up Test task';
            t.WhatId = opp.Id;
            taskListToInsert.add(t);
        }
    }
    
    if(taskListToInsert.size()>0){
        insert taskListToInsert;
    }

}