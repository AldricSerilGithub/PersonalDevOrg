({
	doInit : function(component, event, helper) {
		helper.getPickListType(component);
        helper.getPicklistIndustry(component);
        helper.getAccountList(component);
        component.find("accName").set("v.value","");
        component.find("accPhone").set("v.value","");
        component.find("InputSelectType").set("v.value","");
        component.find("InputSelectIndustry").set("v.value","");
        
	},
    
    closeWindow : function(component, event, helper){
        if(confirm("Are you sure you want to close the window?")){
        	window.close();
    	}
        
    },
    
     
    showModal : function(component, event, helper) {
    	
        document.getElementById("modalWindow").style.display = "block";
        document.getElementById("overLay").style.visibility = "visible";
        component.find("accName").set("v.value","");
        component.find("accPhone").set("v.value","");
        component.find("InputSelectType").set("v.value","");
        component.find("InputSelectIndustry").set("v.value","");
    
    },
    
    hideModal : function(component,event, helper){
    
       document.getElementById("modalWindow").style.display = "none" ;
       document.getElementById("overLay").style.visibility = "hidden";
       component.find("accName").set("v.value","");
       component.find("accPhone").set("v.value","");
       component.find("InputSelectType").set("v.value","");
       component.find("InputSelectIndustry").set("v.value","");
        
   },
    
   addAccount : function(component, event, helper) {
   		helper.addAccountHelper(component); 
   },
    
    
    onSelectChangeType : function(component, event, helper){
        var selected = component.find("InputSelectType").get("v.value");
        component.set('v.TypeSelected', selected);
    },
    
	onSelectChangeIndustry : function(component, event, helper){
        var selected = component.find("InputSelectIndustry").get("v.value");
        component.set('v.IndustrySelected', selected);
    },
    
    massAccountSave : function(component, event, helper){
        helper.SaveAccountList(component);
        helper.getAccountList(component);
    },
    
    deleteAccount : function(component,event){
        var accList = event.getParams().UpdatedAccountList;
        var accountList = component.set("v.AccountList", event.getParams().UpdatedAccountList);
        console.log(accountList);
    }
    
    
    
})