<?php
/**
*	App Name	: jMedik	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2021
*/

namespace App\Controllers;
use App\Models\LongPollingModel;
use Textalk\Websocket\Client as TextalkWebSocketClient;
use React\EventLoop\Factory;

class LongPolling extends \App\Controllers\BaseController
{
	public function __construct() {
		
		parent::__construct();
		
		$this->model = new LongPollingModel;	
	}
	
	/* Liveupdate layar monitor besar */
	public function monitor_current_antrian()
	{
		try {
			if (empty($_GET['id'])) {
				echo json_encode(
					[
						'status' => 'error',
						'message' => 'Invalid input'
					]
				);
				exit;
			}
			$id = $_GET['id'];
			
			$new_antrian =  $this->model->getPanggilanTerakhir($id);
			if ($new_antrian) {
				echo json_encode([
					'status' => 'ok',
					'data' => $new_antrian
				]);
				exit;
			}
			clearstatcache();
			sleep(1);
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	/* Liveupdate layar monitor besar - Cek panggil ulang antrian */
	public function monitor_panggil_ulang_antrian() {
		if (empty($_GET['id'])) {
			echo json_encode(
				[
					'status' => 'error',
					'message' => 'Invalid input'
				]
			);
			exit;
		}
		$id = $_GET['id'];
		$data_baru = $this->model->getPanggilUlang($id);
		if ($data_baru) {
			
			echo json_encode([
				'status' => 'ok',
				'data' => $data_baru
			]);
			
			exit;					
		}
	}
	
	/* Cek jika perubahan pada antrian misal nama tujuan, aktif dan non aktif */
	public function monitor_perubahan_antrian() 
	{
		try {
			if (empty($_GET['id'])) {
				echo json_encode(
					[
						'status' => 'error',
						'message' => 'Invalid input'
					]
				);
				exit;
			}
			$id = $_GET['id'];
			$perubahan_terakhir = $this->model->getLastAntrianUpdate($id);
			if ($perubahan_terakhir) {
				$data_baru = $this->model->getAllAntrianUpdate($id, $perubahan_terakhir);
				if ($data_baru) {
					/* foreach ($cek_perubahan as $val) {
						$result[$val['id_antrian_detail']] = $val;
					} */
					echo json_encode([
						'status' => 'ok',
						'data' => $data_baru
					]);
					
					exit;					
				}
				sleep(1);
			}
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	/* Cek apakah ada antrian baru atau ada panggilan baru, untuk update data display antrian dan panggilan di tab browser lain*/
	public function current_antrian_dipanggil() 
	{
		try {
			$urut_terakhir = $this->model->getLastAntrianAmbilOrDipanggil($_POST['id_antrian_kategori']);
			$new_antrian_urut = $this->model->getAntrianAmbilDipanggilByTime($_POST['id_antrian_kategori'],$urut_terakhir['time_ambil'], $urut_terakhir['time_dipanggil'] );
			// print_r($new_antrian_urut); die;
			if ($new_antrian_urut) {
				echo json_encode([
					'status' => 'ok',
					'data' => $new_antrian_urut
				]);
				
				exit;					
			}
			echo json_encode(
					array (
						'status' => false,
						'data' => ''
					)
				);
			exit;
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	public function current_antrian_dipanggil_spc() 
	{
		try {
			$new_antrian_urut = $this->model->getAntrianAmbilSpc($_POST['id_antrian_kategori']);
			
			if ($new_antrian_urut) {
				echo json_encode([
					'status' => 'ok',
					'data' => $new_antrian_urut
				]);
				
				exit;					
			}else{
				echo json_encode(
						array (
							'status' => false,
							'data' => ''
						)
					);
				exit;
			}
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	/* Cek apakah ada antrian baru, untuk sinkronisasi antara layar antrian dan menu ambil antrian*/
	public function current_antrian_ambil() 
	{
		try {
			$new_antrian_urut = $this->model->getAntrianAmbilByTime();
			if ($new_antrian_urut) {
				foreach ($new_antrian_urut as $val) {
					$result[$val['id_antrian_kategori']] = $val;
				}
				echo json_encode([
					'status' => 'ok',
					'data' => $result
				]);
				
				exit;					
			}
			echo json_encode([
				'status' => 'not ok',
				'data' => ''
			]);
			exit;
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	/* Cek apakah ada antrian baru, untuk update data display antrian */
	public function current_urut() 
	{
		try {
			
			$urut_terakhir = $this->model->getLastAntrianUrut();
			if ($urut_terakhir) {
					
				$new_antrian_urut = $this->model->getAllAntrianUrutAfterTimeAmbil($urut_terakhir['time_ambil']);
				
				if ($new_antrian_urut) {
					foreach ($new_antrian_urut as $val) {
						$result[$val['id_antrian_detail']] = $val;
					}
					echo json_encode([
						'status' => 'ok',
						'data' => $result
					]);
					
					exit;					
				}
			}
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	public function antrian_habis() 
	{
		try {
			
			$urut_terakhir = $this->model->getLastAntrianUrut();
			$belum_dipanggil = $this->model->getAllAntrianUrutBelumDipanggil();
			if ($belum_dipanggil) {
				if ($belum_dipanggil[0]['time_ambil'] > $urut_terakhir['time_ambil']) {
					
					foreach ($belum_dipanggil as $val) {
						$result[$val['id_antrian_detail']] = $val;
					}
					echo json_encode([
						'status' => 'ok',
						'data' => $result
					]);
					
					exit;
				}
			}
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}
	
	public function belum_dipanggil() 
	{
		try {
			
			$urut_terakhir = $this->model->getLastAntrianUrut();
			$belum_dipanggil = $this->model->getAllAntrianUrutBelumDipanggil();
			if ($belum_dipanggil) {
				if ($belum_dipanggil[0]['time_ambil'] > $urut_terakhir['time_ambil']) {
					
					foreach ($belum_dipanggil as $val) {
						$result[$val['id_antrian_detail']] = $val;
					}
					echo json_encode([
						'status' => 'ok',
						'data' => $result
					]);
					
					exit;
				}
			}
		} catch (Exception $e) {
			echo json_encode(
					array (
						'status' => false,
						'error' => $e -> getMessage()
					)
				);
			exit;
		}
	}

	public function set_antrian_lab() 
	{
		if (!isset($_GET['no_lab']) || !isset($_GET['no_bilik'])) {
			return json_encode(['status' => 'error', 'message' => 'Parameter tidak sesuai.']);
		}
		$no_lab = $_GET['no_lab'];
		$no_bilik = $_GET['no_bilik'];
		$get_lab = $this->model->getAntrianLab($no_lab,$no_bilik);
		if (!$get_lab) {
			return json_encode(['status' => 'error', 'message' => 'No Lab tidak ditemukan.']);
		}
		$AntrianPanggilan = new Antrian_panggil();
		$panggil_spec = $AntrianPanggilan->ajax_spesial_panggil_antrian($get_lab['id_antrian_detail'], $get_lab['nomor_antrian'], $get_lab['id_antrian_kategori'],true);
		if (isset($panggil_spec['status']) && $panggil_spec['status']=='ok') {
			$set_lab = $this->model->setAntrianLab($no_lab,$no_bilik);
			$WS = $this->webSocket($panggil_spec['ws']);
			$WS = $this->webSocket($panggil_spec['ws']);
			$WS = $this->webSocket($panggil_spec['ws']);
			$this->model->update7segment();
			return json_encode(['status' => 'success', 'message' => 'Antrian Lab berhasil disimpan.']);
		}
		
		return json_encode(['status' => 'error', 'message' => 'Antrian Lab gagal diupdate']);
	}

	public function selesai() 
	{
		if (!isset($_GET['no_bilik'])) {
			return json_encode(['status' => 'error', 'message' => 'Parameter tidak sesuai.']);
		}
		$set_lab = $this->model->setAntrianSelesai($_GET['no_bilik']);
		if ($set_lab) {
			$this->model->update7segment();
			return json_encode(['status' => 'success', 'message' => 'Antrian Lab diupdate']);
		}
		return json_encode(['status' => 'error', 'message' => 'Antrian Lab gagal diupdate']);
	}

	private function webSocket($messageToSend)
	{
		$client = new \WebSocket\Client("ws://localhost:8080");
		$client->text($messageToSend);
		
		$client->close();
	}
}
