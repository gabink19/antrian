<?php
/**
*	App Name	: Antrian	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2022
*/

namespace App\Models;

class AntrianPanggilModel extends \App\Models\BaseModel
{
	public function __construct() {
		parent::__construct();
	}
	
	public function getAllSettingLayar() {
		$sql = 'SELECT setting_layar.*, GROUP_CONCAT(nama_antrian_kategori) AS nama_kategori FROM setting_layar
				LEFT JOIN setting_layar_detail USING(id_setting_layar)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				GROUP BY id_setting_layar';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAllTujuan() {
		$sql = 'SELECT * FROM antrian_detail 
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				LEFT JOIN setting_layar USING(id_setting_layar)';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAntrianKategoriAktif() {

		$sql = 'SELECT * 
				FROM antrian_kategori
				WHERE aktif = 1';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getSettingLayar() {

		$sql = 'SELECT *
				FROM setting_layar';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}

	public function getAntrianKategori() {
		
		$sql = 'SELECT antrian_kategori.*, jml_tujuan 
				FROM antrian_kategori
				LEFT JOIN (SELECT id_antrian_kategori, COUNT(id_antrian_detail) AS jml_tujuan 
							FROM antrian_detail GROUP BY id_antrian_kategori) AS tabel USING(id_antrian_kategori)';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAntrianKategoriById($id) {
		$sql = 'SELECT antrian_kategori.*, IF(nomor_panggil = "" OR nomor_panggil IS NULL, 0, nomor_panggil) AS nomor_panggil
				FROM antrian_kategori 
				LEFT JOIN antrian_panggil USING(id_antrian_kategori)
				LEFT JOIN antrian_panggil_detail USING(id_antrian_panggil)
				WHERE id_antrian_kategori = ? AND tanggal = ? ORDER BY id_antrian_panggil_detail DESC';
		$result = $this->db->query($sql, [trim($id), date('Y-m-d')])->getRowArray();
		if (empty($result)){
			$sql = 'SELECT * FROM antrian_kategori WHERE id_antrian_kategori = ?';
			$result = $this->db->query($sql, trim($id))->getRowArray();
		}
		return $result;
	}
	
	public function getAntrianDetailByIdKategori($id,$ip_addr=false) {
		$sql = 'SELECT antrian_detail.*, nama_antrian_tujuan FROM antrian_detail 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori) 
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan) 
				WHERE id_antrian_kategori = ?';
		if ($ip_addr){
			$sql .= ' AND ip_addr = "'.$ip_addr.'"';
		}
		$result = $this->db->query($sql, trim($id))->getResultArray();
		return $result;
	}
	
	public function getAntrianDetailById($id) {
		$sql = 'SELECT * FROM antrian_detail
				WHERE id_antrian_detail = ?';
		$result = $this->db->query($sql, trim($id))->getRowArray();
		return $result;
	}
		
	public function panggilAntrian($id_antrian_kategori, $id_antrian_detail, $nomor_antrian='false') 
	{
		$tanggal = date('Y-m-d');
		$sql = 'SELECT * FROM antrian_panggil WHERE id_antrian_kategori = ? AND tanggal = "' . $tanggal . '"';
		$antrian_panggil = $this->db->query($sql, (int) $id_antrian_kategori)->getRowArray();
		if ($antrian_panggil) {
			$next = $antrian_panggil['jml_dipanggil'] + 1;
			$data_db['jml_dipanggil'] = $next;
			$data_db['time_dipanggil'] = date('H:i:s');
			$this->db->transStart();
			$this->db->table('antrian_panggil')->update($data_db, ['id_antrian_kategori' => $id_antrian_kategori, 'tanggal' => $tanggal]);
			
			// Insert Antrian Detail
			$sql = 'SELECT * FROM antrian_kategori WHERE id_antrian_kategori = ?';
			$antrian_kategori = $this->db->query($sql, (int) $id_antrian_kategori)->getRowArray();
			
			$data_db = [];
			$data_db['id_antrian_panggil'] = $antrian_panggil['id_antrian_panggil'];
			$data_db['id_antrian_detail'] = $id_antrian_detail;
			$data_db['awalan_panggil'] = $antrian_kategori['awalan'];
			if($nomor_antrian!='false'){
				$data_db['nomor_panggil'] = $nomor_antrian;
				$data_db['spesial_panggil'] = 1;
			}else{
				$sql = 'SELECT nomor_panggil
						FROM antrian_panggil_detail WHERE id_antrian_panggil = ? AND spesial_panggil = 1 ORDER BY nomor_panggil asc';
				$group_sp = $this->db->query($sql, (int) $antrian_panggil['id_antrian_panggil'])->getResultArray();
				
				$sql = 'SELECT IF(nomor_panggil = "" OR nomor_panggil IS NULL, 0, nomor_panggil) AS nomor_panggil 
						FROM antrian_panggil_detail WHERE id_antrian_panggil = ? AND spesial_panggil = 0 ORDER BY id_antrian_panggil_detail DESC';
				$last_antrian = $this->db->query($sql, (int) $antrian_panggil['id_antrian_panggil'])->getRowArray();
				if(empty($last_antrian)){
					$data_db['nomor_panggil'] = 1;
				}else{
					$data_db['nomor_panggil'] = $last_antrian['nomor_panggil'] + 1;
					if($group_sp != ''){
						foreach($group_sp as $v){
							if($v['nomor_panggil']!=$data_db['nomor_panggil']){
								break;
							}
							$data_db['nomor_panggil']++;
						}
					}
				}
			}
			$data_db['waktu_panggil'] = date('H:i:s');
			$this->db->table('antrian_panggil_detail')->insert($data_db);
			
			$this->db->transComplete();
			if ($this->db->transStatus()) 
			{
				$result = $this->getAntrianUrutByIdKategori($id_antrian_kategori);
				$sql = 'SELECT COUNT(*) AS jml FROM antrian_panggil
						LEFT JOIN antrian_panggil_detail USING(id_antrian_panggil)
						WHERE id_antrian_kategori = ? AND id_antrian_detail = ? AND tanggal = ?';
				
				$jml_dipanggil = $this->db->query($sql, [$id_antrian_kategori, $id_antrian_detail, $tanggal])->getRowArray();
				$result['jml_dipanggil_by_loket'] = $jml_dipanggil['jml'];
				
				return $result;
			}
		}
		
		return false;
	}
	
	// Dipanggil group by loket
	public function getDipanggil($id_antrian_kategori,$ip_addr=false) {
		$tanggal = date('Y-m-d');
		$sql = 'SELECT id_antrian_detail, COUNT(*) AS jml_dipanggil, MAX(nomor_panggil) AS no_terakhir, id_antrian_panggil
				FROM antrian_panggil
				LEFT JOIN antrian_panggil_detail USING(id_antrian_panggil)
				WHERE id_antrian_kategori = ? AND tanggal = ?
				GROUP BY id_antrian_detail';
		
		$data = $this->db->query($sql, [$id_antrian_kategori, $tanggal])->getResultArray();
		$result = [];
		foreach ($data as $val) {
			$total = 0;
			if ($ip_addr){
				$sql = 'SELECT count(1) as total
						FROM antrian_detail 
						LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
						WHERE ip_addr = ? AND id_antrian_detail = ? ';
				$res = $this->db->query($sql, [$ip_addr, $val['id_antrian_detail']])->getRowArray();
				$total = $res['total'];
				if ($total > 0) {
					$result[$val['id_antrian_detail']] = $val;
				}
			}else{
				$result[$val['id_antrian_detail']] = $val;
			}
			$sql = 'SELECT nomor_panggil
					FROM antrian_panggil_detail 
					WHERE id_antrian_panggil = ? AND id_antrian_detail = ? ORDER BY waktu_panggil DESC';
			$asb = $this->db->query($sql, [$val['id_antrian_panggil'], $val['id_antrian_detail']])->getRowArray();
			$result[$val['id_antrian_detail']]['no_terakhir'] = (isset($asb['nomor_panggil']))?$asb['nomor_panggil']:0;
		}
		
		return $result;
	}
	
	public function getAntrianUrut()
	{
		$tgl_awal = date('Y-m-d');
		$tgl_akhir = date('Y-m-d');
		$sql = 'SELECT * 
				FROM antrian_panggil
				WHERE tanggal >= "' . $tgl_awal . '" 
					AND tanggal <= "' . $tgl_akhir . '"';
		// echo $sql; die;
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAntrianUrutByIdKategori($id)
	{
		$tgl_awal = date('Y-m-d');
		$tgl_akhir = date('Y-m-d');
		$sql = 'SELECT * 
				FROM antrian_panggil 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				WHERE tanggal >= "' . $tgl_awal . '" 
					AND tanggal <= "' . $tgl_akhir . '" 
					AND id_antrian_kategori = ?';
		$result = $this->db->query($sql, (int) $id)->getRowArray();
		return $result;
	}
	
	public function savePanggilUlangAntrian($id)
	{									
		$sql = 'SELECT id_antrian_panggil_detail, id_setting_layar FROM antrian_panggil_detail 
				LEFT JOIN antrian_panggil USING(id_antrian_panggil)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				WHERE id_antrian_detail = ? AND tanggal = ?
				ORDER BY waktu_panggil DESC LIMIT 1';
		
		$data = $this->db->query($sql, [$id, date('Y-m-d')])->getRowArray();
		if ($data) {
			$data_db['id_setting_layar'] = $data['id_setting_layar'];
			$data_db['id_antrian_panggil_detail'] = $data['id_antrian_panggil_detail'];
			$data_db['tanggal_panggil_ulang'] = date('Y-m-d');
			$data_db['waktu_panggil_ulang'] = date('H:i:s');
			return $this->db->table('antrian_panggil_ulang')->insert($data_db);
		}
		return false;
	}

	public function cariIPTujuan($id)
	{
		$tgl_awal = date('Y-m-d');
		$tgl_akhir = date('Y-m-d');
		$sql = 'SELECT * 
				FROM antrian_panggil 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				WHERE tanggal >= "' . $tgl_awal . '" 
					AND tanggal <= "' . $tgl_akhir . '" 
					AND id_antrian_kategori = ?';
		$result = $this->db->query($sql, (int) $id)->getRowArray();
		return $result;
	}
	public function getKategoriWhitelist($ip_addr)
	{
		$sql = 'SELECT id_antrian_kategori 
				FROM antrian_detail AS ad
				LEFT JOIN antrian_tujuan AS at ON ad.id_antrian_tujuan=at.id_antrian_tujuan
				WHERE ip_addr = "' . $ip_addr . '"';
		// echo $sql; die;
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	public function lewatiPanggilan($id) {
		$sql = 'UPDATE antrian_panggil_detail SET lewati = ? WHERE id_antrian_detail = ?  AND id_antrian_panggil_detail = (
			SELECT MAX(id_antrian_panggil_detail)
			FROM antrian_panggil_detail
			WHERE id_antrian_detail = ?
		  )';
		$query = $this->db->query($sql, [date('Y-m-d H:i:s'),$id,$id]);
		return $query;
	}
	public function getAntrianDetailByIdAndAntrian($id,$nomor_antrian) {
		$sql = 'SELECT * FROM antrian_panggil_detail
				LEFT JOIN antrian_panggil USING(id_antrian_panggil)
				WHERE id_antrian_detail = ? AND nomor_panggil = ? AND tanggal = ?';
		$result = $this->db->query($sql, [trim($id),trim($nomor_antrian), date('Y-m-d')])->getRowArray();
		return $result;
	}
	public function saveSpesialPanggilAntrian($id,$nomor_antrian)
	{									
		$sql = 'SELECT id_antrian_panggil_detail, id_setting_layar FROM antrian_panggil_detail 
				LEFT JOIN antrian_panggil USING(id_antrian_panggil)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				WHERE id_antrian_detail = ? AND tanggal = ? AND nomor_panggil = ?
				ORDER BY waktu_panggil DESC LIMIT 1';
		
		$data = $this->db->query($sql, [$id, date('Y-m-d'),trim($nomor_antrian)])->getRowArray();
		if ($data) {
			$data_db['id_setting_layar'] = $data['id_setting_layar'];
			$data_db['id_antrian_panggil_detail'] = $data['id_antrian_panggil_detail'];
			$data_db['tanggal_panggil_ulang'] = date('Y-m-d');
			$data_db['waktu_panggil_ulang'] = date('H:i:s');
			return $this->db->table('antrian_panggil_ulang')->insert($data_db);
		}
		return false;
	}
	public function getAntrianPanggil($id,$nomor_antrian,$kategori,$skip=false){
		$spesial = ($skip)?"":"AND spesial_panggil = 0";
		$sql = "SELECT (jml_antrian - jml_dipanggil) as sisa_antrian, nomor_panggil as no_terakhir, nomor_panggil, spesial_panggil 
				FROM antrian_panggil
				INNER JOIN antrian_panggil_detail USING(id_antrian_panggil)
				WHERE id_antrian_kategori = ? AND tanggal = ? $spesial
				ORDER BY waktu_panggil DESC";
		
		$data = $this->db->query($sql, [$kategori, date('Y-m-d')])->getRowArray();
		if(!empty($data)){
			$max_antrian = $data['no_terakhir'] + $data['sisa_antrian'];
			if($nomor_antrian > $max_antrian){
				return false;
			}
			if($data['nomor_panggil'] >= $nomor_antrian){
				return false;
			}
		}else{
			$sql = 'SELECT (jml_antrian - jml_dipanggil) as sisa_antrian
					FROM antrian_panggil
					WHERE id_antrian_kategori = ? AND tanggal = ? LIMIT 1';
			$data = $this->db->query($sql, [$kategori, date('Y-m-d')])->getRowArray();
			$max_antrian = 0 + $data['sisa_antrian'];
			if($nomor_antrian > $max_antrian){
				return false;
			}
		}
		return true;
	}
	public function saveCetakAntrianLab($id,$no_lab,$nomor_antrian)
	{					
		$sql = 'SELECT nama_antrian_tujuan FROM antrian_detail
				LEFT JOIN antrian_tujuan USING (id_antrian_tujuan)
				WHERE id_antrian_detail = ?';
		
		$data_db = $this->db->query($sql, $id)->getRowArray();

		$data_db['id_antrian_detail'] = $id;
		$data_db['no_lab'] = $no_lab;
		$data_db['nomor_antrian'] = $nomor_antrian;
		$save = $this->db->table('antrian_lab')->insert($data_db);
		if ($save) {
			return $data_db;
		}
		return false;
	}
	function getIDKategoriC(){
		$sql = 'SELECT id_antrian_kategori FROM antrian_kategori
				WHERE awalan = "C"';
		
		$data_db = $this->db->query($sql)->getRowArray();
		if ($data_db!='') {
			return $data_db['id_antrian_kategori'];
		}
		return false;
	}
}
?>