#!/bin/bash
#Function definitions.********************************************************

# Define a timestamp function
timestamp() {
#  date +"%T"
    local stamp=`date +"%Y-%m-%d_%H-%M-%S"`
    #return "$stamp"
    echo "$stamp"
}
#Imprime la ayuda
help(){
    #echo -e "soapBash v ${VERSION} by ${AUTHOR}"
    echo -ne "\tuso: "
    echo -e "soapBash.sh -n | --name  <nombreWS> [-v | --version] [-h | --help]"
    echo -e "\t\t-n|--name\tNombre del WS"
    echo -e "\t\t--curl-cfg\tFichero con la configuración curl"
    echo -e "\t\t--ws-dir\tCarpeta que contiene las configuraciónes del WS, ficheros ws.cfg y <X>.cfg (configuración de curl)"
    echo -e "\t\t--soap-version\tVersión SOAP a utilizar"
    echo -e "\t\t-u|--user\tCredenciales de acceso en autenticación basic => Usuario:Password"
    echo -e "\t\t-v|--verbose\tEnable verbose mode"
    echo -e "\t\t-h|--help\tShow this help"
}

#Hace un echo en caso que tengamos la opcíón verbose activada
verbose(){
    #function_name "$arg1" "$arg2"
    if test ! -z "$VERBOSE"
    then
        echo -e "\tv $1"
    fi

}

printERROR(){

    echo -e "\t***ERROR: $1"
}

printWARNING(){
    echo -e "\t***WARNING: $1"
}

printINFO(){
    echo -e "\tINFO: $1"
}