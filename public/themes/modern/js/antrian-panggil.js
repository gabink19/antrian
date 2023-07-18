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
		
		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail'),
			success : function(data) {
				data = $.parseJSON(data);
				$this.prop('disabled', false);
				$loader.remove();
				$('#total-antrian-dipanggil').html(data.message.jml_dipanggil);
				
				sisa = parseInt(data.message.jml_antrian) - parseInt(data.message.jml_dipanggil);
				$('#total-sisa-antrian').html(sisa);
				$this.parent().next().find('a.lewati-antrian').removeClass('disabled');
				$this.parent().next().find('a.panggil-ulang-antrian').removeClass('disabled');
				
				$this.parent().prev().prev().html(data.message.jml_dipanggil);
				
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
				
				socket.send('panggil');
				
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
				socket.send('panggilulang');
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
				$('#total-antrian-dipanggil').html(data.message.jml_dipanggil);
				
				sisa = parseInt(data.message.jml_antrian) - parseInt(data.message.jml_dipanggil);
				$('#total-sisa-antrian').html(sisa);
				$this.parent().next().find('a.lewati-antrian').removeClass('disabled');
				$this.parent().next().next().next().find('a.panggil-ulang-antrian').removeClass('disabled');
				
				$this.parent().prev().prev().prev().prev().html(data.message.jml_dipanggil);
				
				// jml dipanggil
				$this.parent().prev().prev().prev().html(data.message.jml_dipanggil_by_loket);
				
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
				
				socket.send('panggil');
				
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
			data : 'id=' + id_antrian_detail + '&nomor_antrian=' + nomor_antrian,
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
					socket.send('panggilulang');
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
	socket.onclose = function() {
	  console.log('Koneksi ditutup.');
	};
})