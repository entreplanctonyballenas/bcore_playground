# Bitcoin Core Playground for Killercoda
###### tags: `killercoda` `regtest` `bitcoin` `cli` `nodo`

_Usa un sistema operativo online para practicar los comandos de bitcoin core sin instalarlo en tu computadora_

**Tabla de contenido**
[TOC]

## Autores
EntrePlanctonyBallenas. 
Twitter para correcciones, comentarios o sugerencias: [@entreplanctony1](https://twitter.com/Entreplanctony1)

El presente tutorial fue elaborado para el [Seminario socrático de Mastering Bitcoin](https://libreriadesatoshi.com/) a través de [@libreriadesatoshi](https://twitter.com/libdesatoshi).

## ¿Que es Killercoda?
Es una web que te permite acceso instantaneo a una maquina virtual con Linux en la nube, y te permite probar comandos de aplicaciones sin tener que instalar programas en tu computadora.

Página de inicio para correr ubuntu en Killercoda
[https://killercoda.com/playgrounds/scenario/ubuntu](https://killercoda.com/playgrounds/scenario/ubuntu)

:::danger
:bomb:La cuenta gratuita de Killercoda solo permite utilizar una maquina virtual por **60 minutos**, transcurrido este tiempo, la maquina virtual se reinicia y se pierde todo el trabajo que se tenía.
:::

## ¿Que es Bitcoin Core Playground for Killercoda?
Es un script de bash que descarga, valida y configura bitcoin-core para que puedas usarlo por 60 minutos en una maquina virtual de killercoda y practicar comandos de bitcoin-core o de python.

:::warning
Este script utiliza el modo **regtest** de bitcoin-core por lo que solo tienes acceso a una red de pruebas en bitcoin que tu mismo tienes que construir, no hay bloque genesis hasta que tu lo creas, no se validan transacciones hasta que tú las mines en un bloque, etc...
:::

La intención es darte una opción simple y fácil con la cual comenzar tu aprendizaje del uso de bitcoin-core.

## ¿Cómo se usa?

Ingresa con un correo electrónico, Github o Google en la página de ubuntu en Killercoda: [https://killercoda.com/playgrounds/scenario/ubuntu](https://killercoda.com/playgrounds/scenario/ubuntu)

![Captura de Pantalla 2024-01-29 a la(s) 18.42.40](https://hackmd.io/_uploads/By37U6Sq6.png)

:::danger
:bomb: Una vez que estas loggeado tienes solo 60 minutos para ejecutar los comandos que desees, después de este tiempo tu trabajo se perderá
:::
Al ingresar verás que del lado derecho tienes una terminal de linea de comandos:

![Captura de Pantalla 2024-01-29 a la(s) 18.44.50](https://hackmd.io/_uploads/SkqJD6rc6.png)

En esta terminal ejecuta el siguiente comando (**en una sola linea**):
 
```bash!
git clone https://github.com/entreplanctonyballenas/bcore_playground; chmod 755 bcore_playground/install-bitcoin-core-regtest-fast.sh; ./bcore_playground/install-bitcoin-core-regtest-fast.sh
```
La línea se compone de 3 distintos comandos, explicados a continuación:
`git clone` Hace una copia del repositorio _bcore_playground_
`chmod` Agrega permisos de ejecución al script
La tercera parte de la linea es la ejecución del script _install-bitcoin-core-regtest-fast.sh_

Al finalizar el script verás las instrucciones de uso:
![Captura de Pantalla 2024-01-29 a la(s) 19.13.06](https://hackmd.io/_uploads/BJr4aTB9a.png)

:::success
:100: Listo!!
Ahora tienes un ambiente para practicar los comandos de bitcoin-core en **regtest**, pero recuerda que este ambiente estará disponible solo por :bomb: 60 minutos, después puedes abrir otro nuevo, pero la información que tenías se perderá.
:::