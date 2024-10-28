Hello!
The current READMe file describes the test task to get Shipment Status through REST API and public endpoint based on the tracking number from the Standard Shipment page in Salesforce.
How it works:
User opens the Shipment Record Detail page then the Shipment Status will be automatically received if the tracking number field is not blank. If it's blank then user will see an error toast message - Status is not defined. The tracking number is blank or is not valid. Please contact your administrator.

Metadata:
1. LWC
   1.1 shipmentStatusChecker - Custom LWC component which contains logic to get Shipment Status based on the Tracking Number field. If the Tracking Number field is not empty then an API call will be executed. If it's blank then the user will see a toast message - Status is not defined. The tracking number is blank or is not valid. Please contact your administrator.
   If a user changes any other field that is not related to the Tracking Number then the API call will not be executed.
2. Apex classes:
   2.1 ShipmentStatusCheckerContoller contains logic to perform API call to get Shipment Status based on the tracking number. All API details are stored in Custom Metadata Type - API Detail.
   If an error occurs during the API call then an Error Log record will be created with details of the error and the user will see an error toast message - Something went wrong with getting the Shipment Status. Please contact your administrator.
   2.2 ShipmentStatusCheckerContollerTest contains test logic to cover ShipmentStatusCheckerContoller.
   2.3 ShipmentStatusCheckerContollerTestMock contains logic to create a mock for the Test class.
   2.4 ErrorLogHandler contains logic to create an Error Log record if any error occurs during an API call.
3. Custom Metadata Type
   3.1 API Details
     Fields:
     3.1.1 Method
     3.1.2. Endpoint URL
     3.1.3. Authorization Header
     3.1.4. Content-Type
     3.1.5. API Timeout

   
   
   
