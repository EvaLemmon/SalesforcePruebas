/*
 * Created by eva.lopez on 13/04/2023.
 */

import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ChatController.getContactList';

export default class ChatContainerlwc extends LightningElement {
    @wire(getContactList) contacts;
    chatCon = 'Chat con';
    chatOpened = false;

    expandirFila(event) {
        console.log("click!");

        if(this.chatOpened) {
            this.chatOpened = false;
        } else {
            this.chatOpened = true;
        }


    }
}