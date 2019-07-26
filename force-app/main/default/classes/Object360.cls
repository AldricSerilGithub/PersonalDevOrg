global class Object360 implements Comparable {
     
    global DateTime DateField {get;set;}
    global String ObjectType {get;set;}
    global sObject Record {get;set;}

    global Object360(DateTime mDate, String ent, sObject rec) {
        DateField = mDate;
        ObjectType = ent;
        Record = rec;
    } //END CaseActivityOrHistory constructor
        
    global Integer compareTo(Object compareTo) {
        Object360 compareToEmp = (Object360)compareTo;
        if (DateField == compareToEmp.DateField) {
            return 0;
        } //END if (LastModifiedDate == compareToEmp.LastModifiedDate)
        if (DateField > compareToEmp.DateField){
            return -1;
        } //END if (LastModifiedDate > compareToEmp.LastModifiedDate)
        return 1;
    } //END compareTo method
} //END CaseActivityOrHistory