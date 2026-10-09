import '../models/question.dart';

final List<Question> questionsData = [
  Question(
    id: 'earth-stop-rotating',
    title: 'What if Earth stopped rotating?',
    category: 'Earth',
    imagePath: 'assets/images/earth_stop_rotating.jpg',
    shortAnswer:
        'Bumi berputar sekitar 1.600 km/jam di ekuator. Kalau itu berhenti mendadak, efeknya jauh lebih ekstrem daripada sekadar "hari jadi lebih panjang".',
    dimensions: {
      'Biology':
          'Momentum yang tersimpan di tubuh manusia dan segala sesuatu di permukaan Bumi akan terus bergerak ke arah putaran Bumi sebelumnya efeknya mirip tabrakan kecepatan tinggi.',
      'Society':
          'Sistem waktu, jadwal, dan ritme hidup manusia yang berdasarkan siang-malam akan runtuh total. Setengah dunia gelap permanen, setengah lagi terang permanen.',
      'Economy':
          'Pertanian di sisi gelap permanen akan gagal total karena nggak ada fotosintesis, memicu krisis pangan global.',
      'Technology':
          'Satelit yang mengorbit dengan asumsi rotasi Bumi akan kehilangan kalibrasi, GPS dan komunikasi global terganggu.',
      'Environment':
          'Perbedaan suhu ekstrem antara sisi terang dan gelap akan memicu angin super kencang di garis batas keduanya.',
      'Unexpected Consequences':
          'Medan magnet Bumi (yang dihasilkan dari rotasi inti besi cair) bisa melemah drastis, mengurangi perlindungan dari radiasi matahari.',
    },
    timeline: [
      const TimelineStage(
          label: '0 Detik', description: 'Semua benda yang tidak terikat ke tanah terlempar ke arah timur akibat momentum.'),
      const TimelineStage(
          label: '1 Menit', description: 'Gelombang tsunami raksasa terbentuk karena air laut juga punya momentum yang sama.'),
      const TimelineStage(
          label: '1 Hari', description: 'Setengah dunia mulai kedinginan ekstrem, setengah lagi kepanasan ekstrem.'),
      const TimelineStage(
          label: '1 Tahun', description: 'Ekosistem sisi gelap runtuh total, migrasi massal manusia ke zona "terminator" (garis batas terang-gelap).'),
    ],
    relatedQuestionIds: ['gravity-disappear', 'moon-disappear'],
  ),

  Question(
    id: 'humans-no-sleep',
    title: 'What if humans never needed sleep?',
    category: 'Human',
    imagePath: 'assets/images/humans_no_sleep.jpg',
    shortAnswer:
        'Manusia menghabiskan sekitar sepertiga hidupnya buat tidur. Kalau kebutuhan itu hilang, bukan cuma soal "waktu ekstra"  seluruh struktur sosial ikut berubah.',
    dimensions: {
      'Biology':
          'Tidur bukan cuma istirahat, tapi proses konsolidasi memori dan pembersihan racun di otak. Tanpa itu, tubuh perlu mekanisme biologis baru buat fungsi yang sama.',
      'Society':
          'Konsep "hari kerja" dan "waktu istirahat" jadi nggak relevan. Kota-kota beroperasi 24 jam penuh tanpa jeda alami.',
      'Economy':
          'Produktivitas manusia berpotensi naik drastis, tapi juga membuka risiko eksploitasi tenaga kerja karena nggak ada alasan biologis buat berhenti kerja.',
      'Technology':
          'Industri yang bergantung pada "downtime" manusia (hotel, kasur, obat tidur) runtuh; muncul industri baru buat mengisi 8 jam ekstra tadi.',
      'Environment':
          'Konsumsi energi listrik meningkat karena aktivitas manusia 24 jam tanpa jeda malam.',
      'Unexpected Consequences':
          'Kesehatan mental mungkin memburuk karena hilangnya "waktu jeda" alami dari tekanan sosial  mimpi dan tidur ternyata berperan penting soal itu.',
    },
    timeline: [
      const TimelineStage(
          label: 'Hari 1', description: 'Manusia punya 8 jam ekstra setiap hari, awalnya dipakai buat hobi dan produktivitas.'),
      const TimelineStage(
          label: 'Tahun 1', description: 'Pola kerja mulai bergeser jadi shift 24 jam tanpa jeda, kompetisi kerja makin ketat.'),
      const TimelineStage(
          label: 'Tahun 10', description: 'Struktur sosial berubah drastis  "malam" nggak lagi punya makna khusus sebagai waktu istirahat.'),
      const TimelineStage(
          label: 'Tahun 50', description: 'Muncul generasi yang nggak pernah tau konsep "mimpi", budaya dan seni yang terinspirasi dari mimpi ikut hilang.'),
    ],
    relatedQuestionIds: ['read-minds', 'ai-smarter'],
  ),

  Question(
    id: 'moon-disappear',
    title: 'What if the Moon disappeared?',
    category: 'Space',
    imagePath: 'assets/images/moon_disappear.jpg',
    shortAnswer:
        'Bulan bukan cuma "pemandangan malam"  dia menstabilkan kemiringan sumbu Bumi dan mengatur pasang surut laut.',
    dimensions: {
      'Biology':
          'Banyak spesies laut yang siklus hidupnya bergantung pada pasang surut (misal kepiting, terumbu karang) akan kehilangan sinyal biologis utamanya.',
      'Society':
          'Kalender, budaya, dan bahkan agama yang berbasis siklus bulan akan kehilangan acuannya.',
      'Economy':
          'Industri perikanan pesisir yang bergantung pola pasang surut terganggu drastis.',
      'Technology':
          'Navigasi laut tradisional dan beberapa sistem satelit yang menggunakan Bulan sebagai referensi jarak akan perlu dikalibrasi ulang.',
      'Environment':
          'Tanpa gaya tarik Bulan, kemiringan sumbu Bumi (23.5°) bisa jadi nggak stabil dalam jangka sangat panjang, berpotensi mengacaukan musim.',
      'Unexpected Consequences':
          'Malam jadi jauh lebih gelap tanpa cahaya pantulan Bulan, mengubah perilaku hewan nokturnal secara global.',
    },
    timeline: [
      const TimelineStage(label: 'Hari 1', description: 'Pasang surut laut langsung melemah drastis, hanya dipengaruhi matahari.'),
      const TimelineStage(label: 'Tahun 1', description: 'Spesies laut pesisir mulai terganggu siklus reproduksinya.'),
      const TimelineStage(label: 'Abad 1', description: 'Perubahan iklim mikro di area pesisir mulai terasa akibat pola pasang surut baru.'),
    ],
    relatedQuestionIds: ['earth-stop-rotating'],
  ),

  Question(
    id: 'gravity-disappear',
    title: 'What if gravity disappeared for 5 seconds?',
    category: 'Earth',
    imagePath: 'assets/images/gravity_disappear.jpg',
    shortAnswer: 
        'Selama 5 detik tanpa gravitasi, manusia, benda, air, dan udara akan kehilangan gaya yang menariknya ke permukaan Bumi. Semuanya akan menjadi weightless dan mulai bergerak mengikuti momentum masing-masing. Saat gravitasi kembali, benda-benda tersebut akan jatuh kembali ke permukaan.',
    dimensions: {
      'Biology': 
          'Manusia dan hewan akan kehilangan berat badan sementara, sehingga sulit menjaga posisi dan keseimbangan. Cairan tubuh juga akan mengalami perubahan distribusi karena tidak lagi ditarik ke bawah oleh gravitasi.',
      'Society':
          'Orang-orang akan kehilangan pijakan dan benda-benda di sekitar bisa melayang atau bergerak. Saat gravitasi kembali, benda yang berpindah dapat menyebabkan kecelakaan dan kerusakan.',
      'Economy':
          'Transportasi, pabrik, pertanian, dan berbagai aktivitas bisnis bisa terganggu. Kerusakan pada kendaraan, mesin, dan infrastruktur juga dapat menimbulkan kerugian besar.',
      'Technology':
          'Mesin dan sistem yang bergantung pada gravitasi dapat mengalami gangguan. Kendaraan, sistem pompa, dan berbagai peralatan yang biasanya bekerja dengan arah "atas-bawah" akan beroperasi secara tidak normal.',
      'Environment':
          'Air, tanah, debu, dan atmosfer akan ikut terdampak karena tidak ada gaya gravitasi yang menariknya ke bawah. Ketika gravitasi kembali, material yang sempat berpindah dapat jatuh dan menyebabkan banjir atau debris.',
      'Unexpected Consequences':
          'Benda tidak akan langsung berhenti di tempat. Karena inertia, benda yang sedang bergerak akan tetap bergerak meskipun gravitasi hilang. Saat gravitasi kembali, benda-benda tersebut bisa jatuh dari posisi yang berbeda dan saling bertabrakan.',
    },
    timeline: [
      const TimelineStage(label: '1 Detik', description: 'Semua benda menjadi weightless. Orang, benda kecil, dan air mulai kehilangan pijakan serta bergerak mengikuti momentum masing-masing.'),
      const TimelineStage(label: '2 Detik', description: 'Benda yang tidak terikat mulai melayang atau bergeser dari tempatnya. Manusia akan kesulitan mempertahankan posisi tubuh.'),
      const TimelineStage(label: '3 Detik', description: 'Air, debu, dan benda-benda ringan semakin banyak berpindah. Kendaraan dan mesin tertentu mulai mengalami gangguan karena tidak adanya gravitasi.'),
      const TimelineStage(label: '4 Detik', description: 'Gangguan semakin terlihat di berbagai tempat. Benda-benda terus bergerak tanpa gaya yang menariknya kembali ke permukaan Bumi.'),
      const TimelineStage(label: '5 Detik', description: 'Gravitasi tiba-tiba kembali. Orang, air, dan benda yang sempat berpindah akan jatuh kembali ke permukaan dan dapat menyebabkan benturan serta kerusakan.'),
    ],
    relatedQuestionIds: ['earth-stop-rotating'],
  ),

    Question(
    id: 'read-minds',
    title: 'What if humans could read minds?',
    category: 'Mind',
    imagePath: 'assets/images/read_minds.jpg',
    shortAnswer:
        'Jika manusia bisa membaca pikiran, komunikasi akan berubah drastis karena pikiran yang biasanya bersifat pribadi dapat diketahui orang lain. Kemampuan ini bisa membantu memahami satu sama lain, tetapi juga menimbulkan masalah besar tentang privacy, trust, dan batas antara pikiran pribadi dengan kehidupan sosial.',
    dimensions: {
      'Biology':
          'Otak harus mampu menangkap dan menerjemahkan aktivitas mental orang lain. Hal ini juga bisa membuat manusia lebih sensitif terhadap pikiran dan emosi di sekitarnya.',
      'Society':
          'Hubungan sosial akan berubah karena sulit menyembunyikan pikiran. Trust bisa menjadi lebih rumit karena orang tidak lagi hanya menilai perkataan, tetapi juga mengetahui apa yang sebenarnya dipikirkan.',
      'Economy':
          'Profesi seperti negosiasi, marketing, hukum, dan keamanan dapat berubah besar karena informasi dari pikiran seseorang memiliki nilai ekonomi yang tinggi.',
      'Technology':
          'Teknologi untuk mendeteksi dan menerjemahkan aktivitas otak akan berkembang pesat. Perangkat brain-computer interface mungkin menjadi bagian penting dalam kehidupan sehari-hari.',
      'Environment':
          'Dampak langsung terhadap lingkungan mungkin kecil, tetapi perubahan kebutuhan teknologi dan infrastruktur untuk membaca pikiran dapat meningkatkan penggunaan energi dan sumber daya.',
      'Unexpected Consequences':
          'Pikiran yang biasanya tidak pernah diucapkan bisa diketahui orang lain. Bahkan pikiran spontan atau imajinasi yang tidak mencerminkan keinginan sebenarnya dapat menyebabkan salah paham.',
    },
    timeline: [
      const TimelineStage(
        label: 'Hari 1',
        description:
            'Manusia mulai menyadari bahwa mereka dapat mengetahui pikiran orang lain. Komunikasi langsung menjadi jauh lebih mudah, tetapi privacy segera menjadi masalah besar.',
      ),
      const TimelineStage(
        label: 'Minggu 1',
        description:
            'Orang mulai mencari cara untuk mengatur kapan kemampuan membaca pikiran boleh digunakan. Konflik sosial muncul karena tidak semua orang nyaman pikirannya diketahui.',
      ),
      const TimelineStage(
        label: 'Tahun 1',
        description:
            'Pemerintah, sekolah, perusahaan, dan hukum mulai membuat aturan tentang penggunaan kemampuan membaca pikiran dan perlindungan terhadap pikiran pribadi.',
      ),
    ],
    relatedQuestionIds: ['humans-no-sleep'],
  ),

  Question(
    id: 'dinosaurs-alive',
    title: 'What if dinosaurs never went extinct?',
    category: 'Earth',
    imagePath: 'assets/images/dinosaurs_alive.jpg',
    shortAnswer:
        'Jika dinosaurus tidak pernah punah, evolusi kehidupan di Bumi akan berjalan sangat berbeda. Mamalia mungkin tidak menjadi kelompok dominan seperti sekarang, dan manusia mungkin tidak pernah muncul dalam bentuk yang sama.',
    dimensions: {
      'Biology':
          'Dinosaurus akan terus berevolusi selama jutaan tahun. Beberapa spesies mungkin menjadi lebih kecil, lebih cerdas, atau beradaptasi dengan lingkungan yang terus berubah.',
      'Society':
          'Jika manusia tetap berevolusi, kehidupan masyarakat harus beradaptasi dengan keberadaan hewan besar yang hidup di berbagai ekosistem. Pemukiman dan aktivitas manusia mungkin memiliki batas wilayah yang berbeda.',
      'Economy':
          'Industri seperti peternakan, pertanian, pariwisata, dan transportasi akan berkembang dengan mempertimbangkan keberadaan dinosaurus. Beberapa spesies bahkan mungkin menjadi bagian dari industri wildlife tourism.',
      'Technology':
          'Teknologi pertahanan, transportasi, dan pemantauan satwa kemungkinan berkembang untuk menghadapi hewan berukuran besar. Kota juga mungkin dirancang dengan sistem perlindungan tambahan.',
      'Environment':
          'Dinosaurus akan menjadi bagian penting dari rantai makanan. Keberadaan mereka dapat membentuk ekosistem, pola vegetasi, dan persebaran spesies yang sangat berbeda dari Bumi saat ini.',
      'Unexpected Consequences':
          'Tidak ada jaminan manusia akan menjadi spesies dominan. Bisa saja evolusi menghasilkan dunia dengan kecerdasan dan bentuk kehidupan yang sangat berbeda dari yang kita kenal sekarang.',
    },
    timeline: [
      const TimelineStage(
        label: 'Jutaan Tahun Lalu',
        description:
            'Dinosaurus terus berevolusi dan mengisi berbagai ecological niches tanpa mengalami kepunahan massal seperti yang terjadi dalam sejarah sebenarnya.',
      ),
      const TimelineStage(
        label: 'Ratusan Ribu Tahun Lalu',
        description:
            'Ekosistem Bumi menjadi semakin berbeda. Mamalia dan dinosaurus harus berbagi habitat serta bersaing mendapatkan makanan dan wilayah.',
      ),
      const TimelineStage(
        label: 'Sekarang',
        description:
            'Bumi memiliki ekosistem yang sangat berbeda. Jika manusia juga berevolusi, kehidupan modern harus beradaptasi dengan keberadaan dinosaurus sebagai bagian dari alam.',
      ),
    ],
    relatedQuestionIds: [],
  ),

  Question(
    id: 'breathe-underwater',
    title: 'What if humans could breathe underwater?',
    category: 'Human',
    imagePath: 'assets/images/breathe_underwater.jpg',
    shortAnswer:
        'Jika manusia bisa bernapas di bawah air, lautan akan menjadi ruang hidup dan eksplorasi baru. Manusia dapat bekerja dan tinggal lebih lama di bawah laut tanpa scuba gear, tetapi perubahan ini juga akan memengaruhi industri, lingkungan, dan cara manusia melihat wilayah laut.',
    dimensions: {
      'Biology':
          'Tubuh manusia harus memiliki mekanisme untuk mengambil oxygen terlarut dari air. Adaptasi tersebut dapat membuat manusia mampu bertahan di bawah air tanpa alat bantu pernapasan.',
      'Society':
          'Batas antara kehidupan darat dan laut menjadi lebih fleksibel. Muncul kemungkinan komunitas bawah laut, pekerjaan baru, dan perubahan cara manusia menggunakan wilayah pesisir.',
      'Economy':
          'Industri perikanan, wisata laut, penelitian, konstruksi, dan eksplorasi bawah laut dapat berkembang pesat karena manusia tidak lagi terlalu bergantung pada peralatan menyelam.',
      'Technology':
          'Teknologi underwater habitat, komunikasi bawah laut, transportasi laut, dan pembangunan kota bawah laut dapat berkembang lebih cepat untuk mendukung aktivitas manusia.',
      'Environment':
          'Aktivitas manusia di laut akan meningkat sehingga tekanan terhadap ekosistem laut juga bisa bertambah. Di sisi lain, manusia akan lebih mudah melakukan penelitian dan konservasi laut secara langsung.',
      'Unexpected Consequences':
          'Laut yang sebelumnya sulit dijangkau dapat menjadi tempat tinggal dan aktivitas manusia. Hal ini bisa menciptakan konflik baru mengenai kepemilikan wilayah dan perlindungan ekosistem laut.',
    },
    timeline: [
      const TimelineStage(
        label: 'Hari 1',
        description:
            'Manusia menyadari bahwa mereka dapat bernapas di bawah air tanpa alat bantu. Aktivitas berenang dan menyelam berubah secara drastis.',
      ),
      const TimelineStage(
        label: 'Tahun 1',
        description:
            'Penelitian dan eksplorasi laut meningkat. Pekerjaan seperti underwater research, penyelamatan, dan konstruksi bawah laut menjadi jauh lebih mudah.',
      ),
      const TimelineStage(
        label: '10 Tahun',
        description:
            'Mulai muncul teknologi dan fasilitas yang dirancang untuk manusia yang hidup dan bekerja lebih lama di bawah laut.',
      ),
    ],
    relatedQuestionIds: [],
  ),

  Question(
    id: 'ai-smarter',
    title: 'What if AI became smarter than humans?',
    category: 'Technology',
    imagePath: 'assets/images/ai_smarter.jpg',
    shortAnswer:
        'Jika AI menjadi lebih cerdas daripada manusia dalam hampir semua bidang intelektual, cara manusia bekerja, belajar, dan membuat keputusan akan berubah besar. Dampaknya dapat membuka peluang baru, tetapi juga menimbulkan pertanyaan tentang control, safety, dan peran manusia.',
    dimensions: {
      'Biology':
          'Manusia mungkin semakin bergantung pada AI untuk memahami tubuh, menemukan obat, dan membantu penelitian biologi. Kemampuan manusia sendiri tidak berubah secara langsung, tetapi cara manusia menggunakan kecerdasannya dapat berubah.',
      'Society':
          'Pendidikan dan pekerjaan akan mengalami perubahan besar. Banyak tugas intelektual dapat dilakukan bersama AI, sementara manusia perlu menentukan tanggung jawab dan batas penggunaannya.',
      'Economy':
          'Produktivitas dapat meningkat karena AI mampu menyelesaikan banyak pekerjaan dengan cepat. Namun, sebagian pekerjaan dapat berubah atau berkurang sehingga sistem pendidikan dan pasar kerja harus beradaptasi.',
      'Technology':
          'AI dapat membantu menciptakan teknologi baru, menemukan solusi ilmiah, dan mengembangkan sistem yang sebelumnya terlalu kompleks untuk manusia. Kemampuan AI juga membuat kebutuhan akan AI safety dan human oversight semakin penting.',
      'Environment':
          'AI dapat membantu mengoptimalkan energi, transportasi, pertanian, dan pengelolaan sumber daya. Namun, pusat data dan komputasi berskala besar juga membutuhkan energi dan sumber daya yang besar.',
      'Unexpected Consequences':
          'Jika AI mampu membuat keputusan dan mengembangkan teknologi jauh lebih cepat daripada manusia, manusia perlu menentukan bagaimana memastikan tujuan AI tetap sejalan dengan kepentingan dan keselamatan manusia.',
    },
    timeline: [
      const TimelineStage(
        label: 'Tahun 1',
        description:
            'AI mulai mengungguli manusia dalam semakin banyak tugas intelektual. Perusahaan, sekolah, dan peneliti mulai mengubah cara mereka menggunakan AI.',
      ),
      const TimelineStage(
        label: 'Tahun 5',
        description:
            'AI menjadi bagian penting dalam penelitian, pekerjaan, dan pengembangan teknologi. Banyak profesi mulai mengalami perubahan besar dalam cara kerja.',
      ),
      const TimelineStage(
        label: 'Tahun 10',
        description:
            'Hubungan antara manusia dan AI menjadi bagian utama kehidupan modern. Aturan, pendidikan, dan sistem ekonomi harus terus beradaptasi dengan kemampuan AI yang semakin maju.',
      ),
    ],
    relatedQuestionIds: ['humans-no-sleep'],
  ),
];

Question getQuestionById(String id) {
  return questionsData.firstWhere((q) => q.id == id);
}
// Riwayat eksplorasi  id terbaru di posisi paling depan
final List<String> explorationHistory = [];

void recordExploration(String questionId) {
  explorationHistory.remove(questionId); // hindari duplikat urutan
  explorationHistory.insert(0, questionId);
}

List<Question> get recentlyExploredQuestions => explorationHistory
    .map((id) {
      try {
        return getQuestionById(id);
      } catch (_) {
        return null;
      }
    })
    .whereType<Question>()
    .toList();

List<Question> get savedQuestions =>
    questionsData.where((q) => q.isSaved).toList();
    
// Kategori diambil otomatis dari data, jadi kategori baru langsung muncul
List<String> get availableCategories =>
    questionsData.map((q) => q.category).toSet().toList();

// Foto tile kategori = foto pertanyaan pertama di kategori itu
String categoryImagePath(String category) =>
    questionsData.firstWhere((q) => q.category == category).imagePath;

// Pertanyaan pilihan di Home, dipilih manual (ganti id sesuai selera)
const List<String> featuredQuestionIds = [
  'humans-no-sleep',
  'earth-stop-rotating',
  'moon-disappear',
  'breathe-underwater',
  'read-minds', 
];

List<Question> get featuredQuestions =>
    featuredQuestionIds.map(getQuestionById).toList();