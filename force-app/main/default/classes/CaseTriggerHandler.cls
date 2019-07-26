/*
 *       author: John Aldric Seril
 *       created date: February 27, 2018
 *       description: trigger handler for case object
 *
*/
public with sharing class CaseTriggerHandler 
{
    //Map for Old Case Record
    public static Map<Id, Case> oldRecMap = new Map<Id, Case>(); 

    //Call methods before Insert
    public static void OnBeforeInsert(List<Case> newCaseList)
    {
        system.debug('Case Trigger On Before Insert');

    }
    
    //Call methods after Insert
    public static void OnAfterInsert(List<Case> newCaseList)
    {
        system.debug('Case Trigger On After Insert');
    }
    
    //Call methods after Update
    public static void OnAfterUpdate( List<Case> newCaseList, List<Case> oldCaseList)
    {
        system.debug('Case Trigger On After Update ');
        
        //Create Old Case Map
        buildOldRecMap(oldCaseList);
        
        //Call methods
        checkChildStatus(newCaseList);
    }
    
    //Call method before Update
    public static void OnBeforeUpdate( List<Case> newCaseList, List<Case> oldCaseList)
    {
        system.debug('Case Trigger On Before Update ');       
    }
    
    //Check Child Case Status and update the parent case
    public static void checkChildStatus(List<Case> newCaseList){

        List<Id> parentCaseIdList = new List<Id>();//Holds the list of parent Case 
        List<Case> parentCaseUpdateList = new List<Case>();//Holds the updated list of parent Case
        Set<Id> parentCasePartialList = new Set<Id>();
        Map<Id,List<Case>> caseMap = new Map<Id, List<Case>>(); //Holds the map of the parent case
        
        
        for(Case caseRec: newCaseList){
            
            //check if the case is Child
            if(caseRec.ParentId != null){
            
                //check if it was called in after update
                
                if(oldRecMap.size()>0){
                    
                    //check if the status value is updated and if the new value is Successful
                    if(oldRecMap.get(caseRec.Id).Status != caseRec.Status ){
                        
                        //Add Case Record in the Parent Case List
                        parentCaseIdList.add(caseRec.ParentId);
                        
                    }//End if(oldRecMap.get(caseRec.Id).Status != caseRec.Status && caseRec.Status == 'Successful')
                }//End if(oldRecMap.size()>0)
                
                //called in after Insert
                else{
                
                    //Checked if the Status is Successful
                    if(caseRec.Status == 'Successful'){
                        //Add Case Record in the Parent Case List
                        parentCaseIdList.add(caseRec.ParentId);
                        
                    }//End if(caseRec.Status == 'Successful')
                    
                }//End Else
                
            }//End if(caseRec.Parent != null)
            
        }//End for(Case caseRec: newCaseList)
    
               
        parentCaseUpdateList = [Select Id, Status, (Select Id, Status from Cases) from Case where Id IN: parentCaseIdList];
        
        for(Case caseParentRec: parentCaseUpdateList){
            caseParentRec.Status = 'Successful';
            
            for(Case childCase : caseParentRec.Cases){
                if(childCase.Status != 'Successful'){
                    caseParentRec.Status = 'Partially Successful';
                    break;
                }
            }        
        }
        
        if(parentCaseUpdateList.size()>0){
            update parentCaseUpdateList;
        }
        
    
    }
    
    
    //Construct Old Records to Map
    private static void buildOldRecMap(List<Case> oldRecs) {      
        for (Case caseRec : oldRecs) {
            oldRecMap.put(caseRec.Id, caseRec);
        }
    }

}