<?php
require 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;
use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;

class WebSocketServer implements MessageComponentInterface {
    protected $clients;

    public function __construct() {
        $this->clients = new \SplObjectStorage();
    }

    public function onOpen(ConnectionInterface $conn) {
        // Menambahkan klien ke daftar klien yang terhubung
        $this->clients->attach($conn);
        echo "Koneksi baru: {$conn->resourceId}\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        // Mengirim pesan ke semua klien terhubung
        foreach ($this->clients as $client) {
            $client->send($msg);
            echo "Kirim Pesan: {$msg}\n";
        }
    }

    public function onClose(ConnectionInterface $conn) {
        // Menghapus klien dari daftar klien yang terhubung saat koneksi ditutup
        $this->clients->detach($conn);
        echo "Koneksi ditutup: {$conn->resourceId}\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        // Menangani kesalahan koneksi
        echo "Kesalahan: {$e->getMessage()}\n";
        $conn->close();
    }
}

$server = IoServer::factory(
    new HttpServer(
        new WsServer(
            new WebSocketServer()
        )
    ),
    8080
);

$server->run();
