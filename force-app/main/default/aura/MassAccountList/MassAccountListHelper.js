({
    
    
    removeAccount : function(component, index) {
        var accountList = component.get("v.AccountList");
        console.log('helllloooooooo-----' + accountList +' index========' +index);
        console.log('AccountList' + JSON.stringify(JSON.stringify(accountList[0])));
        accountList.splice(index, 1);
        
                    
        var action = component.get("c.deleteAccountList");
        console.log(JSON.stringify(accountList));
        action.setParams({
            AccountLists : JSON.stringify(accountList)
        });
        action.setCallback(this, function(results){
            var State = results.getState();
            if(State === 'SUCCESS'){
                alert("Successfully Deleted");
                
            }
        });
        $A.enqueueAction(action);
        
        
        var event = component.getEvent("AccountListEvent");
        //var setAcclist = JSON.stringify(accountList);
        event.setParams({
            'UpdatedAccountList': accountList
        });
        event.fire();
        
    }
    
    
})