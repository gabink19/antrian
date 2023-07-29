<?php
/**
*	App Name	: Aplikasi Antrian Berbasis Web	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2022
*/

namespace App\Controllers;
use App\Models\AntrianPanggilModel;
use App\Models\AntrianAmbilModel;
use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\PrintConnectors\NetworkPrintConnector;
use Mike42\Escpos\Printer;

require APPPATH . 'ThirdParty/Escpos/vendor/autoload.php';

class Antrian_panggil extends \App\Controllers\BaseController
{
	public function __construct() {
		
		parent::__construct();
		
		$this->model = new AntrianPanggilModel;	
		$this->modelAmbilAntrian = new AntrianAmbilModel;	
		$this->data['site_title'] = 'Panggil Antrian';

		$this->addJs ( $this->config->baseURL . 'public/themes/modern/js/antrian-panggil.js');
	}
	
	public function index()
	{
		$this->hasPermissionPrefix('read');
		$this->data['title'] = 'Panggil Antrian';
		$this->setKategori();
		
		$namaRole = 'Loket';
		$findRole = $this->findRole($this->data['user'], $namaRole);
		if ($findRole != null) 
		{
			$this->addJs ( $this->config->baseURL . 'public/themes/modern/js/antrian-panggil-liveupdate-special.js');
			
			$kategori_onWL = $this->model->getKategoriWhitelist($_SERVER['REMOTE_ADDR']);
			$idx = 0;
			foreach($kategori_onWL as $val){
				$antrian_kategori = $this->model->getAntrianKategoriById($val['id_antrian_kategori']);
				if (!$antrian_kategori) {
					$this->errorDataNotFound();
				}
				
				$this->data['data_list'][$idx]['kategori'] = $antrian_kategori;
				$this->data['data_list'][$idx]['antrian'] = $this->model->getAntrianDetailByIdKategori($val['id_antrian_kategori'],$_SERVER['REMOTE_ADDR']);
				$this->data['data_list'][$idx]['jml_dipanggil'] = $this->model->getDipanggil($val['id_antrian_kategori'],$_SERVER['REMOTE_ADDR']);
				$idx++;
			}
			
			$query = $this->model->getAntrianUrut();

			$antrian_urut = [];
			foreach ($query as $val) {
				$antrian_urut[$val['id_antrian_kategori']] = $val;
			}
			
			$this->data['antrian_urut'] = $antrian_urut;
			if (!isset($this->data['data_list'])) {
				$this->data['msg'] = 'PC ini (ip: '.$_SERVER['REMOTE_ADDR'].') belum didaftarkan di referensi tujuan untuk user loket/bilik. Hanya user dengan role admin yg bisa digunakan di pc ini.';
				$this->view('error.php', $this->data);
				die;
			}
			$this->view('antrian-panggil-detail-special.php', $this->data);
			die;
		}
		if (!empty($_GET['kategori'])) 
		{
			$this->addJs ( $this->config->baseURL . 'public/themes/modern/js/antrian-panggil-liveupdate.js');
			
			$antrian_kategori = $this->model->getAntrianKategoriById($_GET['kategori']);
			if (!$antrian_kategori) {
				$this->errorDataNotFound();
			}
			
			$this->data['kategori'] = $antrian_kategori;
			$this->data['antrian'] = $this->model->getAntrianDetailByIdKategori($_GET['kategori']);
			$this->data['jml_dipanggil'] = $this->model->getDipanggil($_GET['kategori']);
			
			$query = $this->model->getAntrianUrut();

			$antrian_urut = [];
			foreach ($query as $val) {
				$antrian_urut[$val['id_antrian_kategori']] = $val;
			}
			
			
			$this->data['antrian_urut'] = $antrian_urut;
			$this->view('antrian-panggil-detail.php', $this->data);
		} else {
			
			$this->data['setting_layar'] = $this->model->getAllSettingLayar();
			$data = $this->model->getAllTujuan();
			$tujuan = [];
			foreach ($data as $val) {
				if ($val['id_setting_layar']) {
					$tujuan[$val['id_setting_layar']][$val['id_antrian_kategori']]['nama'] = $val['nama_antrian_kategori'];
					$tujuan[$val['id_setting_layar']][$val['id_antrian_kategori']]['tujuan'][] = $val;
				} else {
					$tujuan['undefined'][$val['id_antrian_kategori']]['nama'] = $val['nama_antrian_kategori'];
					$tujuan['undefined'][$val['id_antrian_kategori']]['tujuan'][] = $val;
				}
			}
			
			if (!$tujuan) {
				$this->errorDataNotFound();
				return;
			}
			
			if (key_exists('undefined', $tujuan)) {
				$this->data['setting_layar']['undefined'] = ['id_setting_layar' => 'undefined', 'nama_setting' => ''];
			}
			$this->data['tujuan'] = $tujuan;
			$this->view('antrian-panggil-kategori.php', $this->data);
			
		}
	}
	
	private function setKategori() {
		
		$antrian_kategori = $this->model->getAntrianKategoriAktif();
		if (count($antrian_kategori) == 1) {
			$_GET['kategori'] = $antrian_kategori[0]['id_antrian_kategori'];
		}
	}
		
	public function panggil_antrian() 
	{
		$this->data['title'] = 'Panggil Antrian';
		$this->setKategori();
		
		if (!empty($_GET['kategori'])) 
		{
			$this->addJs ( $this->config->baseURL . 'public/themes/modern/js/antrian-liveupdate-panggil.js');
			
			$antrian_kategori = $this->model->getAntrianKategoriById($_GET['kategori']);
			if (!$antrian_kategori) {
				$this->errorDataNotFound();
			}
			
			$this->data['antrian'] = $this->model->getAntrianDetailByIdKategori($_GET['kategori']);
			
			$query = $this->model->getAntrianUrut();

			$antrian_urut = [];
			foreach ($query as $val) {
				$antrian_urut[$val['id_antrian_detail']] = $val;
			}
			
			$this->data['antrian_urut'] = $antrian_urut;
			$this->view('antrian-panggil-detail.php', $this->data);
		} else {
		
			$this->data['antrian'] = $this->model->getAntrianKategori();
			$this->view('antrian-panggil-kategori.php', $this->data);
		}
	}
	
	public function ajax_panggil_antrian() 
	{
		if (empty($_POST['id'])) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$id = $_POST['id'];
		$result = $this->model->getAntrianDetailById($id);
		if (!$result) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$urut = $this->model->getAntrianUrutByIdKategori($result['id_antrian_kategori']);
		if ($urut['jml_dipanggil'] >= $urut['jml_antrian']) {
			$message['status'] = 'error';
			$message['message'] = 'Semua antrian sudah dipanggil';
			echo json_encode($message);
			exit;
		}
		
		$panggil = $this->model->panggilAntrian($result['id_antrian_kategori'], $id);
		if ($panggil) {
			$message['status'] = 'ok';
			$message['message'] = $panggil;
		} else {
			$message['status'] = 'error';
			$message['message'] = 'Error memanggil antrian';
		}
		
		echo json_encode($message);
		exit;
	}
	
	public function ajax_panggil_ulang_antrian() 
	{
		if (empty($_POST['id'])) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$id = $_POST['id'];
		$antrian_detail = $this->model->getAntrianDetailById($id);
		if (!$antrian_detail) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$save = $this->model->savePanggilUlangAntrian($id);

		if ($save) {
			$message['status'] = 'ok';
			$message['message'] = 'Data berhasil disimpan';
		} else {
			$message['status'] = 'error';
			$message['message'] = 'Data gagal disimpan';
		}
		
		echo json_encode($message);
		exit;
	}

	public function ajax_lewati_antrian() 
	{
		if (empty($_POST['id'])) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$id = $_POST['id'];
		$result = $this->model->getAntrianDetailById($id);
		if (!$result) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}

		$re = $this->model->lewatiPanggilan($id);
		if (!$re) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$urut = $this->model->getAntrianUrutByIdKategori($result['id_antrian_kategori']);

		if ($urut['jml_dipanggil'] >= $urut['jml_antrian']) {
			$message['status'] = 'error';
			$message['message'] = 'Semua antrian sudah dipanggil';
			echo json_encode($message);
			exit;
		}
		
		echo json_encode('skip');
		exit;
	}

	public function ajax_spesial_panggil_antrian() 
	{
		if (empty($_POST['id']) || empty($_POST['nomor_antrian']) || empty($_POST['kategori'])) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$id = $_POST['id'];
		$nomor_antrian = $_POST['nomor_antrian'];
		$kategori = $_POST['kategori'];
		$antrianpanggil = $this->model->getAntrianPanggil($id,$nomor_antrian,$kategori);
		if (!$antrianpanggil){
			$antrian_detail = $this->model->getAntrianDetailByIdAndAntrian($id,$nomor_antrian);
			if (!$antrian_detail) {
				$message['status'] = 'error';
				$message['message'] = 'Invalid input';
				echo json_encode($message);
				exit;
			}
			
			$save = $this->model->saveSpesialPanggilAntrian($id,$nomor_antrian);
	
			if ($save) {
				$message['status'] = 'ok';
				$message['ws'] = 'panggilulang_'.$kategori;
				$message['message'] = 'Data berhasil disimpan';
			} else {
				$message['status'] = 'error';
				$message['message'] = 'Data gagal disimpan';
			}
			
			echo json_encode($message);
		}else{
			$panggil = $this->model->panggilAntrian($kategori, $id, $nomor_antrian);
			if ($panggil) {
				$message['status'] = 'ok';
				$message['ws'] = 'panggil_'.$kategori;
				$message['message'] = $panggil;
			} else {
				$message['status'] = 'error';
				$message['message'] = 'Error memanggil antrian';
			}
			
			echo json_encode($message);
		}
		exit;
	}

	public function ajax_cetak_antrian_c() 
	{
		if (empty($_POST['id']) || empty($_POST['no_lab'])) {
			$message['status'] = 'error';
			$message['message'] = 'Invalid input';
			echo json_encode($message);
			exit;
		}
		
		$id = $_POST['id'];
		$no_lab = $_POST['no_lab'];
		$kategori = $this->model->getIDKategoriC();
		if (!$kategori) {
			$message['status'] = 'error';
			$message['data'] = 'Kategori Bilik dengan awalan C tidak ditemukan.';
			echo json_encode($message);
			exit;
		}
		$antrian = $this->modelAmbilAntrian->ambilAntrian($kategori);
		if (!$antrian){
			$message['status'] = 'error';
			$message['message'] = 'Error Cetak antrian C';
		}else{
			$nomor_antrian = $antrian['jml_antrian'];
			$saveAntrian = $this->model->saveCetakAntrianLab($id,$no_lab,$nomor_antrian);
			$antrian['nama_antrian_tujuan'] = $saveAntrian['nama_antrian_tujuan'];
			if ($antrian) {
				$this->cetakAntrian($antrian);
				$message['status'] = 'ok';
				$message['data'] = $antrian;
			} else {
				$message['status'] = 'error_printer';
				$message['data'] = 'Error Cetak antrian C';
			}
		}
		echo json_encode($message);
		exit;
	}

	private function findRole($data, $roleName) {
		foreach ($data['role'] as $role) {
			if ($role['nama_role'] === $roleName) {
				return $role;
			}
		}
		return null;
	}

	private function cetakAntrian($antrian,$print_method="network") {
		try {
			$identitas = $this->modelAmbilAntrian->getIdentitas();
			$printer_aktif = $this->modelAmbilAntrian->getAktifPrinter();
			if ($printer_aktif) {
				foreach ($printer_aktif as $val) {
					if ($val['nama_setting_printer'] != $antrian['nama_antrian_tujuan']) {
						continue;
					}
					if ($print_method=="network") {
						$connector = new NetworkPrintConnector($val['alamat_server'], 9100, 5);
					} else if ($print_method=="windows"){
						$connector = new WindowsPrintConnector($val['alamat_server']);
					}
					$printer = new Printer($connector);
					
					$printer -> setJustification(Printer::JUSTIFY_CENTER);
					$printer->setFont(Printer::FONT_A);
					$printer->setTextSize(1,1);
					$printer -> text(strtoupper($identitas['nama']) . "\n");
					$printer -> text("NOMOR ANTRIAN\n");
					$printer -> text("=========================");
					$printer -> text("\n");
					$printer->setTextSize(7,7);
					$printer -> text($antrian['awalan'] . $antrian['jml_antrian']);
					$printer->setTextSize(1,1);
					$printer -> text("\n=========================\n");
					$printer -> text($antrian['nama_antrian_kategori'] . "\n");
					$printer -> text(format_tanggal(date('Y-m-d')) . "\n");
					$printer -> text(date('H:i:s'));
					$printer -> feed(2);
					$printer -> cut();
					
					/* Close printer */
					$printer -> close();
				}
			}
		} catch (Exception $e) {
			echo "Couldn't print to this printer: " . $e -> getMessage() . "\n";
		}
	}
}
