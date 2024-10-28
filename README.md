<h1>Hello!</h1>
<p>The current READMe file describes the test task to get Shipment Status through REST API and public endpoint based on the tracking number from the Standard Shipment page in Salesforce.</p>
<p><b>How it works:</b></p>
User opens the Shipment Record Detail page then the Shipment Status will be automatically received if the tracking number field is not blank. If it's blank then user will see an error toast message - Status is not defined. The tracking number is blank or is not valid. Please contact your administrator.

Metadata:
<ol type="1">
   <li>LWC</li>
      <ol type="1">
         <li>shipmentStatusChecker - Custom LWC component which contains logic to get Shipment Status based on the Tracking Number field. If the Tracking Number field is not empty then an API call will be executed. If it's blank then the user will see a toast message - <b><i>Status is not defined. The tracking number is blank or is not valid. Please contact your administrator.</i></b>
   If a user changes any other field that is not related to the Tracking Number then the API call will not be executed.</li>
      </ol>
   <li>Apex Classes</li>
            <ol type="1">
               <li>ShipmentStatusCheckerContoller contains logic to perform API call to get Shipment Status based on the tracking number. All API details are stored in Custom Metadata Type - API Detail.
   If an error occurs during the API call then an Error Log record will be created with details of the error and the user will see an error toast message - <b><i>Something went wrong with getting the Shipment Status. Please contact your administrator</i></b></li>
               <li>ShipmentStatusCheckerContollerTest contains test logic to cover ShipmentStatusCheckerContoller.</li>
               <li>ShipmentStatusCheckerContollerTestMock contains logic to create a mock for the Test class.</li>
               <li>ErrorLogHandler contains logic to create an Error Log record if any error occurs during an API call.</li>
            </ol>
            <li>Custom Metadata Type</li>
            <ol type="1">
               <li>API Details</li>
               <ol>
                  <li>Fields:</li>
                  <ol type="1">
                     <li>Method</li>
                    <li>Endpoint URL</li>
                    <li>Authorization Header</li>
                    <li>Content-Type</li>
                    <li>API Timeout</li>
                  </ol>
               </ol>
            </ol>
</ol>


   
   
   
