public class ST_TakeAssessmentController { 
    ApexPages.StandardController controller;
    private Assessment__c thisAssessment;
    private Answer__c thisAnswer;
    private Question__c thisQuestion;
    private List<Answer__c> questions = new List<Answer__c>{};
    public Boolean isLast {get; set;}
    public Boolean isFirst {get; set;}
    public Integer questionSize {get; set;}  
    public Integer examPages {get;set;}
    public String chooseAns {get;set;}
    public Boolean takingexam {get;set;}
    public Boolean reviewingexam {get;set;}
    public List<SelectOption> options = new List<SelectOption>();
    private String eid;
    private String tokenCode;
    public String currentcapab{get;set;}
    public Set<String> capabnames {get;set;}
    public List<Question__c> Capabs = new List<Question__c>();
    public List<Answer__c> CapabSFDC {get;set;}
    public Map<Id, String> Answersmap {get; set;}   
    public Map<Id, String> Commentsmap {get;set;}
     
    public ST_TakeAssessmentController(ApexPages.StandardController stdcontroller) { 
        Answersmap = new Map<Id, String>();
        commentsMap = new Map<Id, String>();
        showSinglePage = false;
        maxOffset = 0;
                
        CapabSFDC = [SELECT Id,AssertA__c,AssertB__c,AssertC__c,AssertD__c,AssertE__c,Question__r.IsOneAnswer__c,Question__r.IsTrueOrFalse__c, Question__r.Question__c, Question__r.Choice_A__c, Question__r.Choice_B__c,Question__r.Choice_C__c,Question__r.Choice_D__c,Question__r.Choice_E__c, Question__r.Capabilitiy__c,CAMS_Answer__c,ST_Answer__c,Question__r.IsMultiple__c From Answer__c Where Assessment__c =:ApexPages.currentPage().getParameters().get('id') ];
 
        this.controller = stdController;
        this.eid = ApexPages.currentPage().getParameters().get('eid');
        this.tokenCode = ApexPages.currentPage().getParameters().get('tc');
        this.questions = [SELECT Id, Name, Question__r.Track__c, Question__r.ExamType__c,Question__r.question__c, Question__r.IsOneAnswer__c, Question__r.Choice_A__c,
                            Question__r.Choice_B__c, Question__r.Choice_C__c, Question__r.Choice_D__c, Question__r.Choice_E__c, AssertA__c,Question__r.ExamSet__r.Duration__c,
                            AssertB__c,AssertC__c,AssertD__c,AssertE__c,Mark_for_Review__c,Marked_for_Review__c,Assessment__c,AssertedAnswer2__c  
                           from Answer__c WHERE Assessment__c =:ApexPages.currentPage().getParameters().get('id') order by id];

        this.thisAssessment = [select id, Exam_Type__c, createdDate, Transcript__c, LastVisitedItem__c, Transcript__r.Email__c from Assessment__c where id = :ApexPages.currentPage().getParameters().get('id')];

        if(thisAssessment.Transcript__r.Email__c != (eid + '@accenture.com') && thisAssessment.Transcript__r.Email__c != (eid + '@accenturefederal.com')) {
            ApexPages.Message msg = new Apexpages.Message(ApexPages.severity.ERROR, 'You do not own the Assessment record that you are trying to view!');
            ApexPages.addMessage(msg);
        }
        
        takingexam = true;
        reviewingexam = false;

        currentIndex = 0;
        refreshList();
    }

    public PageReference checkTokenCode() {
        String email = eid + '@accenture.com';
        Transcript__c transcript;
        try {
            transcript = [SELECT TokenCode__c from Transcript__c WHERE Email__c = :email];
        }catch(QueryException e) {
            email = eid + '@accenturefederal.com';
            transcript = [SELECT TokenCode__c from Transcript__c WHERE Email__c = :email];
        }
        
        if(tokenCode != transcript.TokenCode__c) {
            return (new PageReference('/ST_TokenInvalid'));
        }else {
            return null;
        }
    }
        
    public Boolean getIsValidAssessment() {
        return (thisAssessment.Transcript__r.Email__c == (eid + '@accenture.com') || thisAssessment.Transcript__r.Email__c == (eid + '@accenturefederal.com'));
    }//END getIsValidAssessment()
         
    // return a list of records
    public List<Answer__c> getAnswers() {
        return (List<Answer__c>) questions;
    }//END getAnswers()

    public PageReference submitAssessment() {
        doSaveCAMS();
        PageReference pageRef = new PageReference('/apex/ST_ViewTranscript?id=' + thisAssessment.Transcript__c
                                                            + '&aid=' + thisAssessment.id + '&eid=' + eid + '&tc=' + tokenCode + '&esid=' + ApexPages.currentPage().getParameters().get('esid'));
        return pageRef;       
    }//END submitAssessment()
    
 
    public void doSaveCAMS(){
        List<Answer__C> capabs = new List<Answer__C>();
        capabs.addAll(CapabSFDC);
        update capabs;        
    }//END doSaveCAMS()   
     
    
    
    private static final Integer PAGE_SIZE = 10; 
    //SC Release 2 - Updated Page Size from 3 to 10 ; BR - 00544
    public Integer currentIndex {get;set;}
    public Integer maxOffset {get;set;}
    Integer maxSize;
    public Boolean showSinglePage {get;set;}

    public Boolean getShowPagination() {
        if (!showSinglePage) {
            return (CapabSFDC.size()>PAGE_SIZE);
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
    } //END getLastPage(

    public Boolean getIsNotFirstPage() {
        return currentIndex != 0;
    } //END getIsNotFirstPage()

    public Boolean getIsNotLastPage() {
        return currentIndex != maxOffset;
    } //END getIsNotLastPage()

    public PageReference refreshList() {
        if(CapabSFDC.size()>PAGE_SIZE) {
            maxSize =  CapabSFDC.size();
            Double pageSizeInDecimal = PAGE_SIZE;

            this.maxOffset = Math.floor(this.maxSize/pageSizeInDecimal).intValue() * pageSizeInDecimal.intValue();


            if (Math.mod(this.maxSize, pageSizeInDecimal.intValue()) == 0) {
                this.maxOffset -= PAGE_SIZE;
            } //END if (Math.mod(this.maxSize, pageSizeInDecimal.intValue()) == 0)
        } //END if(sObjectList.size()>PAGE_SIZE)

         // sets the number of records in each page set

        System.debug('CapabSFDC>> '+CapabSFDC);
        System.debug('CapabSFDC.size() >> '+CapabSFDC.size() );
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

    
    public boolean displayPopup {get; set;}
 
    public void closePopup() {
        displayPopup = false;
    }
 
    public void showPopup() {
        displayPopup = true;
    }
}