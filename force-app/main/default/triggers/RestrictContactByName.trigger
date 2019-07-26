trigger RestrictContactByName on Contact (before insert, before update) {

    for(Contact c: trigger.new){
        if(c.LastName =='INVALIDNAME'){
               c.AddError('The Last Name "' + c.LastName +'" is not allowed for DML');
        }
    }


}