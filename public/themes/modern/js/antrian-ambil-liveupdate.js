$(document).ready(function() {
	var socket = new WebSocket('ws://localhost:8080');
	
	socket.onopen = function() {
		console.log('Koneksi berhasil dibuat.');
	};
	socket.onmessage = function(event) {
		if (event.data=='ambilantrian'){
			check_current_ambil();
		}
	};

	/* Cek apakah ada penambahan antrian atau yang dipanggil*/
	function check_current_ambil() 
	{
		$.ajax({
			type : 'post',
			url : base_url + '/longPolling/current_antrian_ambil',
			dataType : 'JSON',
			success : function(data) 
			{
				if (data.status == 'ok'){
					for (k in data.data) {
						var antrian = data.data[k].jml_antrian
						$('tr[data-id-antrian-kategori="' + k + '"]').find('td').eq(3).html(antrian);
						$('#no_antrian_' + k).text(data.data[k].awalan+antrian);
					}
				}
			}, error : function (xhr) {
				console.log(xhr);
				alert('Ajax Error !!!', xhr.responseText + '<br/><strong>Note</strong>: Detail error ada di console browser');
			}
		})
	}
	
	check_current_ambil();
	socket.onclose = function() {
	  console.log('Koneksi ditutup.');
	};
})