({
	helperButton : function(component) {
		var userName = component.find("UsernameId").get("v.value");
        var password = component.find("PasswordId").get("v.value");
      
        var result = confirm("Are you sure you want to logout?" + "Username: " + userName + "Password: " + password );
        
        if(result){           
			window.open("/secur/logout.jsp");
            
            //window.open("https://aldrictraining-dev-ed.my.salesforce.com/secur/logout.jsp");
            //window.close();
        }
        
        
	}
})