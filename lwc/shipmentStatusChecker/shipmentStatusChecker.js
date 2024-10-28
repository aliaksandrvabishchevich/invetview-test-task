/**
 * Created by Aliaksandr Vabishchevich 28.10.24.
 */

//lwc standard actions
import {LightningElement, wire, api, track} from 'lwc';
import {getRecord} from "lightning/uiRecordApi";
import {ShowToastEvent} from "lightning/platformShowToastEvent";

//fields
import SHIPMENT_TRACKING_NUMBER_FIELD from '@salesforce/schema/Shipment__c.Tracking_Number__c';

//apex methods
import getShipmentStatus from '@salesforce/apex/ShipmentStatusCheckerController.getShipmentStatus';
//custom labels
import Current_Status from '@salesforce/label/c.Current_Status'
import Shipment_Status_Error_Message from '@salesforce/label/c.Shipment_Status_Error_Message'
import Status_Is_Not_Defined_Error_Message from '@salesforce/label/c.Status_Is_Not_Defined_Error_Message'

const TITLE_TOAST_ERROR = 'Error';
const VARIANT_TOAST_ERROR = 'error';
export default class ShipmentStatusChecker extends LightningElement {
    label = {
        Current_Status
    };

    @api recordId;
    @track shipmentStatus;
    @track isLoaded = false;
    previousTrackingNumber;

    @wire(getRecord, {recordId : '$recordId', fields : [
        SHIPMENT_TRACKING_NUMBER_FIELD
        ]})
    async wireShipmentDetails({error, data}) {
        if (data) {
            let trackingNumber = data.fields.Tracking_Number__c.value;
            if (trackingNumber) {
                if (trackingNumber !== this.previousTrackingNumber) {
                    await this.makeShipmentStatusCall(trackingNumber);
                    this.previousTrackingNumber = trackingNumber;
                }
            } else {
                this.shipmentStatus = '';
                this.previousTrackingNumber = '';
                this.showToast(TITLE_TOAST_ERROR, VARIANT_TOAST_ERROR, Status_Is_Not_Defined_Error_Message)
            }
            this.isLoaded = true;
        } else if (error) {
            this.showToast(TITLE_TOAST_ERROR, VARIANT_TOAST_ERROR, Shipment_Status_Error_Message);
        }
    }

    async makeShipmentStatusCall(trackingNumber) {
        await getShipmentStatus({trackingNumber: trackingNumber}).then((response) => {
            if (response) {
                this.shipmentStatus = response;
            } else {
                this.showToast(TITLE_TOAST_ERROR, VARIANT_TOAST_ERROR, Shipment_Status_Error_Message);
            }
        })
    }

    showToast(title, variant, message) {
        const event = new ShowToastEvent({
            title: title,
            variant: variant,
            message: message
        });
        this.dispatchEvent(event);
    }

}