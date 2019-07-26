({
    getPickListType : function(component) {
        var action = component.get('c.getTypePicklist');
        
        action.setCallback(this, function(results){
            var State = results.getState();
            if(State === 'SUCCESS'){
                component.set('v.TypePicklist',results.getReturnValue());
            }
            console.log('TypePicklist', results.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    getPicklistIndustry : function(component) {
        var action = component.get('c.getIndustryPicklist');
        
        action.setCallback(this, function(results){
            var State = results.getState();
            if(State === 'SUCCESS'){
                component.set('v.IndustryPicklist',results.getReturnValue());
            }
            console.log('IndustryPicklist', results.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    getAccountList : function(component) {
        var action = component.get('c.getAccountList');
        
        action.setCallback(this, function(results){
            var State = results.getState();
            if(State === 'SUCCESS'){
                component.set('v.AccountList',results.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    addAccountHelper : function(component) {
        
        var accName = component.find("accName").get("v.value");
        var accPhone = component.find("accPhone").get("v.value");
        var InputSelectType = component.find("InputSelectType").get("v.value");
        var InputSelectIndustry = component.find("InputSelectIndustry").get("v.value");
        
        var accountList = component.get("v.AccountList");
        var AccountNewList = component.get("v.AccountNewList");
        console.log('Name' + accName);
        console.log('accPhone' + accPhone);
        console.log('InputSelectType' + InputSelectType);
        console.log('InputSelectIndustry' + InputSelectIndustry);
        
        
        if((accName!=null || accName!='') && (accPhone!=null || accPhone!='') && (InputSelectType!='-None-') && (InputSelectIndustry!='-None-')){
            var accountRec = {
                "Name" : accName,
                "Phone" : accPhone,  
                "Type" : InputSelectType,
                "Industry" : InputSelectIndustry
            }
            accountList.push(accountRec);
            console.log(accountList);
            AccountNewList.push(accountRec);
            component.set('v.AccountNewList', AccountNewList);
            component.set('v.AccountList', accountList);
            console.log('AccountList ====== ' + JSON.stringify(component.get('v.AccountList')));
            document.getElementById("modalWindow").style.display = "none" ;
            document.getElementById("overLay").style.visibility = "hidden";
        }
        
        else{
            alert("Please fill all the fields");
        }
        
        console.log('Testing end');
        
        
        
    },
    
    SaveAccountList : function(component){
        
        if(confirm("Are you sure you want to update the list?")){            
            var action = component.get("c.insertAccountList");
            var accountList = component.get("v.AccountList");
            
            console.log('accountlis[t'+accountList);
            action.setParams({
                AccountLists : JSON.stringify(accountList)
            });
            action.setCallback(this, function(results){
                var State = results.getState();
                if(State === 'SUCCESS'){
                    alert("Successfully Updated");
                    
                }
            });
            $A.enqueueAction(action);
            
            
            
        }
    }
    
    
    
})