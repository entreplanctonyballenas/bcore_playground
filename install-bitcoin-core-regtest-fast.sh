#!/bin/bash
autor (){
clear
# color
YELL='\e[33m'
MAG='\e[35m'
BLU='\e[34m'
NC='\e[0m'
apt install sysvbanner
echo "********************************"
echo -e "Script de $YELL Libreria de Satoshi $NC para instalar Bitcoin Core en Regtest"
echo "********************************"
sleep 3
}
limpieza () {
echo -e "$YELL LIMPIEZA $NC"
echo "********************************"
	echo "Detener bitcoind y limpiar los archivos descargados para empezar de cero."
	bitcoin-cli stop
	rm -r $HOME/.bitcoin
	rm /usr/local/bin/bitcoin*
	rm -r $HOME/bitcoin*
	rm $HOME/SHA256SUMS*
	rm -r $HOME/guix.sigs
sleep 3
}
configuracion () {
echo -e "$YELL CONFIGURACION $NC"
echo "********************************"
	echo "*** Instalacion de paquetes"
	echo "********************************"
		apt-get install -y bc jq autoconf file gcc libc-dev make g++ pkgconf re2c git libtool automake gcc xxd
	echo "********************************"
	echo "*** Descarga de los binarios principales de Bitcoin desde el sitio web de Bitcoin Core https://bitcoincore.org/."
	echo "********************************"
		wget https://bitcoincore.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz
	echo "********************************"
	echo "*** Utilizar los hashes y la firma descargados para verificar que los binarios sean correctos. Imprimir un mensaje en la terminal: "Verificación exitosa de la firma binaria"."
	echo "********************************"
		wget https://bitcoincore.org/bin/bitcoin-core-25.0/SHA256SUMS
		wget https://bitcoincore.org/bin/bitcoin-core-25.0/SHA256SUMS.asc
		sha256sum --ignore-missing --check SHA256SUMS
		echo -e "$YELL Verificación exitosa del checksum de los archivos $NC"
		git clone https://github.com/bitcoin-core/guix.sigs.git
		for file in ./guix.sigs/builder-keys/*.gpg; do gpg --import "$file"; done
	    # Verificamos la autenticidad del archivo SHA256SUMS 
	    SHASIG=`gpg --verify SHA256SUMS.asc SHA256SUMS 2>&1 | grep "Good signature"`
	    SHACOUNT=`gpg --verify SHA256SUMS.asc SHA256SUMS 2>&1 | grep "Good signature" | wc -l`

	    if [[ "$SHASIG" ]]
	    then
	        echo "$0 - Verificación de firma correcta: Encontradas $SHACOUNT firmas correctas."
	        echo "$SHASIG"
	    else
	        (>&2 echo "$YELL $0 - Error de verificación de firmas: No se ha podido verificar el archivo SHA256SUMS $NC")
	    fi
	    # Busca en el directorio actual los archivos indicados en SHA256SUMS y 
	    # comprueba sus sumas de verificación
	    SHACHECK=`sha256sum -c --ignore-missing < SHA256SUMS 2>&1 | grep "OK"`
	
	    if [ "$SHACHECK" ]
	    then
		    echo "$0 - Verificación exitosa de la firma binaria. Comprobados los archivos: $SHACHECK"
	    else
	        (>&2 echo "$0 - Verificación de SHA incorrecta!")
	    fi
	    
	echo "********************************"
	echo "*** Se copian los binarios descargados a la carpeta /usr/local/bin/."
	echo "********************************"
		tar -xvf bitcoin-25.0-x86_64-linux-gnu.tar.gz
		sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-25.0/bin/*
		#rm -r $HOME/bitcoin*
		#rm $HOME/SHA256SUMS*
		#rm -r $HOME/guix.sigs
sleep 3
}
inicio () {
echo -e "$YELL INICIO $NC"
echo "********************************"
	echo "*** Se crea un archivo bitcoin.conf en el directorio de datos /home/<nombre-de-usuario>/.bitcoin/. Se Crea el directorio si no existe. Y se agregar las siguientes líneas al archivo:"
	echo "********************************"
		mkdir $HOME/.bitcoin
		touch $HOME/.bitcoin/bitcoin.conf
		echo "regtest=1" >> $HOME/.bitcoin/bitcoin.conf
		echo "fallbackfee=0.0001" >> $HOME/.bitcoin/bitcoin.conf
		echo "server=1" >> $HOME/.bitcoin/bitcoin.conf
		echo "txindex=1" >> $HOME/.bitcoin/bitcoin.conf
		cat $HOME/.bitcoin/bitcoin.conf
	echo "********************************"
	echo -e "*** Se inicializa bitcoind en modo $YELL "regtest" $NC."
	echo "********************************"
		bitcoind -daemon
		echo -e "$YELL Esperando que levante bitcoind... $NC"
	sleep 5
}	
instrucciones () {
	clear
	echo "********************************"
	echo -e "$MAG INSTRUCCIONES $NC"
	echo "********************************"
	echo -e "\nAmbiente de pruebas para ejecutar comandos de bitcoin core en modo$BLU regtest $NC\n"
	echo -e "\nLa intención de este ambiente de pruebas es que puedas correr comandos de$MAG Bitcoin Core$NC de manera facil y rápida para comenzar tu aprendizaje de Bitcoin\n"
	echo "1. Para comenzar crea una cartera nueva usa los siguientes comandos:"
	echo -e "Para billeteras$BLU legacy $NC"
	echo -e "$YELL bitcoin-cli -named createwallet wallet_name="Minero" descriptors=false $NC"
	echo "2. Genera una dirección desde la billetera Minero con una etiqueta "Recompensa"."
	echo -e "$YELL bitcoin-cli -rpcwallet=Minero getnewaddress "Recompensa" $NC"
	echo "3. Extraer nuevos bloques depositando la recompensa a esta dirección"
	echo "hasta obtener un saldo de billetera positivo. (¿cuántos bloques se necesitaron para obtener un saldo positivo?)"
	echo "El siguiente comando genera un bloque (o varios) y lo envia a la direccion que le indiques (del comando anterior)"
	echo -e "$YELL bitcoin-cli generatetoaddress 1 "direccion-recompensa" $NC"
	echo "El siguiente comando es para visualizar el saldo en la cartera"
	echo -e "$YELL bitcoin-cli -rpcwallet=Minero getbalance $NC \n"
	echo -e "\nSi tienes dudas de cualquier comando ejecuta$YELL bitcoin-cli help$BLU comando $NC"
	echo -e "\nTambien puedes ejecutar comandos de python, solo corre$YELL python3$NC para lanzar la consola de python"

sleep 5
}

autor
limpieza
configuracion
inicio
instrucciones
#limpieza
