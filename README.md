UTIM Check IO => In-Out
=============

Proyecto que tiene como finalidad llevar la bitácora de ingreso/egreso de los dispositivos portátiles de la comunidad universitaria de la UTIM.

Su desarrollo está implementado en Rails v4.1.0

Actualmente realiza:
	* Registrar/Editar/Buscar Dispositivos y propietario
	* Registro de Ingreso y Egreso del dispositivo
	* Visulizar Bitácora de ingresos y egresos
	* Filtrar registros por dispositivo

Por realizar
	* Al registrar un nuevo dispositivo, verificar si el propietario existe entonces asociarlo al nuevo dispositivo.
	* Filtrar la bitácora de ingresos-egresos por fechas
	* Ver dispositivos por usuario
	* Generar el código de barras, lo ideal sería generar una etiqueta con código QR
