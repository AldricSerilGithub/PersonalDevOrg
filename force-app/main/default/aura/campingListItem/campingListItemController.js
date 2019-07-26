({
	packItem : function(component, event, helper) {
		var item = component.get("v.item", true);
        item.Packed__c = True;
        component.set("v.item", item);
        var btnclicked = event.getSource();
        btnclicked.set("v.disabled", true);
	}
})