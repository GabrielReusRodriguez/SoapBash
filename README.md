# SoapSh
Script parametrizable que hace llamadas a WS SOAP. (próximamente, otro proyecto para llamadas JSON)
El proyecto apenas está arrancando y se va haciendo durante tiempo libre por lo que se aceptan ideas y colaboraciones.

## Comenzando 🚀
### Pre-requisitos 📋
La idea de esta aplicación es que sea lo más básica posible y se pueda ejecutar con las herramientas bash cotidianas.
Esta aplicación es ejecutable sólo para sistemas *nix. Está probado en Kubuntu 20

Es necesario tener instalado:
* Bash
* curl

## Uso
Podeis consultar la [Wiki del proyecto](https://github.com/GabrielReusRodriguez/SoapSh/wiki) pero un breve resumen  de como hacer la llamada sería:

```
        uso: soapBash.sh [-n|--name  <nombreWS>] [--curl-cfg <ruta>] --ws-dir <ruta> [--soap-version <version>] [-u|--user <credenciales>]  [-v|--version] [-h|--help]
                -n|--name       Nombre del WS
                --curl-cfg      Fichero con la configuración curl
                --ws-dir        Carpeta que contiene las configuraciónes del WS, ficheros ws.cfg y <X>.cfg (configuración de curl)
                --soap-version  Versión SOAP a utilizar
                -u|--user       Credenciales de acceso en autenticación basic => Usuario:Password
                -v|--verbose    Enable verbose mode
                -h|--help       Show this help
```

## Wiki 📖
Puedes encontrar mucho más de cómo utilizar este proyecto en nuestra [Wiki](https://github.com/GabrielReusRodriguez/SoapSh/wiki)

## Autores ✒️
Colaboradores del proyecto:
* **Gabriel Reus Rodríguez** - [gabrielReusRodriguez](https://github.com/GabrielReusRodriguez)

## Licencia 📄
Este proyecto está bajo la Licencia GPLv3 - mira el archivo [LICENSE.md](LICENSE.md) para detalles
