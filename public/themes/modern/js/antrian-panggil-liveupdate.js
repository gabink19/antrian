$(document).ready(function() {
	var socket = new WebSocket('ws://localhost:8080');
	
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
		$.ajax({
			type : 'post',
			url : base_url + '/longPolling/current_antrian_dipanggil',
			data : 'id_antrian_kategori=' + $('#id-antrian-kategori').text(),
			dataType : 'JSON',
			success : function(data) 
			{
				if (data.status=='ok'){
					$.each(data.data, function(i, v) {
						
						// Cek Pemanggilan
						jml_dipanggil = parseInt($('#total-antrian-dipanggil').text());
						if (jml_dipanggil < parseInt(v['jml_dipanggil'])) 
						{
							$td = $('#antrian-detail-' + v['id_antrian_detail']).find('td');
							$td.eq(2).html(v['jml_dipanggil']);
							jml = parseInt($td.eq(3).text());
							$td.eq(3).html(jml + 1);
						}
											
						$('#total-antrian').html(v['jml_antrian']);
						$('#total-antrian-dipanggil').html(v['jml_dipanggil']);
						
						sisa = parseInt(v['jml_antrian']) - parseInt(v['jml_dipanggil']);
						$('#total-sisa-antrian').html(sisa);
						if (sisa > 0) {
							$('a.panggil-antrian').removeClass('disabled');
							$('a.lewati-antrian').removeClass('disabled');
						} else {
							$('a.panggil-antrian').attr('disabled', 'disabled').addClass('disabled');
							$('a.lewati-antrian').attr('disabled', 'disabled').addClass('disabled');
						}
					});
					$('a.lewati-antrian').each(function(index, element) {
						var jmlh = $(this).parent().prev().prev().prev().html();
						if (jmlh=='0'){
							$(this).attr('disabled', 'disabled').addClass('disabled');
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