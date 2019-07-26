public class StringArrayTest {
	
    public static List<String> generateStringArray(Integer recordCount){
        
        List<String> returnString = new List<String>();
        for(Integer I=0 ; I<recordCount ; I++){
            returnString.add('Test ' + I);
        }
        
        return returnString;
    }
}