@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Accept-Encoding', 'gzip,deflate');
        res.setHeader('Content-Type', 'application/xml');
        res.setBody('<table class="instance-schedule-table" style="display: none;"><tbody><tr>  <th>Instance(s)</th>  <th>Name</th>  <th>Start (UTC)</th>  <th>End (UTC)</th>  <th>Message</th></tr>  </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Jan-2016" style="display: none;">		  <tr><td>NA1</td><td>Database Maintenance</td><td width="20%">Jan 03 2016, 03:00</td><td width="20%">Jan 03 2016, 03:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA24</td><td>Database Maintenance</td><td width="20%">Jan 03 2016, 09:00</td><td width="20%">Jan 03 2016, 11:00</td><td>The instance will be available in Read-Only mode during this maintenance window.<br></td>            </tr>         <tr><td>CS80</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 00:00</td><td width="20%">Jan 09 2016, 00:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS4, CS7, CS9, CS12, CS28, CS30, CS51, CS83, CS87</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 02:00</td><td width="20%">Jan 09 2016, 02:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS3, CS19, CS23, CS25, CS26, CS44, CS45</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 03:00</td><td width="20%">Jan 09 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS11, CS13, CS14, CS15, CS17, CS20, CS21, CS32, CS41, CS42</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 04:00</td><td width="20%">Jan 09 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS5</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 16:00</td><td width="20%">Jan 09 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS31</td><td>Spring "16 Major Release</td><td width="20%">Jan 09 2016, 18:00</td><td width="20%">Jan 09 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA1</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 10 2016, 03:00</td><td width="20%">Jan 10 2016, 03:20</td><td><br>During this Live Agent maintenance, the Live Agent, Omni Channel and SOS functionalities will be unavailable. <br>If you do not use If you do not use Live Agent, Omni Channel or SOS, there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA1</td><td>Spring "16 Major Release</td><td width="20%">Jan 16 2016, 04:00</td><td width="20%">Jan 16 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS6</td><td>Database Maintenance</td><td width="20%">Jan 16 2016, 17:00</td><td width="20%">Jan 16 2016, 17:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP1, AP4</td><td>Database Maintenance</td><td width="20%">Jan 16 2016, 17:00</td><td width="20%">Jan 16 2016, 17:55</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP0, AP3</td><td>Database Maintenance</td><td width="20%">Jan 16 2016, 18:00</td><td width="20%">Jan 16 2016, 18:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP2</td><td>Database Maintenance</td><td width="20%">Jan 16 2016, 18:00</td><td width="20%">Jan 16 2016, 18:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS86</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 01:00</td><td width="20%">Jan 17 2016, 01:35</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS82</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 01:00</td><td width="20%">Jan 17 2016, 01:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU6, CS81</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 01:00</td><td width="20%">Jan 17 2016, 01:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU5</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 01:00</td><td width="20%">Jan 17 2016, 01:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU1, EU3, EU4, CS8</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 03:00</td><td width="20%">Jan 17 2016, 03:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS2, NA16, CS1</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 03:00</td><td width="20%">Jan 17 2016, 03:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS52</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 04:00</td><td width="20%">Jan 17 2016, 04:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA8, NA26, NA28, NA33</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 04:00</td><td width="20%">Jan 17 2016, 04:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU0</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 04:00</td><td width="20%">Jan 17 2016, 04:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA5</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 04:00</td><td width="20%">Jan 17 2016, 04:55</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA6, NA21, NA29</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 05:00</td><td width="20%">Jan 17 2016, 05:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS16, CS18</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 05:00</td><td width="20%">Jan 17 2016, 05:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS33</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 05:00</td><td width="20%">Jan 17 2016, 05:55</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA9</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 06:00</td><td width="20%">Jan 17 2016, 06:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA12, NA4, NA13, NA19, NA20</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 06:00</td><td width="20%">Jan 17 2016, 06:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA3, CS40, CS43</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 07:00</td><td width="20%">Jan 17 2016, 07:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA32, CS24, CS10, CS50</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 07:00</td><td width="20%">Jan 17 2016, 07:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS22</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 07:00</td><td width="20%">Jan 17 2016, 07:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA30, NA41</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 08:00</td><td width="20%">Jan 17 2016, 08:35</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA17, NA2, NA11, NA14, NA23</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 08:00</td><td width="20%">Jan 17 2016, 08:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA15</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 09:00</td><td width="20%">Jan 17 2016, 09:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA27, NA24, NA25</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 09:00</td><td width="20%">Jan 17 2016, 09:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA18, NA22</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 09:00</td><td width="20%">Jan 17 2016, 09:50</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA34, NA7, NA10</td><td>Database Maintenance</td><td width="20%">Jan 17 2016, 09:00</td><td width="20%">Jan 17 2016, 09:55</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP0, AP1, AP2, AP3, AP4</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 23 2016, 18:00</td><td width="20%">Jan 23 2016, 18:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>EU4, EU6</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 01:00</td><td width="20%">Jan 24 2016, 01:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>EU1, EU0, EU2, EU3, EU5</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 02:00</td><td width="20%">Jan 24 2016, 02:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA5, NA13, NA19, NA33</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 03:00</td><td width="20%">Jan 24 2016, 03:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA4, NA16, NA20</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 04:00</td><td width="20%">Jan 24 2016, 04:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA31</td><td>Database Maintenance</td><td width="20%">Jan 24 2016, 04:00</td><td width="20%">Jan 24 2016, 04:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA0, NA3, NA7, NA26, NA30</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 05:00</td><td width="20%">Jan 24 2016, 05:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA6, NA24, NA25, NA27, NA28, NA29, NA31</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 06:00</td><td width="20%">Jan 24 2016, 06:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA8, NA9, NA10, NA11, NA12, NA14, NA32, NA34</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 07:00</td><td width="20%">Jan 24 2016, 07:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>NA2, NA15, NA17, NA18, NA22, NA23, NA41</td><td>Live Agent Database Maintenance</td><td width="20%">Jan 24 2016, 08:00</td><td width="20%">Jan 24 2016, 08:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Feb-2016" style="display: table-row-group;">		  <tr><td>EU1, EU2, EU5</td><td>Live Agent Database Maintenance</td><td width="20%">Feb 01 2016, 03:00</td><td width="20%">Feb 01 2016, 03:15</td><td><br>During this maintenance, the Live Agent, Omni-Channel and SOS functionalities will be unavailable. <br>If you do not use Live Agent, Omni-Channel or SOS there will be no impact to your Salesforce service.</td>            </tr>         <tr><td>EU5</td><td>Spring "16 Major Release</td><td width="20%">Feb 06 2016, 02:00</td><td width="20%">Feb 06 2016, 02:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA6, NA29</td><td>Spring "16 Major Release</td><td width="20%">Feb 06 2016, 04:00</td><td width="20%">Feb 06 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA8, NA9, NA28, NA31</td><td>Spring "16 Major Release</td><td width="20%">Feb 06 2016, 06:00</td><td width="20%">Feb 06 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA7, NA17, NA18, NA22</td><td>Spring "16 Major Release</td><td width="20%">Feb 06 2016, 07:00</td><td width="20%">Feb 06 2016, 07:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS83</td><td>Database Maintenance</td><td width="20%">Feb 06 2016, 22:00</td><td width="20%">Feb 06 2016, 23:15</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU6</td><td>Site Switching</td><td width="20%">Feb 07 2016, 00:00</td><td width="20%">Feb 07 2016, 00:30</td><td>The instance will generally be available in read-only mode for a portion of this maintenance window.<br></td>            </tr>         <tr><td>EU4</td><td>Site Switching</td><td width="20%">Feb 07 2016, 03:00</td><td width="20%">Feb 07 2016, 03:30</td><td>The instance will generally be available in read-only mode for a portion of this maintenance window.<br></td>            </tr>         <tr><td>EU2</td><td>Database Maintenance</td><td width="20%">Feb 07 2016, 03:00</td><td width="20%">Feb 07 2016, 03:40</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS44</td><td>Database Maintenance</td><td width="20%">Feb 07 2016, 03:00</td><td width="20%">Feb 07 2016, 04:15</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA0</td><td>Database Maintenance</td><td width="20%">Feb 07 2016, 04:00</td><td width="20%">Feb 07 2016, 04:45</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU0</td><td>Spring "16 Major Release</td><td width="20%">Feb 12 2016, 22:00</td><td width="20%">Feb 12 2016, 22:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU1, EU2, EU3, EU4, EU6, CS81, CS82, CS86</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 00:00</td><td width="20%">Feb 13 2016, 00:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA0, NA3, NA16, NA21, NA32</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 04:00</td><td width="20%">Feb 13 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA4, NA5, NA26, NA33, NA34</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 05:00</td><td width="20%">Feb 13 2016, 05:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA10, NA11, NA12, NA23, NA24, NA30, NA41</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 06:00</td><td width="20%">Feb 13 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA2, NA13, NA14, NA15, NA19, NA20, NA25, NA27</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 07:00</td><td width="20%">Feb 13 2016, 07:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS6</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 16:00</td><td width="20%">Feb 13 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP1, AP4, CS40</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 17:00</td><td width="20%">Feb 13 2016, 17:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS50, CS33, CS43, AP2, CS1, CS2, CS8, CS10, CS16, CS18, CS24, CS22</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 18:00</td><td width="20%">Feb 13 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP0, AP3, CS52</td><td>Spring "16 Major Release</td><td width="20%">Feb 13 2016, 19:00</td><td width="20%">Feb 13 2016, 19:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS2, CS12</td><td>Instance Migration</td><td width="20%">Feb 21 2016, 03:00</td><td width="20%">Feb 21 2016, 04:30</td><td>The instance will be available in Read-Only mode during this maintenance window.<br></td>            </tr>         <tr><td>CS4, CS42</td><td>Database Maintenance</td><td width="20%">Feb 21 2016, 03:00</td><td width="20%">Feb 21 2016, 05:00</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Mar-2016" style="display: none;">		  <tr><td>NA24, NA25</td><td>Database Maintenance</td><td width="20%">Mar 06 2016, 10:00</td><td width="20%">Mar 06 2016, 11:59</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS40, EU2</td><td>Database Maintenance</td><td width="20%">Mar 20 2016, 02:00</td><td width="20%">Mar 20 2016, 04:00</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Apr-2016" style="display: none;">		  <tr><td>NA26, CS86</td><td>Database Maintenance</td><td width="20%">Apr 03 2016, 02:00</td><td width="20%">Apr 03 2016, 04:00</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA1</td><td>Instance Refresh</td><td width="20%">Apr 03 2016, 02:00</td><td width="20%">Apr 03 2016, 06:00</td><td>The instance will be available in Read-Only mode during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-May-2016" style="display: none;">		  <tr><td>CS80</td><td>Summer "16 Major Release</td><td width="20%">May 06 2016, 23:00</td><td width="20%">May 06 2016, 23:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS4, CS7, CS9, CS12, CS28, CS30, CS51, CS83, CS87</td><td>Summer "16 Major Release</td><td width="20%">May 07 2016, 01:00</td><td width="20%">May 07 2016, 01:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS3, CS19, CS23, CS25, CS26, CS44, CS45</td><td>Summer "16 Major Release</td><td width="20%">May 07 2016, 02:00</td><td width="20%">May 07 2016, 02:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS13, CS14, CS15, CS17, CS20, CS21, CS32, CS41, CS42, CS11</td><td>Summer "16 Major Release</td><td width="20%">May 07 2016, 03:00</td><td width="20%">May 07 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS5</td><td>Summer "16 Major Release</td><td width="20%">May 07 2016, 16:00</td><td width="20%">May 07 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS31</td><td>Summer "16 Major Release</td><td width="20%">May 07 2016, 18:00</td><td width="20%">May 07 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA1</td><td>Summer "16 Major Release</td><td width="20%">May 21 2016, 03:00</td><td width="20%">May 21 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Jun-2016" style="display: none;">		  <tr><td>EU5</td><td>Summer "16 Major Release</td><td width="20%">Jun 04 2016, 01:00</td><td width="20%">Jun 04 2016, 01:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA6, NA29</td><td>Summer "16 Major Release</td><td width="20%">Jun 04 2016, 03:00</td><td width="20%">Jun 04 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA8, NA9, NA28, NA31</td><td>Summer "16 Major Release</td><td width="20%">Jun 04 2016, 05:00</td><td width="20%">Jun 04 2016, 05:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA7, NA17, NA18, NA22</td><td>Summer "16 Major Release</td><td width="20%">Jun 04 2016, 06:00</td><td width="20%">Jun 04 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU0</td><td>Summer "16 Major Release</td><td width="20%">Jun 10 2016, 21:00</td><td width="20%">Jun 10 2016, 21:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU1, EU2, EU3, EU4, EU6, CS81, CS82, CS86</td><td>Summer "16 Major Release</td><td width="20%">Jun 10 2016, 23:00</td><td width="20%">Jun 10 2016, 23:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA0, NA3, NA16, NA21, NA32</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 03:00</td><td width="20%">Jun 11 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA34, NA33, NA26, NA4, NA5</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 04:00</td><td width="20%">Jun 11 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA10, NA11, NA12, NA23, NA24, NA30, NA41</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 05:00</td><td width="20%">Jun 11 2016, 05:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA2, NA13, NA14, NA15, NA19, NA20, NA25, NA27</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 06:00</td><td width="20%">Jun 11 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS6</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 16:00</td><td width="20%">Jun 11 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP1, AP4, CS40</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 17:00</td><td width="20%">Jun 11 2016, 17:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS50, CS33, CS43, AP2, CS1, CS2, CS8, CS10, CS16, CS18, CS24, CS22</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 18:00</td><td width="20%">Jun 11 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP0, AP3, CS52</td><td>Summer "16 Major Release</td><td width="20%">Jun 11 2016, 19:00</td><td width="20%">Jun 11 2016, 19:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Jul-2016" style="display: none;">		  </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Aug-2016" style="display: none;">		  </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Sep-2016" style="display: none;">		  <tr><td>CS80</td><td>Winter "17 Major Release</td><td width="20%">Sep 09 2016, 23:00</td><td width="20%">Sep 09 2016, 23:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS28, CS30, CS87, CS4, CS7, CS9, CS12, CS51, CS83</td><td>Winter "17 Major Release</td><td width="20%">Sep 10 2016, 01:00</td><td width="20%">Sep 10 2016, 01:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS25, CS26, CS44, CS45, CS23, CS3, CS19</td><td>Winter "17 Major Release</td><td width="20%">Sep 10 2016, 02:00</td><td width="20%">Sep 10 2016, 02:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS11, CS13, CS14, CS15, CS17, CS20, CS21, CS32, CS41, CS42</td><td>Winter "17 Major Release</td><td width="20%">Sep 10 2016, 03:00</td><td width="20%">Sep 10 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS5</td><td>Winter "17 Major Release</td><td width="20%">Sep 10 2016, 16:00</td><td width="20%">Sep 10 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS31</td><td>Winter "17 Major Release</td><td width="20%">Sep 10 2016, 18:00</td><td width="20%">Sep 10 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA1</td><td>Winter "17 Major Release</td><td width="20%">Sep 17 2016, 03:00</td><td width="20%">Sep 17 2016, 05:00</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Oct-2016" style="display: none;">		  <tr><td>EU5</td><td>Winter "17 Major Release</td><td width="20%">Oct 08 2016, 01:00</td><td width="20%">Oct 08 2016, 01:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA6, NA29</td><td>Winter "17 Major Release</td><td width="20%">Oct 08 2016, 03:00</td><td width="20%">Oct 08 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA8, NA9, NA28, NA31</td><td>Winter "17 Major Release</td><td width="20%">Oct 08 2016, 05:00</td><td width="20%">Oct 08 2016, 05:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA17, NA22, NA18, NA7</td><td>Winter "17 Major Release</td><td width="20%">Oct 08 2016, 06:00</td><td width="20%">Oct 08 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU0</td><td>Winter "17 Major Release</td><td width="20%">Oct 14 2016, 21:00</td><td width="20%">Oct 14 2016, 21:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>EU1, EU2, EU3, EU4, EU6, CS81, CS82, CS86</td><td>Winter "17 Major Release</td><td width="20%">Oct 14 2016, 23:00</td><td width="20%">Oct 14 2016, 23:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA0, NA3, NA16, NA21, NA32</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 03:00</td><td width="20%">Oct 15 2016, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA4, NA5, NA26, NA33, NA34</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 04:00</td><td width="20%">Oct 15 2016, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA10, NA11, NA12, NA23, NA24, NA30, NA41</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 05:00</td><td width="20%">Oct 15 2016, 05:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA2, NA13, NA14, NA15, NA19, NA20, NA25, NA27</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 06:00</td><td width="20%">Oct 15 2016, 06:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS6</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 16:00</td><td width="20%">Oct 15 2016, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP1, AP4, CS40</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 17:00</td><td width="20%">Oct 15 2016, 17:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP2, CS1, CS2, CS8, CS10, CS16, CS18, CS22, CS24, CS33, CS43, CS50</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 18:00</td><td width="20%">Oct 15 2016, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>AP3, AP0, CS52</td><td>Winter "17 Major Release</td><td width="20%">Oct 15 2016, 19:00</td><td width="20%">Oct 15 2016, 19:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Nov-2016" style="display: none;">		  </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Dec-2016" style="display: none;">		  </tbody><tbody class="instance-schedule-table-month" id="instance-schedule-table-Jan-2017" style="display: none;">		  <tr><td>CS80</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 00:00</td><td width="20%">Jan 07 2017, 00:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS4, CS7, CS9, CS12, CS28, CS30, CS51, CS83, CS87</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 02:00</td><td width="20%">Jan 07 2017, 02:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS25, CS26, CS44, CS45, CS23, CS27, CS3, CS19</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 03:00</td><td width="20%">Jan 07 2017, 03:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS11, CS13, CS14, CS15, CS17, CS20, CS21, CS32, CS41, CS42</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 04:00</td><td width="20%">Jan 07 2017, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS5</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 16:00</td><td width="20%">Jan 07 2017, 16:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>CS31</td><td>Spring "17 Major Release</td><td width="20%">Jan 07 2017, 18:00</td><td width="20%">Jan 07 2017, 18:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         <tr><td>NA1</td><td>Spring "17 Major Release</td><td width="20%">Jan 14 2017, 04:00</td><td width="20%">Jan 14 2017, 04:05</td><td>This instance will not be available during this maintenance window.<br></td>            </tr>         </tbody></table>');
        res.setStatusCode(200);
        return res;
    }
   
   
}