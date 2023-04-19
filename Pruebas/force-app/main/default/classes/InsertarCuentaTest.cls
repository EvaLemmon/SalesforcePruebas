/**
 * Created by eva.lopez on 29/03/2023.
 */
@IsTest
public with sharing class InsertarCuentaTest {
    @IsTest
    static void ProbarCuenta() {
        InsertarCuenta.insertarCuentaNueva('Prueba', '12345678N');
    }
}