({
	buttonClicked : function(component, event, helper) {
		helper.helperButton(component);
	},
    
    buttonPress : function(component, event, helper){
        if(event.keyCode == 13){
           	alert('1st');
    	    buttonPress(component);
    		//helper.helperButton(component);        
    		buttonClicked(component);
        }
    }
})