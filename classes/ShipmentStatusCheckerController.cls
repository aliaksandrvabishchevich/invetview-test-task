/**
 * Created by Aliaksandr Vabishchevich 28.10.24.
 */

public with sharing class ShipmentStatusCheckerController {
    @TestVisible
    private static final String SHIPMENT_STATUS_API_NAME = 'Shipment_Status';
    @TestVisible
    private static final String SHIPMENT_STATUS_RESPONSE = 'Shipped- On Time';
    private static final Integer STATUS_CODE_200 = 200;
    private static final String SHIPMENT_STATUS_CHECKER_CONTROLLER_CLASS_NAME = ShipmentStatusCheckerController.class.getName();

    @AuraEnabled
    public static String getShipmentStatus(String trackingNumber) {
        return performShipmentStatusCall(trackingNumber);
    }

    private static String performShipmentStatusCall(String trackingNumber) {
        try {
            API_Detail__mdt apiDetail = API_Detail__mdt.getInstance(SHIPMENT_STATUS_API_NAME);
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod(apiDetail.Method__c);
            request.setEndpoint(apiDetail.Endpoint_URL__c + trackingNumber);
            request.setHeader(apiDetail.Authorization_Header__c, apiDetail.Content_Type__c);
            Integer timeOut = apiDetail.API_Timeout__c != null && apiDetail.API_Timeout__c > 0 ? Integer.valueOf(apiDetail.API_Timeout__c) : 120000;
            request.setTimeout(timeOut);
            HttpResponse response = http.send(request);

            String shipmentStatus;
            if (response.getStatusCode() == STATUS_CODE_200) {
                shipmentStatus = response.getBody();
            } else {
                String errorMessage = response.getStatusCode() + ' ' + response.getStatus() + ', Body: ' + response.getBody();
                ErrorLogHandler.createErrorLog(SHIPMENT_STATUS_CHECKER_CONTROLLER_CLASS_NAME, errorMessage);
            }
            return shipmentStatus;
        } catch (Exception e) {
            String errorMessage = e.getStackTraceString() +'<br/>' + e.getMessage() + '<br/>' + e.getCause() +' <br/>'+ e.getTypeName();
            ErrorLogHandler.createErrorLog(SHIPMENT_STATUS_CHECKER_CONTROLLER_CLASS_NAME, errorMessage);
        }
        return null;
    }

}