public class Standardrecords{

public Standardrecords(ApexPages.StandardController controller) {
            
       } 

    public PageReference Custom() {   
        PageReference GeneratPage = new PageReference('/apex/launchView');
        return GeneratPage.setRedirect(true);
    }
    
    
    
}