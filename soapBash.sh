#!/bin/sh

echo "Hola"

#Program***************************
FOLDER=`pwd`
CONFIG_FILE="$FOLDER/config/config.cfg"
FUNCTIONS_FILE="$FOLDER/functions.sh"
SOAP_DATA_FOLDER="$FOLDER/SoapData"
PAYLOADS_FOLDER="$FOLDER/Payload"
HTTP_FOLDER="$FOLDER/HTTP"
LOG_FOLDER="$FOLDER/Logs"

#Leo la configuración del programa
. $CONFIG_FILE
#Cargo las funciones del fichero de "include"

. $FUNCTIONS_FILE


SOAP_ENVELOPE_BEGIN="$SOAP_DATA_FOLDER/$CFG_SOAP_ENVELOPE_BEGIN"
SOAP_HEADER_BEGIN="$SOAP_DATA_FOLDER/$CFG_SOAP_HEADER_BEGIN"
SOAP_HEADER_PAYLOAD="$PAYLOADS_FOLDER/$CFG_SOAP_HEADER_PAYLOAD"
SOAP_HEADER_END="$SOAP_DATA_FOLDER/$CFG_SOAP_HEADER_END"
SOAP_BODY_BEGIN="$SOAP_DATA_FOLDER/$CFG_SOAP_BODY_BEGIN"
SOAP_BODY_PAYLOAD="$PAYLOADS_FOLDER/$CFG_SOAP_BODY_PAYLOAD"
SOAP_BODY_END="$SOAP_DATA_FOLDER/$CFG_SOAP_BODY_END"
SOAP_ENVELOPE_END="$SOAP_DATA_FOLDER/$CFG_SOAP_ENVELOPE_END"

SOAP_ACTION=`cat $PAYLOADS_FOLDER/soapAction.txt`

#Check de la URL del endpoint, si viene vacia del fichero de config, la pillo de los parámetros
if test -z "$CFG_ENDPOINT"
then
echo "Hola"
else
    ENDPOINT=$CFG_ENDPOINT
fi

#echo $CFG_SOAP_ENVELOPE_BEGIN

REQUEST=`cat  $SOAP_ENVELOPE_BEGIN $SOAP_HEADER_BEGIN $SOAP_HEADER_PAYLOAD $SOAP_HEADER_END $SOAP_BODY_BEGIN $SOAP_BODY_PAYLOAD $SOAP_BODY_END $SOAP_ENVELOPE_END`

echo $REQUEST
#curl --basic  --user  gabriel:password --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:Get" --data @test.xml $ENDPOINT

TIMESTAMP=$(timestamp)
LOG_FILE_REQ=$LOG_FOLDER"/"$TIMESTAMP"_REQ.log"
echo "FOLDER: $LOG_FILE_REQ"
#LOG_FILE_RESP=


#el -n  no pone un salto de linea el final
echo -n $REQUEST > $LOG_FILE_REQ
#printf $REQUEST > $LOG_FILE_REQ

echo "Adios"

#Function definitions.********************************************************
