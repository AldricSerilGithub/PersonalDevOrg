({
	insertContact : function(component, event, helper) {
		var fName = component.find("firstName").get("v.value");	
        var lName = component.find("lastName").get("v.value");
        console.log(fName + lName);
        
        var action = component.get("c.insertContact");
        
        action.setParams({
            				firstName: fName,
            				lastName: lName,
        				});
        action.setCallback(this, function(a) {
            var contactId = a.getReturnValue();
            
            var state = a.getState();
            if (state === "SUCCESS") {
            	console.log("contact" + contactId);
            }
        });
        $A.enqueueAction(action); 
        
	}
})