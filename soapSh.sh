#!/bin/bash

#Program***************************
FOLDER=`pwd`
CONFIG_FILE="$FOLDER/config/config.cfg"
FUNCTIONS_FILE="$FOLDER/include/functions.sh"
SOAP_DATA_FOLDER="$FOLDER/SoapData"
#LOG_FOLDER="$FOLDER/Logs"

#Cargo las funciones del fichero de "include"
if [[ -f $FUNCTIONS_FILE ]]; then
    . $FUNCTIONS_FILE
else
    echo "ERROR al cargar el fichero de funciones."
    exit 1
fi

#Leo la configuración del programa
if [[ -f $CONFIG_FILE ]]; then
    . $CONFIG_FILE
else
    printERROR "No se pudo cargar el fichero de configuración"
    exit 1
fi

echo "soapBash  v${CFG_VERSION} by ${CFG_AUTHOR}"

#En caso que NO hayan parámetros mostramos la ayuda.
if [ $# -eq 0 ];
then
    help
    exit 1
fi

#Parseamos el array de parámetros de entrada
POSITIONAL=()

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
    #Nombre WS
        -n|--name)
            WS_NAME=$2
            shift
            shift
        ;;
    #Config del curl
        --curl-cfg)
        #Para pasarle la opción -K o --config <file> a curl
            CURL_FILE=$2
            shift
            shift
        ;;
    #Config del WS
        --ws-dir)
        #Cargamos la carpeta donde está la configuración del WS
            WS_DIR=$2
            . "${WS_DIR}/ws.cfg"
            shift
            shift
        ;;        
    #Credenciales
        -u|--user)
        echo "SET USER"
            SOAP_USER=$2
            shift
            shift
        ;;
    #SOAP version
        --soap-version)
            SOAP_VERSION=$2
            shift
            shift
        ;;
    #Modo verbose
        -v|--verbose)
            VERBOSE=true
            shift # past argument
            #shift # past value
            #Como se supone que va SIN argumentos,  hago solo un shift
        ;;
    #Ayuda
        -h|--help)
            help
            exit 0
        ;;
    #others....
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

#Check que todos los parámetros obligatorios estén informados TODO.
verbose "Configurando la llamada SOAP..."
if [[ -z "${CURL_FILE}" ]]; then
    printERROR "No se ha encontrado configuración de CURL"
    exit 1
elif [[ ! -f ${CURL_FILE} ]]; then
    #La variable existe por lo que compruebo que existe el fichero
    printERROR "No se ha encontrado el fichero de configuración CURL"
    exit 1
fi

#Genero el request.
verbose "Generando el request..."
#Primero cargo los tags soap segun la versión.
    case $SOAP_VERSION in
    #version 1.2
        v1.2|1.2)
            SOAP_VERSION="v1.2"
        ;;
    #version 1.1
        v1.1|1.1)
            SOAP_VERSION="v1.1"
        ;;
    #others....
        *)    # default option
            SOAP_VERSION="v1.1"        
        ;;
    esac

SOAP_ENVELOPE_BEGIN="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_ENVELOPE_BEGIN}"
SOAP_HEADER_BEGIN="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_HEADER_BEGIN}"
#SOAP_HEADER_PAYLOAD="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_HEADER_PAYLOAD}"
SOAP_HEADER_END="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_HEADER_END}"
SOAP_BODY_BEGIN="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_BODY_BEGIN}"
#SOAP_BODY_PAYLOAD="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_BODY_PAYLOAD}"
SOAP_BODY_END="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_BODY_END}"
SOAP_ENVELOPE_END="${SOAP_DATA_FOLDER}/${SOAP_VERSION}/${CFG_SOAP_ENVELOPE_END}"

REQUEST=`cat  $SOAP_ENVELOPE_BEGIN $SOAP_HEADER_BEGIN $SOAP_HEADER_PAYLOAD $SOAP_HEADER_END $SOAP_BODY_BEGIN $SOAP_BODY_PAYLOAD $SOAP_BODY_END $SOAP_ENVELOPE_END`

#echo $REQUEST
verbose "Creando los nombres de fichero de log..."
TIMESTAMP=$(timestamp)
LOG_EXECUTION_FOLDER="${CFG_LOG_FOLDER}/${WS_NAME}_${TIMESTAMP}"
LOG_FILE_REQ_PAYLOAD="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}_Req_Payload.log"
LOG_FILE_REQ_HEADERS="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}_Req_Headers.hdr"
LOG_FILE_RESP_PAYLOAD="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}_Resp_Payload.log"
LOG_FILE_RESP_HEADERS="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}_Resp_Headers.hdr"
LOG_FILE_ERROR="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}.err"
LOG_FILE_TRACE="${LOG_EXECUTION_FOLDER}/${WS_NAME}_${TIMESTAMP}.trc"

#Creo la carpeta de la petición.
mkdir "$LOG_EXECUTION_FOLDER"

#Hago la llamada
echo -n $REQUEST > $LOG_FILE_REQ_PAYLOAD

#curl --config "${CURL_FOLDER}/${CURL_CFG}" --data-binary @"$LOG_FILE_REQ"  -o "${LOG_FILE_RESP}" #--basic --user gabriel:pass
#PARAMS="--config ${CURL_FOLDER}/${CURL_CFG}"
PARAMS="--config ${CURL_FILE}"
PARAMS="${PARAMS} --data-binary @${LOG_FILE_REQ_PAYLOAD}"
PARAMS="${PARAMS} --stderr ${LOG_FILE_ERROR}"
PARAMS="${PARAMS} --output ${LOG_FILE_RESP_PAYLOAD}"
PARAMS="${PARAMS} --dump-header ${LOG_FILE_RESP_HEADERS}"
PARAMS="${PARAMS} --trace-ascii ${LOG_FILE_TRACE}"
#En caso que hayamos establecido usuario y contrasenya por parámetros, se lo indicamos en los parametros.
if test ! -z "${SOAP_USER}"
then
    PARAMS="${PARAMS} --basic --user ${SOAP_USER}"
fi

verbose "PARAMETROS: $PARAMS"
curl $PARAMS 

echo "Fin del programa, revisa los resultados en la carpeta de Logs: ${CFG_LOG_FOLDER}"