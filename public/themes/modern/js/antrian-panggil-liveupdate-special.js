$(document).ready(function() {
	var socket = new WebSocket('ws://5.181.216.149:8080');
	
	socket.onopen = function() {
		console.log('Koneksi berhasil dibuat.');
	};
	socket.onmessage = function(event) {
		check_current_dipanggil();
	};
	socket.onclose = function() {
	  console.log('Koneksi ditutup.');
	};
	/* Cek apakah ada penambahan antrian atau yang dipanggil*/
	function check_current_dipanggil() 
	{
		kategori_id = $('#id-antrian-kategori').text()
		$.ajax({
			type : 'post',
			url : base_url + '/longPolling/current_antrian_dipanggil_spc',
			data : 'id_antrian_kategori=' + kategori_id,
			dataType : 'JSON',
			success : function(data) 
			{
				if (data.status=='ok'){
					$.each(data.data, function(i, v) {
						jml_dipanggil = parseInt($('#total-antrian-dipanggil-'+v['id_antrian_kategori']).text());
						if (jml_dipanggil < parseInt(v['jml_dipanggil'])) 
						{
							$td = $('#antrian-detail-' + v['id_antrian_detail']).find('td');
							$td.eq(2).html(v['nomor_panggil']);
							
							jml = parseInt($td.eq(3).text());
							$td.eq(3).html(jml);
							$('#lewati-antrian-'+ v['id_antrian_detail']).removeClass('disabled');
						}		
						$('#total-antrian-'+v['id_antrian_kategori']).html(v['jml_antrian']);
						$('#total-antrian-dipanggil-'+v['id_antrian_kategori']).html(v['jml_dipanggil']);
						
						sisa = parseInt(v['jml_antrian']) - parseInt(v['jml_dipanggil']);
						$('#total-sisa-antrian-'+v['id_antrian_kategori']).html(sisa);
						if (sisa > 0) {
							$('.panggilspc-'+v['id_antrian_kategori']).removeClass('disabled');
							$('#panggil-antrian-'+v['id_antrian_detail']).removeClass('disabled');
							$('#spesial-antrian-'+v['id_antrian_detail']).removeClass('disabled');
							$('#spesial-call-'+v['id_antrian_detail']).prop("disabled", false);
						} else {
							$('#panggil-antrian-'+v['id_antrian_detail']).attr('disabled', 'disabled').addClass('disabled');
						}
					});
				}
				
			}, error : function (xhr) {
				console.log(xhr);
				alert('Ajax Error !!!', xhr.responseText + '<br/><strong>Note</strong>: Detail error ada di console browser');
			}
		})
	}
	
	check_current_dipanggil();
})