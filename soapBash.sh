#!/bin/bash

#echo "Hola"

#Program***************************
FOLDER=`pwd`
CONFIG_FILE="$FOLDER/config/config.cfg"
FUNCTIONS_FILE="$FOLDER/functions.sh"
SOAP_DATA_FOLDER="$FOLDER/SoapData"
PAYLOADS_FOLDER="$FOLDER/Payload"
HTTP_FOLDER="$FOLDER/HTTP"
LOG_FOLDER="$FOLDER/Logs"
VERSION="0.1"
AUTHOR="gabriel.reusrodriguez@csi.cat"

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


#Parámetros de entrada.
POSITIONAL=()
#declare -A POSITIONAL
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--verbose)
        PARAM_VERBOSE="$2"
        shift # past argument
        shift # past value
    ;;
    -h|--help)
        help
        exit 0
    ;;

    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac

#case $key in
#    -e|--extension)
#    EXTENSION="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    -s|--searchpath)
#    SEARCHPATH="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    -l|--lib)
#    LIBPATH="$2"
#    shift # past argument
#    shift # past value
#    ;;
#    --default)
#    DEFAULT=YES
#    shift # past argument
#    ;;
#    *)    # unknown option
#    POSITIONAL+=("$1") # save it in an array for later
#    shift # past argument
#    ;;
#esac

done
set -- "${POSITIONAL[@]}" # restore positional parameters

#Check de la URL del endpoint, si viene vacia del fichero de config, la pillo de los parámetros
if test -z "$CFG_ENDPOINT"
then
echo "Hola"
else
    ENDPOINT=$CFG_ENDPOINT
fi

#Genero el request.
REQUEST=`cat  $SOAP_ENVELOPE_BEGIN $SOAP_HEADER_BEGIN $SOAP_HEADER_PAYLOAD $SOAP_HEADER_END $SOAP_BODY_BEGIN $SOAP_BODY_PAYLOAD $SOAP_BODY_END $SOAP_ENVELOPE_END`

#echo $REQUEST

TIMESTAMP=$(timestamp)
LOG_FILE_REQ="${LOG_FOLDER}/${TIMESTAMP}_REQ.log"
LOG_FILE_RESP="${LOG_FOLDER}/${TIMESTAMP}_RESP.log"
#echo "FOLDER: $LOG_FILE_REQ"
#LOG_FILE_RESP=

#Hago la llamada
#curl --basic  --user  gabriel:password --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:Get" --data @test.xml $ENDPOINT

#Log de petición y respuesta El -n  no pone un salto de linea el final
echo -n $REQUEST > $LOG_FILE_REQ
#printf $REQUEST > $LOG_FILE_REQ

echo "Adios"