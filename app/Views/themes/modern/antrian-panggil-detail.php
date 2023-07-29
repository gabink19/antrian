<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<div class="card">
	<div class="card-header">
		<h5 class="card-title"><?=$current_module['judul_module']?></h5>
	</div>
	
	<div class="card-body">
		
		<?php 
		if (!empty($message)) {
			show_alert($message);
		}
		helper('html');
		
		$jml_antrian = key_exists($kategori['id_antrian_kategori'], $antrian_urut) ? $antrian_urut[$kategori['id_antrian_kategori']]['jml_antrian'] : 0;
		$dipanggil = key_exists($kategori['id_antrian_kategori'], $antrian_urut) ? $antrian_urut[$kategori['id_antrian_kategori']]['jml_dipanggil'] : 0;
		$sisa = $jml_antrian - $dipanggil;
		$idskategori = [];
		$awalans = [];
		$awalans[] = $kategori['awalan'];
		?>
		<div class="mb-3">Nama Antrian</div>
		<table class="table display table-striped table-bordered table-hover" style="width:auto">
		<thead>
			<tr>
				<th>Kategori</th>
				<th>Jml. Antrian</th>
				<th>Awalan</th>
				<th>Jml. Dipanggil</th>
				<th>Sisa</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><?=$kategori['nama_antrian_kategori']?></td>
				<td id="total-antrian"><?=$jml_antrian?></td>
				<td><?=$kategori['awalan']?></td>
				<td id="total-antrian-dipanggil"><?=$dipanggil?></td>
				<td id="total-sisa-antrian"><?=$sisa?></td>
		</tbody>
		</table>
		<div class="mb-3">Tujuan</div>
		<table class="table display table-striped table-bordered table-hover" style="width:auto">
		<thead>
			<tr>
				<th>No</th>
				<th>Tujuan</th>
				<th>No. Terakhir</th>
				<th>Jml. Panggil</th>
				<th>Panggil</th>
				<th>Panggil Ulang</th>
				<th>Lewati</th>
				<th>Spesial Panggil</th>
				<th <?= (in_array('C',$awalans))?'style="display:none;"':""?>>Cetak Antrian Bilik</th>
			</tr>
		</thead>
		<tbody>
			<?php
			$no = 1;
			$btn_panggil_disabled = $sisa == 0 ? ' disabled' : '';
			
			foreach ($antrian as $val) {
				$idskategori[$val['id_antrian_detail']] = $kategori['id_antrian_kategori'];
				$jml = key_exists($val['id_antrian_detail'], $jml_dipanggil) ? $jml_dipanggil[$val['id_antrian_detail']]['jml_dipanggil'] : 0;
				$no_terakhir = key_exists($val['id_antrian_detail'], $jml_dipanggil) ? $jml_dipanggil[$val['id_antrian_detail']]['no_terakhir'] : 0;
				$btn_panggil_ulang_disabled = $jml == 0 ? ' disabled' : '';
				
				echo '<tr id="antrian-detail-' . $val['id_antrian_detail'] . '">
						<td>' . $no  . '</td>
						<td>' . $val['nama_antrian_tujuan'] . '</td>
						<td id="no_terakhir_'.$val['id_antrian_detail'].'">' . $no_terakhir . '</td>
						<td>' . $jml . '</td>
						<td>' . btn_label([
											'attr' => ['class' => 'btn btn-secondary btn-xs panggil-antrian' . $btn_panggil_disabled
														, 'data-id-antrian-detail' => $val['id_antrian_detail']
														, 'data-url' => base_url() . '/antrian-panggil/ajax-panggil-antrian'
													],
											'url' => 'javascript:void(0)',
											'label' => 'Panggil'
										])
						. '</td>
						<td>' . btn_label([
											'attr' => ['class' => 'btn btn-warning btn-xs panggil-ulang-antrian' . $btn_panggil_ulang_disabled
														, 'data-id-antrian-detail' => $val['id_antrian_detail']
														, 'data-url' => base_url() . '/antrian-panggil/ajax-panggil-ulang-antrian'
														, 'data-url-panggil-ulang' => base_url() . '/antrian/panggil-ulang-antrian'
													],
											'url' => 'javascript:void(0)',
											'label' => 'Panggil Ulang'
										])
						. '</td>
						<td>' . btn_label([
												'attr' => ['class' => 'btn btn-success btn-xs lewati-antrian' . $btn_panggil_ulang_disabled
															, 'data-id-antrian-detail' => $val['id_antrian_detail']
															, 'id'=>'lewati-antrian-'.$val['id_antrian_detail']
															, 'data-url' => base_url() . '/antrian-panggil/ajax-lewati-antrian'
														],
												'url' => 'javascript:void(0)',
												'label' => 'Lewati'
											])
						. '</td>
						<td><input class="form-control in-spesial-panggil" type="number" id="spesial-call-'.$val['id_antrian_detail'].'"style="width: 50px;float: left;margin-right: 10px;height: 30px;" />' . btn_label([
												'attr' => ['class' => 'btn btn-primary btn-xs spesial-panggil'
															, 'data-id-antrian-detail' => $val['id_antrian_detail']
															, 'data-url' => base_url() . '/antrian-panggil/ajax-spesial-panggil-antrian'
														],
												'url' => 'javascript:void(0)',
												'label' => 'Panggil'
											])
						. '</td>';
					if ($kategori['awalan']=='A'||$kategori['awalan']=='B') {
						echo '<td><input class="form-control cetak-antrian-lab" type="text" id="cetak-antrian-'.$val['id_antrian_detail'].'"style="width: 70px;float: left;margin-right: 10px;height: 30px;font-size: 12px" placeholder="No. Lab"/>' . btn_label([
												'attr' => ['class' => 'btn btn-primary btn-xs cetak-antrian-c '
															, 'data-id-antrian-detail' => $val['id_antrian_detail']
															, 'data-id-kategori' => $kategori['id_antrian_kategori']
															, 'data-url' => base_url() . '/antrian-panggil/ajax-cetak-antrian-c'
														],
												'url' => 'javascript:void(0)',
												'label' => 'Cetak'
											])
						. '</td>
						</tr>';
					}
					
					$no++;
			}
			?>
		</tbody>
		</table>
		<?php foreach ($idskategori as $key => $value) {?>
			<span id="detail_id_kategori_<?=$key?>" style="display:none"><?=$value?></span>
		<?php } ?>
		<span id="id-antrian-kategori" style="display:none"><?=$kategori['id_antrian_kategori']?></span>
	</div>
</div>