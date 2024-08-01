import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:posyandu_app/controller/jadwal_controller.dart';
import 'package:posyandu_app/controller/imunisasi_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:posyandu_app/controller/auth_controller.dart';

class DashboardPage extends StatefulWidget {
  final UserData userData;

  const DashboardPage({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late UserData userData;
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

    while (!dataFetched) {
      try {
        final data =
            await JadwalPosyanduController.fetchJadwalPosyandu(bulan, tahun);
        setState(() {
          jadwalPosyandu = data;
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
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
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
                color: const Color(0xFF006BFA),
                borderRadius: BorderRadius.circular(20),
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.personBreastfeeding,
                          color: Color(0xFFFFD700),
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
                            color: Colors.black,
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
                color: const Color(0xFF006BFA),
                borderRadius: BorderRadius.circular(20),
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
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF7BBF6A),
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Jadwal Posyandu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (jadwalPosyandu.isNotEmpty)
                      ...jadwalPosyandu.map((jadwal) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatDate(jadwal['jadwal_posyandu']),
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
                      }).toList()
                    else
                      const Padding(
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
              height: 250,
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
                            color: Color(0xFF006BFA),
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
                              var posyanduData = anak['posyandu'] ??
                                  []; // Menangani jika 'posyandu' null

                              // Menetapkan nilai default jika posyanduData kosong
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
                                color: const Color(0xFF006BFA),
                                key: ValueKey(anak['id_anak']),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            child: const Center(
                                              child: Icon(
                                                FontAwesomeIcons.heartPulse,
                                                color: Color(0xFF006BFA),
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            anak['nama_anak'],
                                            style: const TextStyle(
                                              fontSize: 22,
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
                                          fontSize: 18,
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
                                                fontSize: 16,
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
                                                fontSize: 16,
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
                            itemWidth: MediaQuery.of(context).size.width * 0.9,
                            itemHeight: 350,
                            layout: SwiperLayout.STACK,
                          )
                        : const Center(
                            child: Text(
                              'Tidak ada data anak',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
