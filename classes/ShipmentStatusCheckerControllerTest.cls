/**
 * Created by Aliaksandr Vabishchevich 28.10.24.
 */
@IsTest
public with sharing class ShipmentStatusCheckerControllerTest {
    private static final String TRACKING_NUMBER = '12345';
    @IsTest
    private static void getShipmentStatusTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ShipmentStatusCheckerControllerTestMock.ShipmentStatusCheckerControllerMock());
        Assert.areEqual(ShipmentStatusCheckerController.SHIPMENT_STATUS_RESPONSE, ShipmentStatusCheckerController.getShipmentStatus(TRACKING_NUMBER));
        Test.stopTest();
    }

}