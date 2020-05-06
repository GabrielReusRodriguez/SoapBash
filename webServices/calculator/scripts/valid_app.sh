#!/bin/bash


#Con greps buscamos SOAP:fault en el response y si nos animamos, parseamos buscando un codigo de error OK. como por ejemplo HC3_AGE_000
#Validador
#Retornamos 0 si todo va bien, 1 si consideramos que ha habido error.

#Primero checkeamos que todas las variables necesarias estén informadas y los ficheros existan.
#echo "Trace File ${LOG_FILE_TRACE} y ruta swk = ${WS_DIR}/scripts/valid_logic.awk"
#awk -f "${WS_DIR}/scripts/valid_connection.awk" "${LOG_FILE_TRACE}" > "${LOG_FILE_VALIDATION}"

#echo -e "${CFG_CONST_OK}\tTodo Correcto"
#exit 0