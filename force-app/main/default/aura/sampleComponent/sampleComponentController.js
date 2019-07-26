({
	clickMe : function(component, event, helper) {
        //var get = component.get("c.getAccount");
       	console.log("Label", event.target.name);
        //component.set("v.myName", "Kevin");
        helper.getAcc(component);
   }
})