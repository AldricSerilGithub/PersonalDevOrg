@isTest
private class simt_checkInstanceStatusTest {
     @isTest static void testCallout() {
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2());
         
         
         String res = simt_checkInstanceStatus.basicAuthCallout();
         String res2 = simt_checkInstanceStatus.incidentAuthCallout('NA0');
                  
         simt_ConfigureInstanceCheckController CICC = new simt_ConfigureInstanceCheckController();
         CICC.runInstanceChecker();
         
         simt_CheckInstanceStatusController CIS = new simt_CheckInstanceStatusController();
         simt_CheckInstanceStatusController.IncidentWrapper iw = new simt_CheckInstanceStatusController.IncidentWrapper();
         iw.incidentDescription = 'test';
         iw.incidentGuid = 'test';
         iw.incidentStart = 'test';
         iw.incidentTitle = 'test';
         iw.instanceName = 'test';
         
         simt_InstanceStatusCheck.InstanceStatus isc = new simt_InstanceStatusCheck.InstanceStatus();
         isc.instanceName = 'test';
         isc.isUp = true;
         isc.status = 'test';
         
         Map<String, simt_InstanceStatusCheck.InstanceStatus> instanceMap = new Map<String, simt_InstanceStatusCheck.InstanceStatus>();
         instanceMap.put('test', isc);
         
         Test.stopTest();
    }
    @isTest static void testCallout2() {
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3());
         simt_CheckInstanceStatusController CIS = new simt_CheckInstanceStatusController();
         simt_CheckInstanceStatusController.InstanceStatus is = new simt_CheckInstanceStatusController.InstanceStatus();
         is.instanceName = 'test';
         is.isUp = true;
         is.status = 'test';
        
         Map<String, simt_CheckInstanceStatusController.InstanceStatus> instanceMap = new Map<String, simt_CheckInstanceStatusController.InstanceStatus>();
         instanceMap.put('test', is);
         CIS.instanceMap = instanceMap;
         String res2 = simt_checkInstanceStatus.incidentAuthCallout('NA1');
         CIS.initialize();
         Test.stopTest();
    }
    @isTest static void testCallout3() {
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         String res3 = simt_checkInstanceStatus.calendarCallout();
         Test.stopTest();        
    }
}