({
	aldricHelper : function(component, event, helper) {
		var action = component.get("c.accountList");
        
                action.setCallback(this, function(results){
            var State = results.getState();
            if(State === 'SUCCESS'){
                component.set('v.accountList',results.getReturnValue());
            }
            console.log('accountList', results.getReturnValue());
            alert('accountList', results.getReturnValue());        
        });
        $A.enqueueAction(action);
	}
})