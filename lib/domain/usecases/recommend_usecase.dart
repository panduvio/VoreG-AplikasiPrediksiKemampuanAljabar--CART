class RecomendUsecase {
  String recommend(String nama, String bidang, String label) {
    String recommendation = '';
    if (bidang == 'eksponensial') {
      if (label == 'kurang') {
        recommendation =
            'Kemampuan eksponensial dan logaritma $nama perlu ditingkatkan lagi. $nama dapat melakukan literasi pada modul atau buku paket yang disediakan sekolah terutama pada sifat-sifat eksponensial dan logaritma. ';
      } else if (label == 'sedang') {
        recommendation =
            'Kemampuan eksponensial dan logaritma $nama cukup baik. $nama disarankan untuk memperbanyak Latihan soal agar semakin terbiasa menghadapi permasalahan eksponensial dan logaritma. ';
      } else {
        recommendation =
            'Kemampuan eksponensial dan logaritma $nama sangat baik. $nama disarankan untuk mengeksplorasi Latihan soal di luar buku ajar sekolah secara mandiri untuk mempertajam kemampuan eksponensial dan logaritma (Soal tipe HOTS direkomendasikan) ';
      }
    } else if (bidang == 'spltv') {
      if (label == 'kurang') {
        recommendation =
            'Kemampuan SPLTV $nama masih perlu ditingkatkan. $nama disarankan untuk belajar memodelkan sistem persamaan linear pada sebuah kasus soal sehingga dapat menentukan variabel apa saja yang diperlukan dalam menyelesaikan persoalan yang dimaksud. ';
      } else if (label == 'sedang') {
        recommendation =
            'Kemampuan SPLTV $nama cukup baik. $nama disarankan menguatkan pemahaman pada sistem persamaan linear tiga variabel baik dengan literasi ataupun Latihan soal sehingga di kelas berikutnya $nama tidak kesulitan dalam menyelesaikan SPL dengan matriks ';
      } else {
        recommendation =
            'Kemampuan SPLTV $nama sangat baik. $nama dapat melakukan eksplorasi lebih jauh tentang SPLTV seperti mencari tahu apakah setiap sistem persamaan linear memiliki penyelesaian beserta alasannya. Setelah itu $nama dapat mendiskusikannya dengan guru. ';
      }
    } else if (bidang == 'fungsi') {
      if (label == 'kurang') {
        recommendation =
            'Kemampuan Fungsi $nama masih perlu ditingkatkan. $nama dapat memahami kembali karakteristik fungsi. Jangan ragu untuk bertanya kepada guru tentang hal yang kurang dipahami. ';
      } else if (label == 'sedang') {
        recommendation =
            'Kemampuan Fungsi $nama sudah cukup baik. $nama dapat meningkatkan kemampuan dengan mengerjakan latihan soal baik pada buku paket sekolah maupun bank soal lainnya. ';
      } else {
        'Kemampuan Fungsi $nama sangat baik. $nama disarankan untuk melakukan eksplorasi tentang Fungsi lebih jauh seperti dengan mengeksplorasi aplikasi GeoGebra dan Microsoft Excel untuk menggambarkan bentuk-bentuk fungsi. ';
      }
    } else {
      if (label == 'kurang') {
        recommendation =
            'Kemampuan Aljabar $nama sesuai prediksi sistem masih kurang. $nama dapat meningkatkan kemampuan dengan sering membaca atau menulis ulang materi yang telah diajarkan. $nama dapat melakukan konsultasi dengan guru jika perlu.';
      } else if (label == 'sedang') {
        recommendation =
            'Kemampuan Aljabar $nama sesuai prediksi sistem cukup baik. $nama dapat mengulas materi-materi yang pernah dipelajari lalu mengaplikasikannya pada latihan soal.';
      } else {
        recommendation =
            'Kemampuan Aljabar $nama sesuai prediksi sistem sangat baik. $nama dapat melakukan eksplorasi secara mandiri dengan melakukan latihan soal di luar pembelajaran sekolah agar kemampuan aljabar semakin terasah. $nama juga dapat berdiskusi dengan teman yang merasa kurang dalam pemahaman materi-materi yang berkaitan dengan aljabar sehingga $nama juga akan semakin terbiasa dengan aljabar.';
      }
    }

    return recommendation;
  }
}
