public class simt_checkInstanceStatus{
   public static String basicAuthCallout(){
     HttpRequest req = new HttpRequest();
     req.setEndpoint('http://trust.salesforce.com/trust/instances');
     req.setMethod('GET');
     req.setHeader('Accept-Encoding', 'gzip,deflate');
     req.setHeader('Content-Type', 'application/xml');
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
     return res.getBodyAsBlob().toString();
   }
   public static String incidentAuthCallout(String instance){
     HttpRequest req = new HttpRequest();
     req.setEndpoint('http://trust.salesforce.com/rest/rss/'+instance);
     req.setMethod('GET');
     req.setHeader('Accept-Encoding', 'gzip,deflate');
     req.setHeader('Content-Type', 'application/xml');
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
     return res.getBodyAsBlob().toString();
   }
   public static String calendarCallout(){
     HttpRequest req = new HttpRequest();
     req.setEndpoint('http://trust.salesforce.com/trust/calendar');
     req.setMethod('GET');
     req.setHeader('Accept-Encoding', 'gzip,deflate');
     req.setHeader('Content-Type', 'application/xml');
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
     String responseStr = res.getBody().escapeXml().unescapeXml().unescapeHtml4();
     Integer startingPoint =  responseStr.indexOf('<table class="instance-schedule-table');
     Integer endingPoint =  responseStr.indexOf('</table',startingPoint+1);
     responseStr = responseStr.substring(startingPoint, endingPoint + 8);
     return responseStr ;
   }
}