({
	fireComponentEvent : function(component, event, helper) {
		var eventHandler = component.getEvent("componentEvent");
        eventHandler.setParams({
            sampl1: "I'm a component"
        })
        eventHandler.fire();
        
	}
})