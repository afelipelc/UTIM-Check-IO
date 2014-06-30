UTIM Check IO => In-Out
=============

Proyecto que tiene como finalidad llevar la bitácora de ingreso/egreso de los dispositivos portátiles de la comunidad universitaria de la UTIM.

Su desarrollo está implementado en Rails v4.1.0

Actualmente realiza:
	* Registrar/Editar/Buscar Dispositivos y propietarios
	** Al registrar dispositivo licaliza propietario registrado, sino entonces crea uno nuevo
	* Registro de Ingreso y Egreso del dispositivo
	* Visulizar Bitácora de ingresos y egresos
	** Filtrado de registros por día a través del datepicker
	* Filtrar registros por dispositivo
	* Imprimir código de barra con el ID del dispositivo
	* Toma y guardado de fotografía del propietario

Por realizar
	* Ver dispositivos por propietario
	* Revisar y corregis posibles errores lógicos
