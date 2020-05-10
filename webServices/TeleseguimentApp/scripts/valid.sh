#!/bin/bash

#Validador
#Retornamos 0 si todo va bien, 1 si consideramos que ha habido error.

#Primero checkeamos que todas las variables necesarias estén informadas y los ficheros existan.
#echo "Trace File ${LOG_FILE_TRACE} y ruta swk = ${WS_DIR}/scripts/valid_logic.awk"
awk -f "${WS_DIR}/scripts/valid_connection.awk" "${LOG_FILE_TRACE}" > "${LOG_FILE_VALIDATION}"
#Valido SOAP y APP
. "${WS_DIR}/scripts/valid_soap.sh" >> "${LOG_FILE_VALIDATION}"
. "${WS_DIR}/scripts/valid_app.sh" >> "${LOG_FILE_VALIDATION}"

#Por ultimo valido todos los puntos, si TODO es OK , entonces lo marco como all OK
NUM_FALLOS=`grep -c -e FAIL ${LOG_FILE_VALIDATION}`
ESTADO_GLOBAL="OK"

if [[ $NUM_FALLOS -gt 0 ]];then
    ESTADO_GLOBAL="FAIL"
fi

#sed -i '1s/^/APP:\t${ESTADO_GLOBAL}\n/' todo.txt
#sed -i '1s/^/APP:\tGAB\n/' ${LOG_FILE_VALIDATION}
#echo -e "/APP:\t${ESTADO_GLOBAL}" | cat -
#sed -i '1iAPP:\tGAB\n' ${LOG_FILE_VALIDATION}
#echo -e "task goes here\n$(cat todo.txt)" > todo.txt
#echo -e "APP:\t${ESTADO_GLOBAL}\n$(cat ${LOG_FILE_VALIDATION})" > ${LOG_FILE_VALIDATION}

sed -i "1i CALL:\t${ESTADO_GLOBAL}\n" ${LOG_FILE_VALIDATION}