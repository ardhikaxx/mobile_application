import 'package:card_slider/card_slider.dart';
import 'package:flutter/material.dart';
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
  int activeCardIndex = 0;
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
        await Future.delayed(const Duration(seconds: 5));
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
        await Future.delayed(const Duration(seconds: 5));
      }
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
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
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00A5EC),
                      Color(0xFF0F6ECD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        'Hai! ${userData.namaIbu}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00A5EC),
                      Color(0xFF0F6ECD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Jadwal Posyandu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (jadwalPosyandu.isNotEmpty)
                        ...jadwalPosyandu.map((jadwal) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatDate(jadwal['jadwal_posyandu']),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Jam Buka: ${jadwal['jadwal_buka']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Jam Tutup: ${jadwal['jadwal_tutup']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                      else
                        const Text('Tidak ada jadwal posyandu untuk bulan ini.',
                        textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF00A5EC),
                      Color(0xFF0F6ECD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.graphic_eq_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Data Anak',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: dataAnak.isNotEmpty
                          ? CardSlider(
                              cards: dataAnak.map<Widget>((anak) {
                                return Card(
                                  color: Colors.white,
                                  key: ValueKey(anak['id_anak']),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 75,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          anak['nama_anak'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF00A5EC),
                                          ),
                                        ),
                                        Text(
                                          'Anak ke: ${anak['anak_ke']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (anak['posyandu'].isNotEmpty)
                                          Text(
                                            'Tinggi Badan: ${anak['posyandu'].last['tb_anak']} cm - Berat Badan: ${anak['posyandu'].last['bb_anak']} kg',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        else
                                          const Text(
                                            'Data posyandu tidak tersedia',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              cardWidth:
                                  MediaQuery.of(context).size.width * 0.8,
                              cardHeight: 250,
                            )
                          : const Center(
                              child: Text(
                                'Tidak ada data anak',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(dataAnak.length, (index) {
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeCardIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
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