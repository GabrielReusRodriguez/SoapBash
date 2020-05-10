#!/bin/bash


#LOG_FILE_RESP_PAYLOAD='/home/gabriel/Proyectos/SoapSh/Logs/TeleseguimentApp_2020-05-06_23-28-13/TeleseguimentApp_2020-05-06_23-28-13_Resp_Payload.log'

XML=`grep -oP '<.+' ${LOG_FILE_RESP_PAYLOAD}`

XML_FILE_TMP="${LOG_EXECUTION_FOLDER}/tmp/response.xml"

#https://stackoverflow.com/questions/17002324/xmllint-validate-an-xml-file-against-two-xsd-schemas-envelope-payload

test -f ${XML_FILE_TMP} || touch ${XML_FILE_TMP}
#if [[ ! -e {$XML_FILE_TMP} ]]; then
#    #mkdir -p /Scripts
#    touch {$XML_FILE_TMP}
#fi

echo "${XML}" > ${XML_FILE_TMP}

#Validamos la estructura SOAP.
xmllint --schema "${SOAP_DATA_FOLDER}/${SOAP_VERSION}/schema.xsd" --noout ${XML_FILE_TMP}  2>/dev/null

#La coletilla se pone para que no imprima nada por pantalla.

#echo "valor retorno _$?_"
if [[ $? -eq 0 ]]; then 
    RESULTADO="OK"
else
    RESULTADO="FAIL"
fi

echo  -e "SOAP:\t${RESULTADO}\n" >> ${LOG_FILE_VALIDATION}


#xpath //swid:product_version/swid:name/text()

#xmlparse ${XML_FILE_TMP}


#xmllint --schema yourxsd.xsd yourxml.xml --noout

#xmlparse ${XML}
#xmlparse valida la estructura deun xml

#Con greps buscamos SOAP:fault en el response y si nos animamos, parseamos buscando un codigo de error OK. como por ejemplo HC3_AGE_000
#Validador
#Retornamos 0 si todo va bien, 1 si consideramos que ha habido error.

#Primero checkeamos que todas las variables necesarias estén informadas y los ficheros existan.
#echo "Trace File ${LOG_FILE_TRACE} y ruta swk = ${WS_DIR}/scripts/valid_logic.awk"
#awk -f "${WS_DIR}/scripts/valid_connection.awk" "${LOG_FILE_TRACE}" > "${LOG_FILE_VALIDATION}"

#echo -e "${CFG_CONST_OK}\tTodo Correcto"
#exit 0