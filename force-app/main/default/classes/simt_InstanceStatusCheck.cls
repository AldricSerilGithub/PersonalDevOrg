global class simt_InstanceStatusCheck{
    public Map<String, InstanceStatus> instanceMap {get; set;}
    public class InstanceStatus{
        public String instanceName {get; set;}
        public Boolean isUp {get; set;}
        public String status {get; set;}
        public InstanceStatus(){
            this.isUp = false;
        }
    }
    @future(callout=true)
    global static void checkInstanceStatus(){
        Map<String, InstanceStatus> instanceMap = new Map<String, InstanceStatus>();
        String xmlBody = simt_CheckInstanceStatus.basicAuthCallout();
        while(xmlBody!=''){
            try{
                Integer tbodyEndposition = xmlBody.indexOf('</tbody>')+8;
                String tbody= xmlBody.substring(xmlBody.indexOf('<tbody'),tbodyEndposition );
                xmlBody = xmlBody.substring(tbodyEndposition);
                integer position = 0;
                String trStr;
                Integer count = 0;
                while(tbody!=''){
                    try{
                        count++;
                        
                        position = tbody.indexOf('</tr>')+5;
                        trStr = tbody.substring(tbody.indexOf('<tr'),position);
                        trStr = trStr.replaceAll('=24','="24"').replaceAll('&nbsp','');
                        Dom.Document doc = new Dom.Document();
                        doc.load(trStr);
                        Dom.XMLNode ordDtls = doc.getRootElement();
                        for(Dom.XMLNode child : ordDtls.getChildElements()) {
                            if(child.getAttributeValue('class', null)!=null){
                                if(child.getAttributeValue('class', null).contains('column-now')){
                                    InstanceStatus ins = new InstanceStatus();
                                    if(child.getAttributeValue('class', null)!=null){
                                        ins.status = child.getAttributeValue('class', null);
                                        if(child.getAttributeValue('class', null).contains('instance-status-up')){
                                            ins.isUp =true;
                                        }
                                    }
                                    for(Dom.XMLNode child2 : child.getChildElements()){
                                        for(Dom.XMLNode child3 : child2.getChildElements()){
                                            
                                            for(Dom.XMLNode child4 : child3.getChildElements()){
                                                if(child4.getAttributeValue('class', null).equals('instance-name')){
                                                    ins.instanceName = child4.getText();
                                                    instanceMap.put(child4.getText(), ins);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        tbody = tbody.substring(position);
                    }catch(Exception ex){
                        tbody='';
                    }
                }
            }catch(Exception ex){
                xmlBody = '';
            }
        }
        List<InstanceStatus> downInstanceList = new List<InstanceStatus>();
        //Aldric
        List<simt_instance__c> insList = new List<simt_instance__c>();
        Set<String> insString = new Set<String>();
        insList = [Select Name, Active__c from simt_instance__c where Active__c = True];
        
        for(simt_instance__c insSet : insList){
            insString.add(insSet.Name);
        }
        //Aldric
        
        for(String key:instanceMap.keyset()){
            if(!instanceMap.get(key).isUp && insString.contains(instanceMap.get(key).instanceName)){
                downInstanceList.add(instanceMap.get(key));
            }
        }
        if(downInstanceList.size()>0){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('[Asset] Instance Check: Salesforce.com Instance Performance Degredation, Maintenance or Service Disruption');
            
            //List<String> emailAddresses = new List<String>{'john.aldric.s.seril@accenture.com','jerella.m.v.ledesma@accenture.com','mel.c.g.mallorca@accenture.com'};
            
            List<String> emailAddresses = new List<String>();
            List<simt_emailAddresses__c> emails = [Select Name from simt_emailAddresses__c];//new List<EmailAddresses__c>();
            
            for(simt_emailAddresses__c EA: emails){
                emailAddresses.add(EA.Name);
            }
            
            String body='Hello. The following instances are experiencing performance degradation or service interruption:<br/><br/>';
            PageReference pRef = Page.simt_CheckInstanceStatus;
            Blob vfBody =  pRef.getContent();
            for(InstanceStatus stat:downInstanceList){
                body+=stat.instanceName+' : '+stat.status+'<br/>';
            }
            try{
                if(!Test.isRunningTest()) {
                    email.setToAddresses(emailAddresses);
                    email.setHtmlBody(vfBody.toString());
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                }
            }
            catch(Exception e){
                system.debug('Error message on send email.');
            }          
        }
    }
}