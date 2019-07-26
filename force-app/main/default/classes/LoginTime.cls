public class LoginTime {

    public LoginTime(ApexPages.StandardController controller) {

            po = [SELECT Date_of_Time_Out__c,Date_of_Time_In__c,Time_of_Time_Out__c,Time_of_Time_In__c,Timein__c,Timeout__c,Total_Hours__c,Status__c,Over_Time__c,Under_Time__c 
                FROM Login__c WHERE ownerID =: UserInfo.getUserId() ORDER BY Timein__c DESC NULLS LAST LIMIT 15 ];
               
          Integer but = [SELECT count()FROM Login__c WHERE ownerID =: UserInfo.getUserId() and Timeout__c=null LIMIT 1];  
    
          //totalOT = [SELECT SUM(Over_Time__c) sum FROM Login__c WHERE ownerID =: UserInfo.getUserId() ];
            
          
          if(but>0)
          {
          IsLogin=True;
          ISLogout=False;
          }
          
          else{
          IsLogin=False;
          ISLogout=True;
          }
            
       } 


SObject totalOT;
SObject totalUT;
SObject totalTBO;

     public SObject gettotalOT() 
      {
      totalOT = [SELECT SUM(Over_Time__c) OT FROM Login__c WHERE ownerID =: UserInfo.getUserId()];
      return totalOT;
      }    

     public SObject gettotalUT() 
      {
      totalUT = [SELECT SUM(Under_Time__c) UT FROM Login__c WHERE ownerID =: UserInfo.getUserId()];
      return totalUT;
      }    


     public SObject gettotalTBO() 
      {
      totalTBO = [SELECT SUM(Over_Time__c) OT,SUM(Under_Time__c) UT FROM Login__c WHERE ownerID =: UserInfo.getUserId()];
      return totalTBO;
      }    


    public List<Login__c> po { get; set; }
    
    public Date Today { get { return Date.today(); }}

     public Boolean IsLogin {get;set;}
     public Boolean IsLogout {get;set;}

}