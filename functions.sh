#!/bin/sh
#Function definitions.********************************************************

# Define a timestamp function
timestamp() {
#  date +"%T"
    local stamp=`date +"%Y-%m-%d_%H-%M-%S"`
    #return "$stamp"
    echo "$stamp"
}
