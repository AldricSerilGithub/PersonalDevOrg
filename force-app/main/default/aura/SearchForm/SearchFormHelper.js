({
	doSearchHelper : function(component) {
		
        var searchTerm = component.get("v.term");
        
        //var appEvent = $A.get("e.c:SearchEvent");
        var appEvent = component.getEvent("SearchEvent");
        appEvent.setParams({
            term : searchTerm                   
        });
        appEvent.fire();
	}
})