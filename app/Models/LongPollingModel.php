<?php
/**
*	App Name	: Antrian	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2021
*/

namespace App\Models;

class LongPollingModel extends \App\Models\BaseModel
{
	public function __construct() {
		parent::__construct();
	}
	
	public function getLastAntrianDipanggil($id) {
		$sql = 'SELECT MAX(waktu_panggil) AS waktu_panggil FROM antrian_panggil_detail
				LEFT JOIN antrian_detail USING(id_antrian_detail)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				LEFT JOIN antrian_panggil USING(id_antrian_panggil)
				WHERE id_setting_layar = ? AND tanggal = ?';
		$result = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		return $result;
	}
	
	public function getPanggilanTerakhir($id) {
		$sql = 'SELECT * FROM antrian_panggil_detail
				LEFT JOIN antrian_detail USING(id_antrian_detail)
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				LEFT JOIN antrian_panggil USING(id_antrian_panggil)
				WHERE id_setting_layar = ? AND tanggal = ? ORDER BY waktu_panggil DESC LIMIT 1';
		$result = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		return $result;
	}
	
	public function getPanggilUlang($id)
	{
		$sql = 'SELECT *, nomor_panggil AS jml_dipanggil
				FROM antrian_panggil_ulang
				LEFT JOIN antrian_panggil_detail USING(id_antrian_panggil_detail)	
				LEFT JOIN antrian_detail USING(id_antrian_detail)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				WHERE id_setting_layar = ? AND tanggal_panggil_ulang = ?  ORDER BY waktu_panggil_ulang DESC LIMIT 1';
		$result = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		return $result;
	}
	
	public function cekLastAntrianAmbilUlang($id, $waktu) {
		$sql = 'SELECT * 
				FROM antrian_panggil_ulang 
				WHERE id_setting_layar = ? AND tanggal_panggil_ulang = ? AND waktu_panggil_ulang > ?';
		$result = $this->db->query($sql, [$id, date('Y-m-d'), $waktu['waktu_panggil_ulang']])->getRowArray();
		return $result;
	}
	
	public function getLastAntrianAmbilUlang($id) {
		$sql = 'SELECT * 
				FROM antrian_panggil_ulang 
				WHERE id_setting_layar = ? AND tanggal_panggil_ulang = ? 
				ORDER BY waktu_panggil_ulang DESC LIMIT 1';
		$result = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		return $result;
	}

	public function getAllAntrianUrutBelumDipanggil() {
		$sql = 'SELECT * 
				FROM antrian_panggil 
				WHERE tanggal = "' . date('Y-m-d') . '" 
				AND jml_antrian - jml_dipanggil = 1
				ORDER BY time_ambil DESC';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getLastAntrianUrut() {
		$sql = 'SELECT * 
				FROM antrian_panggil 
				WHERE tanggal = "' . date('Y-m-d') . '" 
				ORDER BY time_ambil DESC LIMIT 1';
		$result = $this->db->query($sql)->getRowArray();
		return $result;
	}
	
	public function getAllAntrianUrutAfterTimeAmbil($time_ambil) {
		$sql = 'SELECT * 
				FROM antrian_panggil 
				WHERE tanggal = "' . date('Y-m-d') . '" AND time_ambil > "' . $time_ambil . '"';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAntrianAmbilDipanggilByTime($id, $time_ambil, $time_dipanggil) {
		
		$tanggal = date('Y-m-d');
		$sql = 'SELECT antrian_detail.*,  antrian_panggil.*
				FROM antrian_panggil 
				LEFT JOIN (SELECT * FROM antrian_panggil_detail 
								LEFT JOIN antrian_panggil USING(id_antrian_panggil) 
								WHERE tanggal = ?
							)
					AS antrian_detail USING(id_antrian_panggil)
				WHERE antrian_panggil.id_antrian_kategori = ? AND antrian_panggil.tanggal = ?  ORDER BY waktu_panggil DESC LIMIT 1';
				
		$result = $this->db->query($sql, [$tanggal, $id, $tanggal])->getResultArray();
		if ($result) {
			foreach ($result as &$val) {
				$val['id'] = $id;
				$val['time_ambil'] = $time_ambil;
				$val['time_dipanggil'] = $time_dipanggil;
			}
		}
		return $result;
	}
	public function getAntrianAmbilSpc($id) {
		if ($id=='') {
			return [];
		}
		$tanggal = date('Y-m-d');
		$sql = 'SELECT antrian_detail.*,  antrian_panggil.*
				FROM antrian_panggil 
				LEFT JOIN (SELECT * FROM antrian_panggil_detail 
								LEFT JOIN antrian_panggil USING(id_antrian_panggil) 
								WHERE tanggal = ?
							)
					AS antrian_detail USING(id_antrian_panggil)
				WHERE antrian_panggil.id_antrian_kategori IN ('.$id.') AND antrian_panggil.tanggal = ? 
				ORDER BY antrian_panggil.id_antrian_kategori ASC ';
		$result = $this->db->query($sql, [$tanggal, $tanggal])->getResultArray();
		$res = [];
		if ($result) {
			foreach ($result as &$val) {
				$val['id'] = $id;
				if(!isset($res[$val['id_antrian_panggil']])){
					$res[$val['id_antrian_panggil']] = $val;
				}else{
					if (strtotime($res[$val['id_antrian_panggil']]['waktu_panggil'])<strtotime($val['waktu_panggil'])) {
						$res[$val['id_antrian_panggil']] = $val;
					}
				}
			}
		}
		return $res;
	}
	public function getLastAntrianAmbilOrDipanggil($id) {
		$sql = 'SELECT id_antrian_kategori, jml_antrian, jml_dipanggil, MAX(time_ambil) AS time_ambil, MAX(time_dipanggil) AS time_dipanggil 
				FROM antrian_panggil 
				WHERE id_antrian_kategori = ? AND tanggal = ?';
		$result = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		if ($result['time_ambil'] == '') {
			$result['time_ambil'] = '00:00:00';
		}
		if ($result['time_dipanggil'] == '') {
			$result['time_dipanggil'] = '00:00:00';
		}
		return $result;
	}
	
	public function getLastAntrianAmbil() {
		$sql = 'SELECT id_antrian_kategori, jml_antrian, MAX(time_ambil) AS time_ambil 
				FROM antrian_panggil 
				WHERE tanggal = ?';
		$result = $this->db->query($sql, [date('Y-m-d')])->getRowArray();
		return $result;
	}
	
	public function getAntrianAmbilByTime() {
		$sql = 'SELECT ap.id_antrian_kategori, jml_antrian , awalan
				FROM antrian_panggil as ap
				LEFT JOIN antrian_kategori  USING (id_antrian_kategori)
				WHERE tanggal = ?';
		$result = $this->db->query($sql, [date('Y-m-d')])->getResultArray();
		return $result;
	}
	
	public function getLastAntrianUpdate($id) {
		$sql = 'SELECT 
						( SELECT tgl_update AS tgl_update_kategori FROM antrian_kategori 
							LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
							WHERE id_setting_layar = ?
							ORDER BY tgl_update DESC LIMIT 1 
						) AS tgl_update_kategori,
						( 
							SELECT tgl_update AS tgl_update_tujuan FROM antrian_detail 
							LLEFT JOIN setting_layar_detail USING (id_antrian_kategori)
							WHERE id_setting_layar = ?
							ORDER BY tgl_update DESC LIMIT 1 
						) AS tgl_update_tujuan';
						
		$result = $this->db->query($sql, [(int) $id, (int) $id])->getRowArray();
		return $result;
	}
	
	public function getAllAntrianUpdate($id, $tgl_update) {
		
		// Cek Kategori
		$sql = 'SELECT * 
				FROM antrian_kategori 
				LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
				WHERE id_setting_layar = ?
				AND tgl_update > ?';
		$kategori = $this->db->query($sql, [$id, $tgl_update['tgl_update_kategori']])->getRowArray();
		$result['kategori'] = $kategori;
		if ($kategori) 
		{
			// Kategori Tujuan
			$sql = 'SELECT * FROM antrian_detail
					LEFT JOIN antrian_kategori USING(id_antrian_kategori)
					LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
					WHERE id_antrian_kategori = ?';
		
			$kategori_tujuan = $this->db->query($sql, $kategori['id_antrian_kategori'])->getResultArray();
			$result['kategori']['tujuan'] = $kategori_tujuan;
			
			// Jumlah antrian masing masing tujuan
			$sql = 'SELECT id_antrian_detail, id_antrian_kategori, COUNT(*) AS jml, MAX(nomor_panggil) AS nomor_panggil
					FROM antrian_panggil_detail
					LEFT JOIN antrian_panggil USING(id_antrian_panggil)
					LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
					WHERE id_setting_Layar = ? AND tanggal = ?
					GROUP BY id_antrian_detail';
		
			$query = $this->db->query($sql, [$id, date('Y-m-d')])->getResultArray();
			$tujuan_panggil = [];
			foreach ($query as $val) {
				$tujuan_panggil[$val['id_antrian_detail']] = $val;
			}
			$result['kategori']['tujuan_panggil'] = $tujuan_panggil;
		}
		
		
		// Cek update tujuan
		$sql = 'SELECT *, antrian_detail.aktif AS tujuan_aktif
				FROM antrian_detail
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
				WHERE id_setting_layar = ?
				AND antrian_detail.tgl_update > "' . $tgl_update['tgl_update_tujuan'] . '"';
		
		$tujuan = $this->db->query($sql, $id)->getRowArray();
		$result['tujuan'] = $tujuan;
		
		if ($tujuan) {
			// Jumlah antrian tujuan
			$sql = 'SELECT id_antrian_detail, id_antrian_kategori, COUNT(*) AS jml, MAX(nomor_panggil) AS nomor_panggil
					FROM antrian_panggil_detail
					LEFT JOIN antrian_panggil USING(id_antrian_panggil)
					WHERE id_antrian_detail = ? AND tanggal = ?
					GROUP BY id_antrian_detail';
		
			$tujuan_panggil = $this->db->query($sql, [$tujuan['id_antrian_detail'], date('Y-m-d')])->getRowArray();
			$result['tujuan']['tujuan_panggil'] = $tujuan_panggil;
		}
		
		if ($kategori || $tujuan) {
			// Antrian terakhir
			$sql = 'SELECT * FROM antrian_panggil_detail
					LEFT JOIN antrian_panggil USING(id_antrian_panggil)
					LEFT JOIN antrian_detail USING(id_antrian_detail)
					LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
					LEFT JOIN antrian_kategori ON antrian_detail.id_antrian_kategori = antrian_kategori.id_antrian_kategori
					WHERE tanggal = ? AND antrian_kategori.aktif = "Y" AND antrian_detail.aktif = "Y"
					ORDER BY waktu_panggil DESC LIMIT 1';
		
			$antrian_terakhir = $this->db->query($sql, date('Y-m-d'))->getRowArray();
			$result['antrian_terakhir'] = $antrian_terakhir;
		}
		if (!$result['kategori'] && ! $result['tujuan'])
			return false;
		
		return $result;
	}
	
	public function getAntrianLab($no_lab,$no_bilik) {
		$sql = 'SELECT id_antrian_detail,id_antrian_kategori,id_antrian_tujuan FROM antrian_tujuan
				LEFT JOIN antrian_detail USING(id_antrian_tujuan)
				WHERE nama_antrian_tujuan = ?';
		$result = $this->db->query($sql, ["Bilik ".$no_bilik])->getRowArray();
		if ($result) {
			$sql = 'SELECT nomor_antrian FROM antrian_lab
					WHERE no_lab = ? AND created_at >= ? AND created_at <= ? ORDER BY id DESC';
			$res= $this->db->query($sql, [$no_lab, date('Y-m-d 00:00:00'), date('Y-m-d 23:59:59')])->getRowArray();
			if ($res) {
				$result['nomor_antrian'] = $res['nomor_antrian'];
				return $result;
			}
		}
		return false;
	}

	public function setAntrianLab($no_lab,$no_bilik) {
		$data_db['no_bilik'] = $no_bilik;
		$data_db['status'] = 'proses';
		$update = $this->db->table('antrian_lab')->update($data_db, ['no_lab' => $no_lab]);
		return $update;
	}

	public function update7segment(){
		$sql = 'SELECT `at`.id_antrian_tujuan as id, nama_antrian_tujuan as nama,ip_addr FROM antrian_tujuan as `at`
		WHERE nama_antrian_tujuan LIKE "%Bilik%" ;';
		$result = $this->db->query($sql, [date('Y-m-d')])->getResultArray();
		
		$cek_status_bilik = 'SELECT `status` FROM antrian_lab
		WHERE no_bilik = ? AND created_at >= ? AND created_at <= ? ORDER BY created_at DESC LIMIT 1;';

		$bilik = [];
		if (!empty($result)) {
			foreach ($result as $key => $value) {
				$no_bilik = str_replace('Bilik ','',$value['nama']);
				$bilik[$value['id']]['no_bilik'] = $no_bilik;
				$bilik[$value['id']]['nama'] = $value['nama'];
				$bilik[$value['id']]['ip_addr'] = $value['ip_addr'];
				$bilik[$value['id']]['nomor_panggil'] = "-";
				$bilik[$value['id']]['waktu_panggil'] = "00:00:00";
				
				$rs = $this->db->query($cek_status_bilik, [$no_bilik,date('Y-m-d 00:00:00'),date('Y-m-d 23:59:59')])->getRowArray();
				$bilik[$value['id']]['status'] = (isset($rs['status']))?$rs['status']:'kosong';
			}
			$sql = 'SELECT `at`.id_antrian_tujuan as id, nama_antrian_tujuan as nama, nomor_panggil ,waktu_panggil, ip_addr FROM antrian_tujuan as `at`
			LEFT JOIN antrian_detail as ad ON ad.id_antrian_tujuan = `at`.id_antrian_tujuan
			LEFT JOIN antrian_panggil_detail `apd` ON ad.id_antrian_detail = `apd`.id_antrian_detail
			LEFT JOIN antrian_panggil `ap` ON apd.id_antrian_panggil = `ap`.id_antrian_panggil
			WHERE tanggal = ? AND nama_antrian_tujuan LIKE "%Bilik%" ;';
			$res = $this->db->query($sql, [date('Y-m-d')])->getResultArray();
			if (!empty($res)) {
				foreach ($res as $key => $value) {
					if (strtotime($value['waktu_panggil'])>strtotime($bilik[$value['id']]['waktu_panggil'])) {
						$no_bilik = str_replace('Bilik ','',$value['nama']);
						$bilik[$value['id']]['no_bilik'] = $no_bilik;
						$bilik[$value['id']]['nama'] = $value['nama'];
						$bilik[$value['id']]['ip_addr'] = $value['ip_addr'];
						$bilik[$value['id']]['nomor_panggil'] = $value['nomor_panggil'];
						$bilik[$value['id']]['waktu_panggil'] = $value['waktu_panggil'];
						$rs = $this->db->query($cek_status_bilik, [$no_bilik,date('Y-m-d 00:00:00'),date('Y-m-d 23:59:59')])->getRowArray();
						$bilik[$value['id']]['status'] = (isset($rs['status']))?$rs['status']:'kosong';
					}
				}
			}
		}
		$bilik = array_values($bilik);
		$filename = FCPATH . 'public/7segment.json';
		$file_content = json_encode($bilik,JSON_PRETTY_PRINT);
		
		$file_handle = fopen($filename, 'w');
		
		if ($file_handle) {
			if (fwrite($file_handle, $file_content) !== false) {
			}
			fclose($file_handle);
		}
	}
}
?>