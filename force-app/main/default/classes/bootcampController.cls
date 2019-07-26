public with sharing class bootcampController {
    
    public String myName {get;set;}
    public String inputName {get; set;}
    public List<objectWrapper> objectWrapperList {get;set;}
    
    
    public class objectWrapper{
        public String userName {get; set;}
        public String orgName {get; set;}
        public boolean checkBoxs {get; set;}
    }
    
    
    public bootcampController(ApexPages.StandardController controller) {
        myName = 'Hello World';
        objectWrapperList = new List<objectWrapper>();
        
        for(integer i=0 ; i<2 ;i++){
            objectWrapper objectWrapperRecord = new objectWrapper();
            if(i==0){
                objectWrapperRecord.userName = 'Aldric Seril';
                objectWrapperRecord.orgName = 'Personal';
                objectWrapperRecord.checkboxs = True;
            }
            
            if(i==1){
                objectWrapperRecord.userName = 'Gabriel';
                objectWrapperRecord.orgName = 'Kisses';
                objectWrapperRecord.checkboxs = False;
            }
            
            objectWrapperList.add(objectWrapperRecord);
        }

    }
    
    public String getName(){
        return 'Dev401';
    
    }
    
    public String Submit(){
        System.assertNotEquals(inputName, inputName );
        return null;
    }

}