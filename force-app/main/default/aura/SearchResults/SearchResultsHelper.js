({
	searchedHelper : function(component,event) {
		var searchedTerm = event.getParam("term");
       // var searchedTerm = event.getParams().term;
        component.set("v.msg", searchedTerm);
	}
})