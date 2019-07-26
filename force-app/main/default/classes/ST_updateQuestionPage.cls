public class ST_updateQuestionPage {

    public String quest {get; set;}
    
    public ST_updateQuestionPage(ApexPages.StandardController stdController) {
        this.quest =ApexPages.currentPage().getParameters().get('id');
        
    }

    
}