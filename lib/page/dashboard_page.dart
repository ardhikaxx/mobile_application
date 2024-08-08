import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:posyandu_app/controller/jadwal_controller.dart';
import 'package:posyandu_app/controller/imunisasi_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:posyandu_app/controller/auth_controller.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class DashboardPage extends StatefulWidget {
  final UserData userData;

  const DashboardPage({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late UserData userData;
  bool _isLoading = true;
  List<dynamic> jadwalPosyandu = [];
  List<dynamic> dataAnak = [];
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    userData = widget.userData;
    initializeDateFormatting('id_ID', null);
    _fetchJadwalPosyandu();
    _fetchDataAnak();
  }

  void _fetchUserData() {
    AuthController.dataProfile(context).then((userData) {
      if (userData != null) {
        setState(() {
          this.userData = userData;
        });
      }
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

  Future<void> _fetchJadwalPosyandu() async {
    final now = DateTime.now();
    final bulan = now.month;
    final tahun = now.year;
    bool dataFetched = false;

    setState(() {
      _isLoading = true;
    });

    while (!dataFetched) {
      try {
        final data =
            await JadwalPosyanduController.fetchJadwalPosyandu(bulan, tahun);
        setState(() {
          jadwalPosyandu = data;
          _isLoading = false;
        });
        dataFetched = true;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<void> _fetchDataAnak() async {
    bool dataFetched = false;

    while (!dataFetched) {
      try {
        // ignore: use_build_context_synchronously
        await ImunisasiController.fetchDataImunisasi(context);
        setState(() {
          dataAnak = ImunisasiController.imunisasiData;
        });
        dataFetched = true;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Widget _buildArrowIconWithBackground(
      double previousValue, double currentValue) {
    IconData icon;
    Color iconColor;
    Color backgroundColor;

    if (currentValue > previousValue) {
      icon = FontAwesomeIcons.arrowTrendUp;
      iconColor = Colors.green.shade400;
      backgroundColor = Colors.white;
    } else if (currentValue < previousValue) {
      icon = FontAwesomeIcons.arrowTrendDown;
      iconColor = Colors.red.shade400;
      backgroundColor = Colors.white;
    } else {
      icon = FontAwesomeIcons.minus;
      iconColor = Colors.black;
      backgroundColor = Colors.white;
    }

    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FaIcon(
          icon,
          color: iconColor,
          size: 16,
        ),
      ),
    );
  }

  double parseStringToDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }

  String _formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    return formatter.format(parsedDate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage('assets/logodashboard.png'),
                  width: 350,
                  height: 150,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7),
                      spreadRadius: -2,
                      blurRadius: 20,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          color: Color(0xFF006BFA),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.personBreastfeeding,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF006BFA),
                            ),
                          ),
                          Text(
                            userData.namaIbu,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7),
                      spreadRadius: -2,
                      blurRadius: 20,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF006BFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Jadwal Posyandu',
                            style: TextStyle(
                              color: Color(0xFF006BFA),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      _isLoading
                          ? SkeletonLoader(
                              builder: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(1, (index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          color: Colors.grey[300],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 20,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              items: 1,
                              period: const Duration(milliseconds: 1200),
                              highlightColor: Colors.grey[100]!,
                              baseColor: Colors.grey[300]!,
                            )
                          : jadwalPosyandu.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: jadwalPosyandu.map((jadwal) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _formatDate(
                                                jadwal['jadwal_posyandu']!),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Jam Buka: ${jadwal['jadwal_buka']}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                'Jam Tutup: ${jadwal['jadwal_tutup']}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Tidak ada jadwal posyandu untuk bulan ini.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
                      child: Row(
                        children: [
                          Text(
                            'Data Anak',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: dataAnak.isNotEmpty
                          ? Swiper(
                              itemCount: dataAnak.length,
                              itemBuilder: (BuildContext context, int index) {
                                var anak = dataAnak[index];
                                var posyanduData = anak['posyandu'] ?? [];

                                // Menentukan warna latar belakang dan ikon berdasarkan jenis kelamin
                                Color backgroundColor;
                                Color iconColor;
                                if (anak['jenis_kelamin_anak'] == 'Laki-laki') {
                                  backgroundColor = Colors.blue.shade300;
                                  iconColor = Colors.blue.shade400;
                                } else {
                                  backgroundColor = Colors.pink.shade200;
                                  iconColor = Colors.pink.shade300;
                                }

                                double previousHeight = posyanduData.length > 1
                                    ? parseStringToDouble(
                                        posyanduData[posyanduData.length - 2]
                                                ['tb_anak'] ??
                                            '0')
                                    : (posyanduData.isNotEmpty
                                        ? parseStringToDouble(
                                            posyanduData.last['tb_anak'] ?? '0')
                                        : 0);
                                double currentHeight = posyanduData.isNotEmpty
                                    ? parseStringToDouble(
                                        posyanduData.last['tb_anak'] ?? '0')
                                    : 0;

                                double previousWeight = posyanduData.length > 1
                                    ? parseStringToDouble(
                                        posyanduData[posyanduData.length - 2]
                                                ['bb_anak'] ??
                                            '0')
                                    : (posyanduData.isNotEmpty
                                        ? parseStringToDouble(
                                            posyanduData.last['bb_anak'] ?? '0')
                                        : 0);
                                double currentWeight = posyanduData.isNotEmpty
                                    ? parseStringToDouble(
                                        posyanduData.last['bb_anak'] ?? '0')
                                    : 0;

                                return Card(
                                  color: backgroundColor,
                                  key: ValueKey(anak['nik_anak']),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 350,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.heartPulse,
                                                  color: iconColor,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              anak['nama_anak'],
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Anak ke: ${anak['anak_ke']}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (posyanduData.isNotEmpty) ...[
                                          Row(
                                            children: [
                                              Text(
                                                'Tinggi Badan: $currentHeight cm',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              _buildArrowIconWithBackground(
                                                previousHeight,
                                                currentHeight,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Berat Badan: $currentWeight kg',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              _buildArrowIconWithBackground(
                                                previousWeight,
                                                currentWeight,
                                              ),
                                            ],
                                          ),
                                        ] else
                                          const Text(
                                            'Data posyandu tidak tersedia',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemWidth:
                                  MediaQuery.of(context).size.width * 0.9,
                              itemHeight: 350,
                              layout: SwiperLayout.STACK,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/lottie/no_data.json', width: 200 ),
                                const Text(
                                  'Tidak ada data anak.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
