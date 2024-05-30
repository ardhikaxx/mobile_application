import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:posyandu_app/components/card_imunisasi.dart';
import 'package:posyandu_app/controller/imunisasi_controller.dart';

class Imunisasi extends StatefulWidget {
  final dynamic userData;
  const Imunisasi({super.key, required this.userData});

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  bool _isLoading = true; // Introduce loading state

  @override
  void initState() {
    super.initState();
    if (ImunisasiController.imunisasiData.isEmpty) {
      fetchDataImunisasi();
    } else {
      _isLoading =
          false; // Set loading state to false if data is already available
    }
  }

  Future<void> fetchDataImunisasi() async {
    await ImunisasiController.fetchDataImunisasi(context);
    setState(() {
      _isLoading = false; // Set loading state to false after data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Imunisasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F6ECD),
            fontSize: 25,
          ),
        ),
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Center(
              child: Text(
                'Riwayat Imunisasi pada Anak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _isLoading
                ? SkeletonLoader(
                    builder: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 20.0,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 20.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : ImunisasiController.imunisasiData.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada Data Anak',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: ImunisasiController.imunisasiData.length,
                        itemBuilder: (context, index) {
                          final dataAnak =
                              ImunisasiController.imunisasiData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: CardImunisasi(dataAnak: dataAnak),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}