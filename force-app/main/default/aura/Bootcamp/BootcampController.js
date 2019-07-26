({
	onInit : function(component, event, helper) {
		//alert('initializtion');	
	},
    
    saveContact : function(component, event, helper) {
		helper.insertContact(component, event, helper);
        
	},
    
    changeParent : function(component, event, helper) {
        var fName = component.find("firstName").get("v.value");	
		component.set("v.childChange","Child");
        
	}
    
    
})