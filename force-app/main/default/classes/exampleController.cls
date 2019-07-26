public class exampleController {
    Integer count = 0;
            
    public String inputText{get; set;}        
    public String controllerGet{get; set;} 
    
    public exampleController(){
        inputText = 'Testing';
    }
           
    public PageReference incrementCounter() {
        count++;
        controllerGet = inputText;
        //System.assertNotequals(inputText, inputText);
        
        return null;
    }
            
    public Integer getCount() {
        return count;
    }
}