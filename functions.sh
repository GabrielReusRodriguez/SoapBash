#!/bin/sh
#Function definitions.********************************************************

# Define a timestamp function
timestamp() {
#  date +"%T"
    local stamp=`date +"%Y-%m-%d_%H-%M-%S"`
    #return "$stamp"
    echo "$stamp"
}

help(){
    echo -e "soapBash v ${VERSION} by ${AUTHOR}"
    echo -e "\t-v|--verbose\tEnable verbose mode"
    echo -e "\t-h|--help\tShow this help"
}