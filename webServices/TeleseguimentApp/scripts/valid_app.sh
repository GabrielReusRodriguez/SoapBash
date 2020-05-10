#!/bin/bash

#xmllint parsea un xml por bash.
#Primero obtenemos el xml de response.

#XML_FILE_TMP="${LOG_EXECUTION_FOLDER}/tmp/response.xml"

if [[ -z ${XML_FILE_TMP} ]]; then
    XML_FILE_TMP="${LOG_EXECUTION_FOLDER}/tmp/response.xml"
    XML=`grep -oP '<.+' ${LOG_FILE_RESP_PAYLOAD}`
fi

test -f ${XML_FILE_TMP} || touch ${XML_FILE_TMP}
echo "${XML}" > ${XML_FILE_TMP}

PAYLOAD=xmllint  --xpath "//*[local-name()='testResponse']" "${XML_FILE_TMP}"
XML_PAYLOAD_TMP="${LOG_EXECUTION_FOLDER}/tmp/response_body.xml"
echo  "${XML}" >  "${XML_PAYLOAD_TMP}"


#Valido el APP con el xsd.
xmllint --schema "${WS_DIR}/data/schema.xsd" --noout ${XML_PAYLOAD_TMP}  2>/dev/null

#if [[ $? -eq 0 ]]; then 
if [[ $? -ne 0 ]]; then 
    RESULTADO_XSD="FAIL"
fi

if [[ $RESULTADO_XSD -eq "FAIL" ]]; then
    echo -e "APP:\t${RESULTADO_XSD}\n"
    exit 0
fi

#Finalmente comprobamos el valor del resultado.
VALOR_RESULT=$(xmllint  --xpath "//*[local-name()='result']/text()" ${XML_PAYLOAD_TMP})

if [[ ${VALOR_RESULT} -eq 'OK' ]];then
    echo -e "APP:\tOK\n"
else
    echo -e "APP:\tFAIL\n"
fi

exit 0



#Con greps buscamos SOAP:fault en el response y si nos animamos, parseamos buscando un codigo de error OK. como por ejemplo HC3_AGE_000
#Validador
#Retornamos 0 si todo va bien, 1 si consideramos que ha habido error.

#Primero checkeamos que todas las variables necesarias estén informadas y los ficheros existan.
#echo "Trace File ${LOG_FILE_TRACE} y ruta swk = ${WS_DIR}/scripts/valid_logic.awk"
#awk -f "${WS_DIR}/scripts/valid_connection.awk" "${LOG_FILE_TRACE}" > "${LOG_FILE_VALIDATION}"

#echo -e "${CFG_CONST_OK}\tTodo Correcto"
#exit 0

#echo "setns soap=http://schemas.xmlsoap.org/soap/envelope/ setns ns3=http://test.soap.remotehs.ehcos.everis.com/ cd /soap:Envelope/soapBody/ cat" | xmllint --shell ./resp.xml

