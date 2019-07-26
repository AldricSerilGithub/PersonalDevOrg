({
    
    removeAccountButtonClick : function(component, event, helper) {
        
        
        if(confirm("Are you sure you want to remove the record?")){
            var index = event.getSource().get("v.value");
            console.log(index);
            helper.removeAccount(component, index);
        }
        
    }    
    
    
})