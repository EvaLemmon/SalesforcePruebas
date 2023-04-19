/*
 * Created by eva.lopez on 12/04/2023.
 */

import notification from '@salesforce/resourceUrl/notification';
import { LightningElement, api, track, wire } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi'
import {getRecord, getFieldValue} from 'lightning/uiRecordApi';
import getContactInfo from '@salesforce/apex/ChatController.getContactInfo';
import enviarMensaje from '@salesforce/apex/ChatController.enviarMensaje';

export default class WhatsappChat extends LightningElement {

    @api recordId;

    @track channelName = '/event/Message__e';
    subscription = {};
    currentFrom;
    currentContact = '';
    chatOpened = false;
    @track chatlist = [];

    connectedCallback(){
        getContactInfo({recordId : this.recordId}).then(
            result => {
                console.log('resultado', result);
                if(result.lstMessages.length > 0) {
                    this.chatlist.push.apply(this.chatlist, result.lstMessages);
                }
                this.currentContact = result.c;
            })
            .catch(error => {
                this.error = error;
            });
            this.handleSubscribe();
    }
    disconnectedCallback(){
        this.handleUnsubscribe();
    }

    playAudio() {
        console.log("sonido");
        let audio = new Audio();
        audio.src = notification;
        audio.load();
        audio.play();
    }


    handleSubscribe() {
            const thisReference = this;
            const messageCallback = function(response) {
                console.log('Mensaje recibido: ', JSON.stringify(response));
                var obj = response.data.payload;
                                this.playAudio();

                console.log(obj);
                this.chatlist.push(obj);
                console.log(chatlist);


                this.dispatchEvent(evt);
            }
            .bind(this)
            subscribe(this.channelName, -1, messageCallback).then(response => {
                this.subscription = response;
            });
        }


        handleUnsubscribe() {
            unsubscribe(this.subscription, response => {
                console.log('unsubscribe() response: ', JSON.stringify(response));
            });
        }

    mandarMensaje(){
        console.log(this.mensaje);
        this.mensaje = this.template.querySelector('lightning-input').value;

        let mensaje = this.mensaje;
           console.log(this.currentContact.Phone);

        let acontactomovil = this.currentContact.Phone;
                console.log(this.currentContact.LastName);

        let acontactonombre = this.currentContact.LastName;

        let mensajeaenviar = {
            Name : acontactonombre,
            Body__c : mensaje,
            From__c : '1304',
            To__c : acontactomovil,
            Recieved__c : false,
        }
        console.log(JSON.stringify(mensajeaenviar));
        this.chatlist.push(mensajeaenviar);
        enviarMensaje({mensajeaenviar : JSON.stringify(mensajeaenviar)}).then(
                                 result => {
                                     console.log('resultado', result);
                                    })
                                 .catch(error => {
                                     this.error = error;
                                 });

    this.template.querySelector('lightning-input').value = '';

    }


    //@wire(getMensajes) chatlist ;

}