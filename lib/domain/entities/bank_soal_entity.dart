class BankSoalEntity {
  final int id;
  final String soalI;
  final String soalII;
  final String pilihanIA;
  final String pilihanIB;
  final String pilihanIC;
  final String pilihanID;
  final String pilihanIE;
  final String pilihanIIA;
  final String pilihanIIB;
  final String pilihanIIC;
  final String pilihanIID;
  final String pilihanIIE;
  final double nilaiIA;
  final double nilaiIB;
  final double nilaiIC;
  final double nilaiID;
  final double nilaiIE;
  final double nilaiIIA;
  final double nilaiIIB;
  final double nilaiIIC;
  final double nilaiIID;
  final double nilaiIIE;

  BankSoalEntity({
    required this.id,
    required this.soalI,
    required this.soalII,
    required this.pilihanIA,
    required this.pilihanIB,
    required this.pilihanIC,
    required this.pilihanID,
    required this.pilihanIE,
    required this.pilihanIIA,
    required this.pilihanIIB,
    required this.pilihanIIC,
    required this.pilihanIID,
    required this.pilihanIIE,
    required this.nilaiIIA,
    required this.nilaiIIB,
    required this.nilaiIIC,
    required this.nilaiIID,
    required this.nilaiIIE,
    required this.nilaiIA,
    required this.nilaiIB,
    required this.nilaiIC,
    required this.nilaiID,
    required this.nilaiIE,
  });

  double countNilai(int nilaiSoal, int nilaiJawab) {
    final score = nilaiJawab / nilaiSoal;
    return score;
  }
}

List<BankSoalEntity> listSoalEksponensial = [
  BankSoalEntity(
    id: 0,
    soalI:
        r'\(\frac{1}{\sqrt{2} + \sqrt{3}} + \frac{1}{\sqrt{2} + \sqrt{3}} + \frac{1}{\sqrt{2} + \sqrt{3}} + \ldots + \frac{1}{\sqrt{2} + \sqrt{3}} = \sqrt{a} - \sqrt{b}\), maka nilai a + b adalah ...',
    soalII: 'Bagaimana hasil tersebut didapatkan?',
    pilihanIA: '0',
    pilihanIB: '1',
    pilihanIC: '2018',
    pilihanID: '2020',
    pilihanIE: '2022',
    pilihanIIA:
        'Menggunakan pola deret geometri untuk mendapatkan nilai a dan b.',
    pilihanIIB:
        'Mengalikan pembilang dan penyebut dengan bentuk sekawan dari penyebut sehingga nilai a dan b didapatkan.',
    pilihanIIC:
        'Menggunakan pola deret aritmatika untuk mendapatkan nilai a dan b.',
    pilihanIID:
        'Merasionalkan penyebut agar dapat dioperasikan sehingga mendapat nilai a dan b. ',
    pilihanIIE:
        'Merasionalkan pecahan sehingga dapat dioperasikan menggunakan deret aritmatika untuk mendapatkan nilai a dan b.',
    nilaiIIA: 0,
    nilaiIIB: 1,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 1,
  ),
  // BankSoalEntity(
  //   id: 1,
  //   soal:
  //       r'Jika \(x_1\) dan \(x_2\) memenuhi \((^3log(x-5))^2 = 4\), nilai \(\frac{1}{7}\) \(x_1x_2\) = ...',
  //   soalAlasan: r'Berapa nilai \(x_1\) dan \(x_2\)?',
  //   pilihanIA: r'14',
  //   pilihanIB: r'\(\frac{46}{9}\)',
  //   pilihanIC: r'10\(\frac{2}{9}\)',
  //   pilihanID: r'9\(\frac{2}{9}\)',
  //   pilihanIE: r'5',
  //   pilihanIIA: r'14 dan 5\(\frac{1}{9}\)',
  //   pilihanIIB: r'9\(\frac{2}{9}\) dan 5',
  //   pilihanIIC: r'9\(\frac{2}{9}\) dan 14',
  //   pilihanIID: r'9\(\frac{2}{9}\) dan 10\(\frac{2}{9}\)',
  //   pilihanIIE: r'\(\frac{46}{9}\) dan 5',
  //   jawaban:
  //       'Mengalikan pembilang dan penyebut dengan bentuk sekawan dari penyebut sehingga nilai a dan b didapatkan.',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 0,
  //   nilaiIIB: 1,
  //   nilaiIIC: 0.1,
  //   nilaiIID: 0.8,
  //   nilaiIIE: 0.3,
  //   nilaiA: 0,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0,
  //   nilaiE: 1,
  //   nilai: 0,
  // ),
  // BankSoalEntity(
  //   id: 2,
  //   soal:
  //       r'Diketahui \(f:x \to R\)  dengan \(f(4x - 5) = 5^{2x} + 3\)<br> nilai dari \(f^{-1}(128) = ...\)',
  //   soalAlasan: r'Bagaimanakah bentuk dari \(f(x)\)?',
  //   pilihanIA: r'512',
  //   pilihanIB: r'33\(\frac{1}{4}\)',
  //   pilihanIC: r'507',
  //   pilihanID: r'\(\frac{3}{2}\)',
  //   pilihanIE: r'1',
  //   pilihanIIA: r'\(f(x) = 4x - 5\)',
  //   pilihanIIB: r'\(f(x) = \log_{5}(x - 3) - 5\)',
  //   pilihanIIC: r'\(f(x) = 5^\frac{x + 5}{2} + 3\)',
  //   pilihanIID: r'\(f(x) = 5^{2x} - 3\)',
  //   pilihanIIE: r'\(f(x) = 5^\frac{x - 5}{2} + 3\)',
  //   jawaban: '2',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 1,
  //   nilaiIIB: 0,
  //   nilaiIIC: 0,
  //   nilaiIID: 0.2,
  //   nilaiIIE: 0.1,
  //   nilaiA: 1,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0.1,
  //   nilaiE: 0,
  //   nilai: 0,
  // ),
  BankSoalEntity(
    id: 3,
    soalI: r'\(log_3 12 - 3log_3 2 - log_3 \frac{1}{2} = ...\)',
    soalII:
        r'Jika \(log_2 3 = x\) dan \(log_2 5 = y\), maka \(log_{15} 45 = ...\)',
    pilihanIA: r'\(1 - 2log_3 2\)',
    pilihanIB: r'\(1 - log_3 \frac{1}{2}\)',
    pilihanIC: r'1',
    pilihanID: r'\(1 + 3log_3 3\)',
    pilihanIE: r'\(1 + 2log_3 2\)',
    pilihanIIA: r'\(\frac{x + y}{x + 2y}\)',
    pilihanIIB: r'\(\frac{x - 2y}{x + y}\)',
    pilihanIIC: r'\(\frac{2x - y}{x - 2y}\)',
    pilihanIID: r'\(\frac{2x + y}{x + y}\)',
    pilihanIIE: r'\(\frac{x - y}{x + y}\)',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 1,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 1,
    nilaiID: 0,
    nilaiIE: 0,
  ),
  BankSoalEntity(
    id: 4,
    soalI:
        r'Pada bulan Maret 2020, kasus positif COVID-19 berjumlah kurang lebih 36 juta jiwa. Jumlah ini meningkat rata-rata 10% setiap bulan dari bulan Desember 2019 hingga bulan Maret 2020. Jika peningkatan kasus positif COVID-19 di bulan-bulan berikutnya diprediksi bertambah secara eksponen pada peningkatan 10% setiap bulan, berapa banyak kasus yang terjadi pada bulan Juni 2020?',
    soalII: r'Berapa jumlah kasus pada Desember 2019?',
    pilihanIA: r'47,96 Juta',
    pilihanIB: r'47,16 Juta',
    pilihanIC: r'49,16 Juta',
    pilihanID: r'46,91 Juta',
    pilihanIE: r'47,91 Juta',
    pilihanIIA: r'27,04 Juta',
    pilihanIIB: r'24,06 Juta',
    pilihanIIC: r'24,04 Juta',
    pilihanIID: r'28,06 Juta',
    pilihanIIE: r'27,06 Juta',
    nilaiIIA: 1,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 1,
  ),
];

List<BankSoalEntity> listSoalSPLTV = [
  BankSoalEntity(
    id: 0,
    soalI:
        r'Pada hari ulang tahun HMD (Himpunan Mahasiswa Departemen) Matematika Vektor, bupati mengajak 60 pengurusnya untuk makan bersama di rumah makan Latansa. Terdapat berbagai paket menu pilihan antara lain Paket A dengan harga Rp 23.000 yang berisi satu gelas es teh jumbo dan dua potong ayam krispi. Selanjutnya ada Paket B dengan harga Rp 22.000 yang berisi satu gelas es teh jumbo dan tiga porsi Jamur Krispi. Paket ketiga adalah paket C dengan harga Rp 20.000 yang berisi satu gelas es teh jumbo, satu potong ayam, dan satu porsi jamur krispi. Item pada menu dijual Rp 1.000 lebih mahal dari harga aslinya jika melakukan pembelian di luar paket. Jika harga dasar dari es teh jumbo dan jamur krispi 10% lebih murah dari harga aslinya sedangkan harga dasar ayam krispi 20% lebih murah dari harga aslinya, berapakah keuntungan Latansa setelah setiap pengurus memesan Paket C?',
    soalII:
        'Bupati ingin membelikan makanan dan minuman dari Latansa untuk keluarganya di rumah dengan budget Rp 52.000. Bupati ingin memaksimalkan budget yang dimilikinya. Jika harga ayam krispi, jamur krispi, dan es teh jumbo secara berturut-turut dimisalkan x, z, dan y, apa saja yang dapat dibeli oleh bupati untuk pembelian non-paket?',
    pilihanIA: 'Rp 162.000',
    pilihanIB: 'Rp 164.700',
    pilihanIC: 'Rp 170.800',
    pilihanID: 'Rp 150.000',
    pilihanIE: 'Rp 168.000',
    pilihanIIA: r'\(f(x,y,z) = 2x + 3y + 3z\)',
    pilihanIIB: r'\(f(x,z) = 3x + 4z\)',
    pilihanIIC: r'\(f(x,z) = 4x + 4z\)',
    pilihanIID: r'\(f(y,z) = 4y + 3z\)',
    pilihanIIE: r'\(f(x,y,z) = 2x + 3y + 2z\)',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 1,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 1,
    nilaiID: 0,
    nilaiIE: 0,
  ),
  // BankSoalEntity(
  //   id: 1,
  //   soal:
  //       r'Jika \(x_1\) dan \(x_2\) memenuhi \((^3log(x-5))^2 = 4\), nilai \(\frac{1}{7}\) \(x_1x_2\) = ...',
  //   soalAlasan: r'Berapa nilai \(x_1\) dan \(x_2\)?',
  //   pilihanIA: r'14',
  //   pilihanIB: r'\(\frac{46}{9}\)',
  //   pilihanIC: r'10\(\frac{2}{9}\)',
  //   pilihanID: r'9\(\frac{2}{9}\)',
  //   pilihanIE: r'5',
  //   pilihanIIA: r'14 dan 5\(\frac{1}{9}\)',
  //   pilihanIIB: r'9\(\frac{2}{9}\) dan 5',
  //   pilihanIIC: r'9\(\frac{2}{9}\) dan 14',
  //   pilihanIID: r'9\(\frac{2}{9}\) dan 10\(\frac{2}{9}\)',
  //   pilihanIIE: r'\(\frac{46}{9}\) dan 5',
  //   jawaban:
  //       'Mengalikan pembilang dan penyebut dengan bentuk sekawan dari penyebut sehingga nilai a dan b didapatkan.',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 0,
  //   nilaiIIB: 1,
  //   nilaiIIC: 0.1,
  //   nilaiIID: 0.8,
  //   nilaiIIE: 0.3,
  //   nilaiA: 0,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0,
  //   nilaiE: 1,
  //   nilai: 0,
  // ),
  // BankSoalEntity(
  //   id: 2,
  //   soal:
  //       r'Diketahui \(f:x \to R\)  dengan \(f(4x - 5) = 5^{2x} + 3\)<br> nilai dari \(f^{-1}(128) = ...\)',
  //   soalAlasan: r'Bagaimanakah bentuk dari \(f(x)\)?',
  //   pilihanIA: r'512',
  //   pilihanIB: r'33\(\frac{1}{4}\)',
  //   pilihanIC: r'507',
  //   pilihanID: r'\(\frac{3}{2}\)',
  //   pilihanIE: r'1',
  //   pilihanIIA: r'\(f(x) = 4x - 5\)',
  //   pilihanIIB: r'\(f(x) = \log_{5}(x - 3) - 5\)',
  //   pilihanIIC: r'\(f(x) = 5^\frac{x + 5}{2} + 3\)',
  //   pilihanIID: r'\(f(x) = 5^{2x} - 3\)',
  //   pilihanIIE: r'\(f(x) = 5^\frac{x - 5}{2} + 3\)',
  //   jawaban: '2',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 1,
  //   nilaiIIB: 0,
  //   nilaiIIC: 0,
  //   nilaiIID: 0.2,
  //   nilaiIIE: 0.1,
  //   nilaiA: 1,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0.1,
  //   nilaiE: 0,
  //   nilai: 0,
  // ),
  BankSoalEntity(
    id: 3,
    soalI:
        r'Kota Batu merupakan kota yang dijuluki sebagai kota wisata karena memiliki banyak destinasi wisata. Pandu ingin mengajak ketiga temannya Sigap, Ferdi, dan Riky yang berasal dari luar kota untuk berwisata ke Kota Batu. Sepulangnya, mereka menghampiri pusat oleh-oleh. Pandu membeli sepertiga lusin botol susu KUD Batu, 3 kg apel, dan sebungkus keripik pisang dengan total harga Rp 65.500. Sigap membeli seperempat lusin botol susu KUD Batu dan 7 bungkus keripik kentang dengan total harga Rp 82.000. Ferdi membeli 4 kg apel dan 3 bungkus keripik kentang dengan harga Rp 61.500. Jika harga semua keripik sama, berapa uang yang harus Riky bayar untuk membeli 5 botol susu KUD Batu, 2 kg apel, dan sebungkus keripik pisang?',
    soalII:
        r'Jika harga sebotol susu KUD Batu, 1 kg apel, dan sebungkus keripik pisang berturut-turut dimisalkan x,y, dan z, berapakah x,z, dan y nya?',
    pilihanIA: r'Rp 56.000',
    pilihanIB: r'Rp 64.000',
    pilihanIC: r'Rp 68.500',
    pilihanID: r'Rp 68.000',
    pilihanIE: r'Rp 64.500',
    pilihanIIA: r'Rp. 7.500, Rp. 9.000, dan Rp. 8.500',
    pilihanIIB: r'Rp. 7.500, Rp. 8.500, dan Rp. 9.000',
    pilihanIIC: r'Rp. 8.500, Rp. 7.500, dan Rp. 9.000',
    pilihanIID: r'Rp. 9.000, Rp. 8.500, dan Rp. 7.500',
    pilihanIIE: r'Rp. 8.500, Rp. 9.000, dan Rp. 7.500',
    nilaiIIA: 0,
    nilaiIIB: 1,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 1,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 0,
  ),
  BankSoalEntity(
    id: 4,
    soalI:
        r'Pasar Sayur adalah salah satu pasar yang ikonik di Kota Batu. Salah satu daya tarik Pasar Sayur adalah keakraban dan keramahan para pedagang disana. Setiap akhir pekan, para pedagang berkumpul untuk menghitung keuntungan di hari itu. Pada suatu sabtu tiga pedagang berkumpul untuk menghitung keuntungan mereka dalam satuan juta. Jumlah keuntungan pedagang sayur, pedagang ikan, dan pedagang ayam setara dengan empat kali keuntungan pedagang sayur. Keuntungan pedagang sayur tiga juta lebih tinggi daripada dua kali keuntungan pedagang ikan. Keuntungan pedagang ikan 21 juta lebih rendah dari lima kali keuntungan pedagang ayam. Manakah keuntungan paling tinggi?',
    soalII: r'Berapa total keuntungan normal ketiga pedagang tersebut?',
    pilihanIA:
        r'Keuntungan normal pedagang sayur, keuntungan normal pedagang ayam, dan empat kali keuntungan pedagang ikan',
    pilihanIB:
        r'Tujuh kali keuntungan pedagang ikan dikurang keuntungan normal pedagang ayam',
    pilihanIC:
        r'Keuntungan normal pedagang ayam dan dua kali keuntungan pedagang ikan',
    pilihanID:
        r'Tiga kali keuntungan pedagang sayur dan dua kali keuntungan pedagang ikan',
    pilihanIE:
        r'Dua kali keuntungan pedagang ayam dan keuntungan normal pedagang sayur, dikurang empat kali keuntungan pedagang ikan',
    pilihanIIA: r'Rp 7.000.000',
    pilihanIIB: r'Rp 3.000.000',
    pilihanIIC: r'Rp 6.000.000',
    pilihanIID: r'Rp 2.000.000',
    pilihanIIE: r'Rp 4.000.000',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 1,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 1,
  ),
];

List<BankSoalEntity> listSoalFungsi = [
  BankSoalEntity(
    id: 4,
    soalI:
        r'Diketahui ordinat titik puncak fungsi kuadrat<br>\(f(x) = ax^2 + bx + c\) adalah \(-32\).<br>Jika \(f(3) = f(-5) = 0\), nilai \(a + b + c = ...\)',
    soalII:
        r'Tentukan secara berturut-turut apakah grafik tersebut terbuka ke atas atau ke bawah,<br> menyinggung sumbu x atau tidak, dan berapakah titik puncaknya?',
    pilihanIA: r'-30',
    pilihanIB: r'30',
    pilihanIC: r'26',
    pilihanID: r'-26',
    pilihanIE: r'-24',
    pilihanIIA:
        r'Grafik terbuka ke bawah, tidak menyinggung sumbu x, dan memiliki titik puncak (1, 32)',
    pilihanIIB:
        r'Grafik terbuka ke atas, menyinggung sumbu x, dan memiliki titik puncak (1, -32)',
    pilihanIIC:
        r'Grafik terbuka ke bawah, menyinggung sumbu x, dan memiliki titik puncak (1, -32)',
    pilihanIID:
        r'Grafik terbuka ke atas,  menyinggung sumbu x, dan memiliki titik puncak (-1, -32)',
    pilihanIIE:
        r'Grafik terbuka ke atas, tidak menyinggung sumbu x, dan memiliki titik puncak (1, 32) ',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 1,
    nilaiIIE: 0,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 1,
  ),
  BankSoalEntity(
    id: 0,
    soalI:
        r'Diketahui \(f:x \to R\) dengan \(f(4x - 5) = 5^{2x} + 3\), nilai dari \(f^(-1) (128) = ...\)',
    soalII: r'Bagaimana bentuk dari \(f(x)\)?',
    pilihanIA: '512',
    pilihanIB: r'\(33 \frac{1}{4}\)',
    pilihanIC: '507',
    pilihanID: r'\(\frac{3}{7}\)',
    pilihanIE: '1',
    pilihanIIA: r'\(f(x) = 5^{\frac{x - 5}{2}} + 3\)',
    pilihanIIB: r'\(f(x) = 4x - 5\)',
    pilihanIIC: r'\(f(x) = 5^{2x} - 3\)',
    pilihanIID: r'\(f(x) = 5^{2x} + 3\)',
    pilihanIIE: r'\(f(x) = 5^{\frac{x + 5}{2}} + 3\)',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 1,
    nilaiIA: 0,
    nilaiIB: 0,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 1,
  ),
  // BankSoalEntity(
  //   id: 1,
  //   soal:
  //       r'Jika \(x_1\) dan \(x_2\) memenuhi \((^3log(x-5))^2 = 4\), nilai \(\frac{1}{7}\) \(x_1x_2\) = ...',
  //   soalAlasan: r'Berapa nilai \(x_1\) dan \(x_2\)?',
  //   pilihanIA: r'14',
  //   pilihanIB: r'\(\frac{46}{9}\)',
  //   pilihanIC: r'10\(\frac{2}{9}\)',
  //   pilihanID: r'9\(\frac{2}{9}\)',
  //   pilihanIE: r'5',
  //   pilihanIIA: r'14 dan 5\(\frac{1}{9}\)',
  //   pilihanIIB: r'9\(\frac{2}{9}\) dan 5',
  //   pilihanIIC: r'9\(\frac{2}{9}\) dan 14',
  //   pilihanIID: r'9\(\frac{2}{9}\) dan 10\(\frac{2}{9}\)',
  //   pilihanIIE: r'\(\frac{46}{9}\) dan 5',
  //   jawaban:
  //       'Mengalikan pembilang dan penyebut dengan bentuk sekawan dari penyebut sehingga nilai a dan b didapatkan.',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 0,
  //   nilaiIIB: 1,
  //   nilaiIIC: 0.1,
  //   nilaiIID: 0.8,
  //   nilaiIIE: 0.3,
  //   nilaiA: 0,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0,
  //   nilaiE: 1,
  //   nilai: 0,
  // ),
  // BankSoalEntity(
  //   id: 2,
  //   soal:
  //       r'Diketahui \(f:x \to R\)  dengan \(f(4x - 5) = 5^{2x} + 3\)<br> nilai dari \(f^{-1}(128) = ...\)',
  //   soalAlasan: r'Bagaimanakah bentuk dari \(f(x)\)?',
  //   pilihanIA: r'512',
  //   pilihanIB: r'33\(\frac{1}{4}\)',
  //   pilihanIC: r'507',
  //   pilihanID: r'\(\frac{3}{2}\)',
  //   pilihanIE: r'1',
  //   pilihanIIA: r'\(f(x) = 4x - 5\)',
  //   pilihanIIB: r'\(f(x) = \log_{5}(x - 3) - 5\)',
  //   pilihanIIC: r'\(f(x) = 5^\frac{x + 5}{2} + 3\)',
  //   pilihanIID: r'\(f(x) = 5^{2x} - 3\)',
  //   pilihanIIE: r'\(f(x) = 5^\frac{x - 5}{2} + 3\)',
  //   jawaban: '2',
  //   pilihanII: 'Penjumlahan satu angka setelah 1 adalah 2',
  //   nilaiIIA: 1,
  //   nilaiIIB: 0,
  //   nilaiIIC: 0,
  //   nilaiIID: 0.2,
  //   nilaiIIE: 0.1,
  //   nilaiA: 1,
  //   nilaiB: 0,
  //   nilaiC: 0.4,
  //   nilaiD: 0.1,
  //   nilaiE: 0,
  //   nilai: 0,
  // ),
  BankSoalEntity(
    id: 3,
    soalI:
        r'Suatu pabrik kertas berbahan dasar kayu memproduksi kertas melalui dua tahap. Tahap pertama menggunakan mesin I yang menghasilkan bahan kertas setengah jadi, dan tahap kedua menggunakan mesin II yang menghasilkan bahan kertas. Dalam produksinya, mesin I dengan mengikuti fungsi \(f(x) = 4x - 5\) dan mesin II mengikuti fungsi \(g(x) = x^2 + 3x\), x merupakan banyak bahan dasar kayu dalam satuan ton. Jika bahan setengah jadi untuk kertas yang dihasilkan oleh mesin I sebesar 115 ton, berapa tonkah kayu yang sudah terpakai?',
    soalII: r'Berapa banyak kertas yang dihasilkan?',
    pilihanIA: r'300.000 kg',
    pilihanIB: r'30.000 kg',
    pilihanIC: r'30 kg',
    pilihanID: r'300 kg',
    pilihanIE: r'3.000 kg',
    pilihanIIA: r'17.550 lembar',
    pilihanIIB: r'15.730 lembar',
    pilihanIIC: r'15.370 lembar',
    pilihanIID: r'13.750 lembar',
    pilihanIIE: r'13.570 lembar',
    nilaiIIA: 0,
    nilaiIIB: 0,
    nilaiIIC: 0,
    nilaiIID: 0,
    nilaiIIE: 1,
    nilaiIA: 0,
    nilaiIB: 1,
    nilaiIC: 0,
    nilaiID: 0,
    nilaiIE: 0,
  ),
];
