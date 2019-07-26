public class simt_CheckInstanceStatusController {
    public String parsed {get; set;}
    public List<String> instanceList {get; set;}
    public List<IncidentWrapper> incidentList {get; set;}
    public String subjectStr {get; set;}
    
    //Aldric
    public List<simt_instance__c> inst {get; set;}
    public Set<String> insName {get; set;}  
    public String allInstanceStr {get; set;}
    //Aldric
    
    public Class IncidentWrapper{
        public String instanceName {get; set;}
        public String incidentTitle {get; set;}
        public String incidentDescription {get; set;}
        public String incidentStart {get; set;}
        public String incidentGuid {get; set;}
    }
    public Map<String, InstanceStatus> instanceMap {get; set;}
    public class InstanceStatus{
        public String instanceName {get; set;}
        public Boolean isUp {get; set;}
        public String status {get; set;}
        public InstanceStatus(){
            this.isUp = false;
        }
    }
    
    public simt_CheckInstanceStatusController(){
    inst = new List<simt_instance__c>();
    insName = new Set<String>();
    
    inst = [Select Name, Active__c from simt_instance__c where Active__c = True];
    
    for(simt_instance__c instan : inst){
        insName.add(instan.Name);
    }
    
    }
    
    
    public void initialize(){
        incidentList = new List<IncidentWrapper>();
        instanceMap = new Map<String, InstanceStatus>();
        String xmlBody = simt_CheckInstanceStatus.basicAuthCallout();
        String incidentBody = xmlBody+'';
        String incDetails;
        while(xmlBody!=''){
            try{
                Integer tbodyEndposition = xmlBody.indexOf('</tbody>')+8;
                String tbody= xmlBody.substring(xmlBody.indexOf('<tbody'),tbodyEndposition );
                xmlBody = xmlBody.substring(tbodyEndposition);
                integer position = 0;
                parsed ='';
                String trStr;
                Integer count = 0;
                instanceList = new List<String>();
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
        
        Set<String> insWithIssues = new Set<String>();
        
        String allInstance = '';
        String instanceWithIssues = '';
        String incidentDetails;
        for(String ins:instanceMap.keyset()){
            if(!instanceMap.get(ins).isUp){
                incidentDetails = simt_CheckInstanceStatus.incidentAuthCallout(ins);
                Dom.Document doc = new Dom.Document();
                doc.load(incidentDetails);
                Dom.XMLNode incidentDtls = doc.getRootElement();
                for(Dom.XMLNode child : incidentDtls.getChildElements()) {
                    for(Dom.XMLNode child2 : child.getChildElements()) {
                        if(child2.getName().equalsIgnoreCase('item')){
                            IncidentWrapper iw =  new IncidentWrapper();
                            iw.instanceName = ins;
                            for(Dom.XMLNode child3 : child2.getChildElements()) {
                                if(child3.getName().equalsIgnoreCase('title')){
                                    iw.incidentTitle = child3.getText();
                                }else if(child3.getName().equalsIgnoreCase('description')){
                                    iw.incidentDescription = child3.getText();
                                }else if(child3.getName().equalsIgnoreCase('guid')){
                                    iw.incidentGuid = child3.getText();
                                }else if(child3.getName().equalsIgnoreCase('pubdate')){
                                    iw.incidentStart = child3.getText();
                                }
                            }
                            
                            if(insName.contains(ins)){
                                incidentList.add(iw);
                                insWithIssues.add(ins);
                            }
                        }
                    }
                }
                if(allInstance==''){
                    allInstance = instanceMap.get(ins).instanceName;
                }else{
                    allInstance += ', '+instanceMap.get(ins).instanceName;
                }
            }
        }
        
        for(String insta : insWithIssues){
            if(instanceWithIssues==''){
                instanceWithIssues = insta;
            }
            else{
                instanceWithIssues += ', '+ insta;
            }
        }
        
        subjectStr = 'Issue Identified in '+instanceWithIssues+' Instances';
        allInstanceStr = 'All Issue Identified in '+ allInstance +' Instances';
    }
    
}