$(document).ready(function(){
	var socket = new WebSocket('wss://5.181.216.149:8080');
	
	socket.onopen = function() {
		console.log('Koneksi berhasil dibuat.');
	};
	$('.ambil-antrian').click(function(){
		$this = $(this);
		$loader = $('<i class="fas fa-circle-notch fa-spin fa-lg mt-2"></i>');
		$loader.appendTo($this);
		$this.attr('disabled', 'disabled');
		$this.prop('disabled', true);
		
		$.ajax({
			url : base_url + 'antrian-ambil/ajax-ambil-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-kategori'),
			success : function(data) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				console.log(data);
				socket.send('ambilantrian');
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				bootbox.alert('<strong>Error</strong> ' + xhr.responseJSON.message);
			}				
		})
	});
	socket.onclose = function() {
	  console.log('Koneksi ditutup.');
	};
})