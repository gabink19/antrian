$(document).ready(function(){
	var suara = '';
	var socket = new WebSocket('ws://localhost:8080');
	
	socket.onopen = function() {
		console.log('Koneksi berhasil dibuat.');
	};
	$('.panggil-antrian').click(function(){
		
		$this = $(this);
		
		if ($this.hasClass('disable')) {
			return false;
		}
		
		$loader = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$loader.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		id_antrian_kategori = $('#id-antrian-kategori').text()
		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail'),
			success : function(data) {
				data = $.parseJSON(data);
				$this.prop('disabled', false);
				$loader.remove();
				$('#total-antrian-dipanggil').html(data.message.nomor_antrian);
				
				sisa = parseInt(data.message.jml_antrian) - parseInt(data.message.jml_dipanggil);
				$('#total-sisa-antrian').html(sisa);
				$this.parent().next().find('a.lewati-antrian').removeClass('disabled');
				$this.parent().next().find('a.panggil-ulang-antrian').removeClass('disabled');
				
				$this.parent().prev().prev().html(data.message.nomor_antrian);
				
				// jml dipanggil
				$this.parent().prev().html(data.message.jml_dipanggil_by_loket);
				
				if (sisa == 0) {
					$('.panggil-antrian').attr('disabled', 'disabled');
					$('.panggil-antrian').addClass('disabled');
					$('.panggil-antrian').prop('disabled', true);
					$('.lewati-antrian').attr('disabled', 'disabled');
					$('.lewati-antrian').addClass('disabled');
					$('.lewati-antrian').prop('disabled', true);
				} else {
					$this.removeAttr('disabled');
					$this.removeClass('disabled');
				}
				
				if (suara != '') {
					suara.pause();
				}
				
				socket.send('panggil_'+id_antrian_kategori);
				
			}, error: function(xhr) {
				console.log(xhr);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				$this.prop('disabled', false);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					type: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});
	
	$('.panggil-ulang-antrian').click(function(){
		
		$this = $(this);
		if ($this.hasClass('disabled')) {
			return;
		}
		
		$loader = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$loader.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		id_antrian_kategori = $('#id-antrian-kategori').text()

		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-ulang-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail'),
			success : function(result) {
				result = $.parseJSON(result);
				data = result.message;
				
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				if (suara != '') {
					suara.pause();
				}
				socket.send('panggilulang_'+id_antrian_kategori);
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				console.log(xhr);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					type: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});

	$('.lewati-antrian').click(function(){
		$this = $(this);
		
		if ($this.hasClass('disable')) {
			return false;
		}
		
		$loader = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$loader.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		
		$.ajax({
			url : base_url + 'antrian-panggil/ajax-lewati-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail'),
			success : function(data) {
				data = $.parseJSON(data);
				$this.prop('disabled', false);
				$loader.remove();
				$this.removeAttr('disabled');
				$this.removeClass('disabled');
			}, error: function(xhr) {
				console.log(xhr);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				$this.prop('disabled', false);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					type: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});

	$('.spesial-panggil').click(function(){
		
		$this = $(this);
		if ($this.hasClass('disabled')) {
			return;
		}
		
		$loader = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$loader.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		id_antrian_detail = $this.attr('data-id-antrian-detail')
		nomor_antrian = $('#spesial-call-'+id_antrian_detail).val()
		kategori = $('#detail_id_kategori_'+id_antrian_detail).text()
		if(nomor_antrian==''){
			$this.prop('disabled', false);
			$this.removeAttr('disabled');
			$loader.remove();
			$this.removeClass('disabled');
			return;
		}
		$.ajax({
			url : base_url + 'antrian-panggil/ajax-spesial-panggil-antrian',
			type : 'post',
			data : 'id=' + id_antrian_detail + '&nomor_antrian=' + nomor_antrian+ '&kategori=' + kategori,
			success : function(result) {
				result = $.parseJSON(result);
				data = result.message;
				if(data=='Invalid input'){
					$this.prop('disabled', false);
					$this.removeAttr('disabled');
					$loader.remove();
					$this.removeClass('disabled');
					Swal.fire({
						title: 'Data Tidak Ada !!!',
						text: 'Antrian Tersebut bukan di loket ini.',
						type: 'warning',
						showCloseButton: true,
						confirmButtonText: 'OK'
					})
				}else{
					$this.prop('disabled', false);
					$this.removeAttr('disabled');
					$loader.remove();
					$this.removeClass('disabled');
					if (suara != '') {
						suara.pause();
					}
					$('[data-id-antrian-detail="'+id_antrian_detail+'"]').removeClass('disabled');
					$('#spesial-call-'+id_antrian_detail).val('')
					socket.send(result.ws);
				}
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				console.log(xhr);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					type: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});
	$('.cetak-antrian-c').click(function(){
		$this = $(this);
		
		id_antrian_detail = $this.attr('data-id-antrian-detail')
		nomor_lab = $('#cetak-antrian-'+id_antrian_detail).val()
		nomor_terakhir = $('#no_terakhir_'+id_antrian_detail).text()
		console.log('#no_terakhir_'+id_antrian_detail)
		if (nomor_terakhir=='0'||nomor_lab=='') {
			Swal.fire({
				title: 'Error !!!',
				text: "Belum ada antrian terpanggil.",
				type: 'error',
				showCloseButton: true,
				confirmButtonText: 'OK'
			})
			return false
		}

		if ($this.hasClass('disable')) {
			return false;
		}
		
		$loader = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$loader.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		$.ajax({
			url : base_url + '/antrian-panggil/ajax-cetak-antrian-c',
			type : 'post',
			data : 'id=' + id_antrian_detail + '&no_lab=' + nomor_lab,
			success : function(data) {
				data = $.parseJSON(data);
				$this.prop('disabled', false);
				$loader.remove();
				$this.removeAttr('disabled');
				$this.removeClass('disabled');
				socket.send('ambilantrian');
			}, error: function(xhr) {
				console.log(xhr);
				$this.removeAttr('disabled');
				$loader.remove();
				$this.removeClass('disabled');
				$this.prop('disabled', false);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					type: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});
	socket.onclose = function() {
	  console.log('Koneksi ditutup.');
	};
})