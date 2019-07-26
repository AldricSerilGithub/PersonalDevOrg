public class exampleController1 {

    DateTime T1;
    transient DateTime T2;
    
    public String getT1(){
        if(T1 == null){
            T1 = System.Now();
        }
        return '' + T1;
    }
    
    public String getT2(){
        if(T2 == null){
            T2 = System.Now();
        }
        return '' + T2;        
    }


}