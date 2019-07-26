public class sampleCon {

    public String countries {get; set;}
    public String radioCountries {get; set;}
    public List<SelectOption> items {get; set;}
    public List<SelectOption> itemSelected {get; set;}
    //String[] countries = new String[]{};

    public sampleCon(){
        items = new List<SelectOption>();
        items.add(new SelectOption('US','US'));
        items.add(new SelectOption('CANADA','Canada'));
        items.add(new SelectOption('MEXICO','Mexico'));
        
    }

    public static void test() {
        //return null;
    }
    /*
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));
        return options;
    }
    
    
    public String[] getCountries() {
        return countries;
    }
    
    public void setCountries(String[] countries) {
        this.countries = countries;
    }
    */
}