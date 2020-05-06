#!/bin/awk

#Author gabrielin@gmail.com
BEGIN{
    resultado_valor = "0";
    resultado_texto = "";
    
    const_ok = "OK";
    const_fail = "FAIL";
    const_toCheck = "CHECK";
    const_notCheck = "";

    #Checks que comprobamos
    check_NET_txt = "NET:\t%s\n";
    check_NET_value = const_toCheck;
    check_HTTP_txt = "HTTP:\t%s\n";
    check_HTTP_value = const_toCheck;
    #check_HTTP_value = "";#Si no quiero checkearla la dejo en blanco
    #check_SOAP_txt = "SOAP:\t%s\n";
    #check_SOAP_value = const_notCheck;
    #check_APP_txt = "APP:\t%s\n";
    #check_APP_value = const_notCheck;
    #check_ALL_txt = "ALL:\t%s\n";
    #check_ALL_value = "";

    #print "START";
} #Begin Section

{
    #print  $0
    #printf "_%s_\n",$0;
    if ( check_NET_value == const_toCheck ){
        if ( $0 ~ 200) check_NET_value = const_ok;
        else check_NET_value = const_fail;
    }

    if ( check_HTTP_value == const_toCheck ){
        #Si devuelven un codigo HTTP 200 , lo doy por bueno.
        if($0 ~ /HTTP\/[[:digit:]]\.[[:digit:]] 2[[:digit:]][[:digit:]] OK/) 
            check_HTTP_value = const_ok;
    } 

    #if ( check_SOAP_value == const_toCheck ){
        #if ($0 ~ /<[[:alpha:]]*:Fault>/) check_SOAP_value = const_ok;
        #if ($0 !~ /<[[:alpha:]]*:Fault>/) check_SOAP_value = const_ok;
        #else check_SOAP_value = const_fail;
    #}

    #if ($0 ~ /200/) check_APP_value = const_ok;
    #else check_APP_value = const_fail;

    #if ($0 ~ /<= Recv data,/){
    #    capturando_respuesta = 1
    #}

} #Loop Section

END{

#Las variables que hayan llegado aqui como toCHeck es que son FAILS porque no se encontraron las condiciones de ok


if ( check_HTTP_value == const_toCheck ) {
        check_HTTP_value = const_fail;
} 


#Comprobamos el check all
#    if (    ( check_NET_value == const_notCheck || check_NET_value == const_ok ) && 
#            ( check_HTTP_value == const_notCheck || check_HTTP_value == const_ok ) && 
#            ( check_SOAP_value == const_notCheck || check_SOAP_value == const_ok ) &&
#            ( check_APP_value == const_notCheck || check_APP_value == const_ok )) {
#                check_ALL_value = const_ok;
#    }else{
#        check_ALL_value = const_fail;
#    }

#Imprimimos los resutlados.

 #   printf check_ALL_txt, check_ALL_value;
 #   printf "\n";
    if (check_NET_value != const_notCheck)
        printf check_NET_txt, check_NET_value;
    if (check_HTTP_value != const_notCheck)
        printf check_HTTP_txt, check_HTTP_value;
    if (check_SOAP_value != const_notCheck)
        printf check_SOAP_txt, check_SOAP_value;
#    if (check_APP_value != const_notCheck)
#        printf check_APP_txt, check_APP_value;


    }#End Section