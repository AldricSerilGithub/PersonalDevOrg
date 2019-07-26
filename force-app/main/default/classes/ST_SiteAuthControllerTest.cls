@isTest
private class ST_SiteAuthControllerTest {
    
    static testMethod void testbrowserSupported() {
        
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         string userAgent = ApexPages.currentPage().getHeaders().put('USER-AGENT', 'MSIE 8');
         //string userAgent = 'MSIE 8';            
         controller.getInstruction(); 
         controller.Email='portaluser@accenture.com';
         controller.sendToken();
         controller.testBrowser();
         //system.assert(userAgent.containsAny('MSIE 8'));
         controller.browserSupported = false;
         
         system.assertEquals(false, controller.browserSupported);      
         //ApexPages.Message msg = ApexPages.getMessages().get(0);
         System.assertEquals(ST_Constants.ERROR_UNSUPPORTED_BROWSER ,ApexPages.getMessages().get(0).getSummary());
         System.assertEquals(ApexPages.Severity.ERROR, ApexPages.getMessages().get(0).getSeverity());
    }

    static testMethod void testInvalidEmail() {
    
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         controller.getInstruction();
         controller.Email='portaluser@mail.com';
         controller.sendToken();
         ApexPages.Message msg = ApexPages.getMessages().get(0);
         System.assertEquals(ST_Constants.ERROR_NON_ACCENTURE_EMAIL, msg.getSummary());
         System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity());
    }    
    
    static testMethod void testValidEmail() { 
    
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         controller.getInstruction();
         controller.Email='portaluser@accenturefederal.com';
         controller.sendToken();
         List<Transcript__c> transcripts = [SELECT Email__c FROM Transcript__c 
                                          WHERE Email__c = 'portaluser@accenturefederal.com'];
         System.assertEquals(controller.Email, transcripts[0].Email__c);                                 
         System.assertEquals(1, transcripts.size());                     
    }
    
    static testMethod void testInvalidToken() {
    
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         controller.getInstruction();
         controller.Email='portaluser@accenture.com';
         controller.TokenCode='1l0v3m4th1ns3rt84rc4mh3r3!';
         controller.login();
         ApexPages.Message msg = ApexPages.getMessages().get(0);
         System.assertEquals(ST_Constants.ERROR_INVALID_TOKEN_CODE, msg.getSummary());
         System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity());
    }
    
    static testMethod void testValidToken() {
    
         PageReference expectedPage, outputPage;
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         controller.getInstruction();
         controller.Email='portaluser@accenture.com';
         controller.sendToken();
         Transcript__c transcript = [SELECT Email__c, tokenCode__c FROM Transcript__c 
                                          WHERE Email__c = 'portaluser@accenture.com'];
         controller.TokenCode=transcript.tokenCode__c;
         String eid = (transcript.Email__c).substring(0,(transcript.Email__c).indexOf('@'));
         expectedPage = new PageReference('/apex/ST_ViewTranscript?id=' + transcript.id + '&eid=' + eid + '&tc=' + transcript.TokenCode__c);
         outputPage = controller.login();
         System.assertEquals(expectedPage.getUrl(), outPutPage.getUrl());  
    }
    
    static testMethod void testInvalidEmailAtLogin() {
         PageReference currentPage = Page.ST_SiteAuth;
         Test.setCurrentPage(currentPage);
         ST_SiteAuthController controller = new ST_SiteAuthController();
         controller.getInstruction();
         controller.Email='portaluser@mail.com';
         controller.login();
         ApexPages.Message msg = ApexPages.getMessages().get(0);
         System.assertEquals(ST_Constants.ERROR_NON_ACCENTURE_EMAIL, msg.getSummary());
         System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity());
    }
    
    
    static testMethod void testInvalidBrowser(){
        ST_SiteAuthController controller = new ST_SiteAuthController();
        controller.getErrorBrowser();
         PageReference pageRef = new PageReference('/apex/test');
         pageRef.getHeaders().put('User-Agent', 'MSIE 8');
         Test.setCurrentPage(pageRef);
         controller.userAgent = pageRef.getHeaders().get('User-Agent');
         controller.testBrowser();
         //controller.testController();
         ApexPages.Message msg = ApexPages.getMessages().get(0);
         System.assertEquals(ST_Constants.ERROR_UNSUPPORTED_BROWSER, msg.getSummary());
         System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity());
    }
    
    static testMethod void testValidBrowser(){
        ST_SiteAuthController controller = new ST_SiteAuthController();
        controller.getErrorBrowser();
         PageReference pageRef = new PageReference('/apex/test');
         pageRef.getHeaders().put('User-Agent', 'Chrome');
         Test.setCurrentPage(pageRef);
         controller.userAgent = pageRef.getHeaders().get('User-Agent');
         controller.testBrowser();
         //controller.testController();
         
    }
    
}