Webcam.set({
  image_format: 'jpeg',
  jpeg_quality: 90
});

Webcam.attach( '#my_camera' );

var data_uri;

function take_snapshot() {
  data_uri = Webcam.snap();
  document.getElementById('my_result').innerHTML = '<img src="'+data_uri+'"/>';

//add to form
	var raw_image_data = data_uri.replace(/^data\:image\/\w+\;base64\,/, '');
	
	document.getElementById('mydata').value = raw_image_data;
}

function save_picture(){
	var idDev = document.getElementById('iddev').value;
	var token = document.getElementById('token').value;
	if(idDev == null)
	{
		alert("No se puede procesar la foto, recarga esta ventana.");
		return;
	}
	if(data_uri != null)
	{
		Webcam.upload( data_uri, 'http://0.0.0.0:3000/devices/savepicture?id=' + idDev + "&authenticity_token=" + token, function(code, text) {
		// Upload complete!
		// 'code' will be the HTTP response code from the server, e.g. 200
		// 'text' will be the raw response content
		if(code == 200)
			document.body.innerHTML = text
		else
			alert(text);
		});
	}else
	{
		alert("Captura primero la foto");
	}
}