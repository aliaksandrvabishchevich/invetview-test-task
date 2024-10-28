/**
 * Created by Aliaksandr Vabishchevich 28.10.24.
 */
@IsTest
global with sharing class ShipmentStatusCheckerControllerTestMock {
    global class ShipmentStatusCheckerControllerMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest request) {

            API_Detail__mdt apiDetails = API_Detail__mdt.getInstance(ShipmentStatusCheckerController.SHIPMENT_STATUS_API_NAME);
            HttpResponse response = new HttpResponse();
//            response.setHeader(apiDetails.Authorization_Header__c, apiDetails.Content_Type__c);
            response.setBody(ShipmentStatusCheckerController.SHIPMENT_STATUS_RESPONSE);
            response.setStatusCode(200);
            return response;
        }
    }

}