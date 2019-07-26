public class Launch360ViewController {

     /*
    Created By: Accenture - Marvin Bonifacio
    Created On: 2/22/2014
    Purpose   : 
    --------------------------------------------------------------------------
    Modified By: Accenture - John Aldric Seril
    Modified On: 12/09/2014
    Modification: 
    */

    Map<String, List<Case_View_Fields__c>> x360Map = new Map<String, List<Case_View_Fields__c>>();
    Map<String, String> queryMap = new Map<String, String>();
    Map<String, String> caseFieldMap = new Map<String, String>();
    Map<String, String> dateFieldMap = new Map<String, String>();
    Set<ID> recTypeIds = new Set<ID>();
    public Map<String, Case_View_Object__c> objectMap {get;set;}
    Id caseId;
    public Map<String, List<String>> fieldMap {get;set;}
    public Map<String, Map<String, String>> labelMap {get;set;}
    public Map<String, List<sObject>> sObjectMap {get;set;}
    public List<Object360> sObjectList {get;set;}
    public Case caseRec {get;set;}
        
    //pagination variables
    private Static Final Integer PAGE_SIZE = 10; 
    //SC Release 2 - Updated Page Size from 3 to 10 ; BR - 00544
    public Integer currentIndex {get;set;}
    public Integer maxOffset {get;set;}
    Integer maxSize;
    public Boolean showSinglePage {get;set;}

    public Boolean getShowPagination() {
        if (!showSinglePage) {
            return (sObjectList.size()>PAGE_SIZE);
        } //END if (!showSinglePage)
        else {
            return false;
        } //END else
    } //END getShowPagination()

    public Integer getPageSize() {
        if (!showSinglePage ) {
            return PAGE_SIZE;
        } //END if (!showSinglePage )
        else {
            return maxSize;
        } //END else
    } //END getPageSize()

    public Integer getCurrentPage() {
        return (currentIndex / PAGE_SIZE) + 1;
    } //END getCurrentPage()

    public Integer getLastPage() {
        return (maxOffset / PAGE_SIZE) + 1;
    } //END getLastPage()

    public Boolean getIsNotFirstPage() {
        return currentIndex != 0;
    } //END getIsNotFirstPage()

    public Boolean getIsNotLastPage() {
        return currentIndex != maxOffset;
    } //END getIsNotLastPage()

    public PageReference refreshList() {
        if(sObjectList.size()>PAGE_SIZE) {
            maxSize =  sObjectList.size();
            Double pageSizeInDecimal = PAGE_SIZE;

            this.maxOffset = Math.floor(this.maxSize/pageSizeInDecimal).intValue() * pageSizeInDecimal.intValue();


            if (Math.mod(this.maxSize, pageSizeInDecimal.intValue()) == 0) {
                this.maxOffset -= PAGE_SIZE;
            } //END if (Math.mod(this.maxSize, pageSizeInDecimal.intValue()) == 0)
        } //END if(sObjectList.size()>PAGE_SIZE)

         // sets the number of records in each page set

        System.debug('sObjectList >> '+sObjectList );
        System.debug('sObjectList.size() >> '+sObjectList.size() );
        return null;
    } //END PageReference refreshList()    
     // indicates whether there are more records after the current page set.

    public Boolean hasNext {
        get {
            return currentIndex < maxOffset;
        } //END get
        set;
    } //END hasNext

    // indicates whether there are more records before the current page set.

    public Boolean hasPrevious {
        get {
            return currentIndex > 0;
        } //END get
        set;
    } //END hasPrevious
    // returns the page number of the current page set

    public Integer pageNumber {
        get {
            return maxOffset / PAGE_SIZE;
        } //END get
        set;
    } //END pageNumber

    // returns the first page of records

    public void first() {
        this.currentIndex = 0;
    } //END first()
    // returns the last page of records

    public void last() {
        this.currentIndex = maxOffset;
    } //END last()

    // returns the previous page of records

    public void previous() {
        this.currentIndex -= PAGE_SIZE;
    } //END previous()

    // returns the next page of records
    
    public void next() {
        this.currentIndex += PAGE_SIZE;
    } //END next()

    public void toggleSinglePage() {
                if (this.showSinglePage == false) {
                    this.showSinglePage = true;
                } //END if (this.showSinglePage == false)
                else {
                    this.showSinglePage = false;
                } //END else
        } //END toggleSinglePage()


    public Launch360ViewController() {
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Map<String , Map<String,Schema.SObjectField> > mapObj_FielMap = new Map<String , Map<String,Schema.SObjectField> >();
        showSinglePage = false;

        try {

            caseId = ApexPages.currentPage().getParameters().get('id');
            caseRec = [SELECT Id, RecordTypeId, CaseNumber, Subject, Description, Environment__c from Case where Id = :caseId];
            fieldMap = new Map<String, List<String>> ();
            labelMap = new Map<String, Map<String, String>> ();
            sObjectMap = new Map<String, List<sObject>>();
            objectMap = new Map<String, Case_View_Object__c>();
            maxOffset = 0;

            for (Case_View_Object__c viewObject : [SELECT Name, Related_Case_Field__c, Sort_By_Date_Field__c,
                                                   Label__c, Sort_By_Date_Label__c,
                                                  (SELECT Field__c, Label__c from Case_View_Fieldss__r ORDER BY NAME ASC)
                                                   FROM Case_View_Object__c ORDER BY NAME ASC]) {

                x360Map.put(viewObject.Name, viewObject.Case_View_Fieldss__r);

                objectMap.put(viewObject.Name, viewObject);
                fieldMap.put(viewObject.Name, new List<String>());
                labelMap.put(viewObject.Name, new Map<String, String>());
                caseFieldMap.put(viewObject.Name, viewObject.Related_Case_Field__c);
                dateFieldMap.put(viewObject.Name, viewObject.Sort_By_Date_Field__c);
            }//END for (Case_View_Object__c viewObject : <inline SOQL>)
      
            for (String viewObject : x360Map.keyset()) {
            
                fieldMap.get(viewObject).add(objectMap.get(viewObject).Sort_By_Date_Field__c);
                labelMap.get(viewObject).put(objectMap.get(viewObject).Sort_By_Date_Field__c, objectMap.get(viewObject).Sort_By_Date_Label__c);

                for (Case_View_Fields__c viewField : x360Map.get(viewObject)) {

                    if (viewField.Field__c != dateFieldMap.get(viewObject)) {
                        fieldMap.get(viewObject).add(viewField.Field__c);
                        labelMap.get(viewObject).put(viewField.Field__c, viewField.Label__c);
                    } //END if (viewField.Field__c != dateFieldMap.get(viewObject))
                } //END  for (Case_View_Fields__c viewField : x360Map.get(viewObject))
            } //END for (String viewObject : x360Map.keyset())

            for (String viewObject : fieldMap.keyset()) {
                String queryString = 'SELECT ';

                for (String viewField : fieldMap.get(viewObject)) {
                    queryString += (viewField + ', ');
                } //END for (String viewField : fieldMap.get(viewObject))

                queryString = queryString.substring(0, queryString.length()-2);
                queryString += (' FROM ' + viewObject
                                + ' WHERE ' + caseFieldMap.get(viewObject) + ' = \'' + caseId
                                + '\'ORDER BY ' + dateFieldMap.get(viewObject) + ' DESC');
                System.debug('queryString >> ' + queryString);
                sobjectMap.put(viewObject, Database.query(queryString));
            } //END for (String viewObject : fieldMap.keyset())

            System.debug('fieldMap >> ' + fieldMap);
            System.debug('sobjectMap >> ' + sobjectMap);
            sObjectList = new List<Object360>();

            for (String viewObject : sobjectMap.keyset()) {
                for (sObject viewRecord : sObjectMap.get(viewObject)) {
                    Object360 viewSObject = new Object360(
                        (DateTime)viewRecord.get(dateFieldMap.get(viewObject)),
                        viewObject,
                        viewRecord);
                    sObjectList.add(viewSObject);
                } //END for (sObject viewRecord : sObjectMap.get(viewObject))
            } //END for (String viewObject : sobjectMap.keyset())
            
            System.debug('sObjectList before sort >> ' + sObjectList);
            sObjectList.sort();
            System.debug('sObjectList after sort>> ' + sObjectList);
            currentIndex = 0;
            refreshList();
        } //END try
        
        catch(Exception e){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        } //END catch
    } //END Launch360ViewController()


    public PageReference backToCase() {
        return new PageReference('/' + caseId);
    } //END PageReference backToCase()


    public PageReference exportToPDF() {
        return Page.Launch360PDF;
    } //END PageReference exportToPDF()
    
    
}