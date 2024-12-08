<?php

include 'template/header.php';

$jumlah_data_perhalaman = 8;
$jumlah_halaman = ceil($jumlah_data = mysqli_num_rows(mysqli_query($koneksi, "SELECT * FROM kost JOIN user ON kost.id_pemilik = user.id")) / $jumlah_data_perhalaman);
if (isset($_GET['halaman'])) {
  $halaman_aktif = $_GET['halaman'];
} else {
  $halaman_aktif = 1;
}

$awalData = ($jumlah_data_perhalaman * $halaman_aktif) - $jumlah_data_perhalaman;

$query = "SELECT * FROM kost  INNER JOIN user ON kost.id_pemilik = user.id LIMIT $awalData,$jumlah_data_perhalaman";

$data = mysqli_query($koneksi, $query);

function minfas($idkost, $tipe_kost)
{
  global $koneksi;
  $cost = mysqli_query($koneksi, "SELECT min(biaya_fasilitas) FROM kamar WHERE id_kost=$idkost");
  $p = mysqli_fetch_array($cost);
  if ($tipe_kost == "Bulan") {
    return $p['min(biaya_fasilitas)'];
  } else if ($tipe_kost == "Tahun") {
    return $p['min(biaya_fasilitas)'] * 12;
  }
}

?>

<style>
  body {
    background-image: url(img/background/bg.jpg);
    background-size: cover;
  }

  .card {
    margin: 2px;
  }

  a {
    text-decoration: none;
    color: black
  }
</style>

<body>
  <div style="color: azure;" class="container">
    <div class="row">
      <p><a href="login.php"><button style="border-radius: 20px" class="btn-primary">Login/Daftar</button>
        </a> Lihat kost Eross disini.</p>

    </div>
    <div class="row">
      <p class="display-4">Kost Eross</p>
      <hr>
    </div>

    <?php
    include "template/footer.php";
    ?>
    .