*Instalación de Linux Mint/Ubuntu*

Principalmente fue necesario dirigirse a la pagina respectiva de la distribución a utilizar que para algunos de los integrantes de este grupo fue Mint, mientras que para otros fue Ubuntu, ya con esto, se procede a descargar el archivo correspondiente y posterior a esto se realizó la preparación del mismo en dispositivos USB que luego serían usados al momento de la instalación.

Para poder realizar la instalación correctamente del OS Linux, ya fuera para su distribución Ubuntu o Mint, fue necesario realizar primeramente la respectiva partición del disco, de manera que desde Windows, en el apartado correspondiente a "Administración de discos" se realizó la respectiva partición, tal como se puede ver en la imagen 1, se dispuso de 100Gb para esdta partición y ya con esto realizado, se procede a reallizar la instalación del OS.
![image](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/74801316/eedfadc0-e253-40f2-9166-47152db65ec8)

Ya con esto realizado, se apaga el dispositivo. Antes de encenderlo nuevamente, se conecta la USB que contiene la distribución de Linux, de manera que al encenderlo y dirigirse a la BIOS, se pueda acceder a la misma y comenzar a ejecutar el archivo de instalación del OS. 

*Instalación de Quartus*

Habiendo instalado Linux, se procedió a realizar la instalación de Quartus, para esto, en la pagina de decarga de la misma, se procedió a seleccionar la versión a utilizar, la cual, para esta ocasión es _Lite Edition_. Posterior a la descarga del mismo, se otorgarón permisos con el comando.


   ```chmod +x qinst-lite-linux-23.1std-991.run ```
   
Y posterior a esto, se ejecutó el siguiente comando
   ``` ./qinst-lite-linux-23.1std-991.run```

Lo anterior se realizó, tal y como se muestra en la imagen de la figura 2.





*Instalación de Questa*
  
   Primero en MicrosoftOnline.com podemos obtener los dos paquetes que harán las veces de instalador para nuestro software Questa. debemos descargar los dos tipos de paquetes, el de tipo .run y el .qdz. Descargados los archivos otorgamos permisos con el comando 
   
   
   ```chmod +x *.run ``` y seguido ```./*.run ```
   

   ![Captura de pantalla de 2024-03-10 07-40-21](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/25148da4-8116-4b25-9b3e-7c4a1ba29472)



*Descarga e implementación de la licencia de Intel para habilitar el uso de Questa en Quartus*
