({
	getAcc : function(component) {
	    var action = component.get("c.getAccount");
        
        action.setParams({
            "name" : component.get("v.myName")
               
        });
        
   	    action.setCallback(this, function(actionResult){
            component.set("v.myAccount", actionResult.getReturnValue());
            console.log('My Account inside actionResult', actionResult);
            console.log('My Account inside', component.get("v.myAccount"));
            //console.log('My Account within', component.get("v.myAccount"));
        });
        
        $A.enqueueAction(action);
        console.log('My Account', component.get("v.myAccount"));
	}
})