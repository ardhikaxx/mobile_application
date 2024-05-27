import 'package:flutter/material.dart';
import 'package:posyandu_app/components/card_imunisasi.dart';
import 'package:posyandu_app/controller/imunisasi_controller.dart';

class Imunisasi extends StatefulWidget {
  final dynamic userData;
  const Imunisasi({super.key, required this.userData});

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {

  @override
  void initState() {
    super.initState();
    if (ImunisasiController.imunisasiData.isEmpty) {
      fetchDataImunisasi();
    }
  }

  Future<void> fetchDataImunisasi() async {
    await ImunisasiController.fetchDataImunisasi(context);
    setState(() {});
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
          Padding(
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
            child: ImunisasiController.imunisasiData.isEmpty
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
                      final dataAnak = ImunisasiController.imunisasiData[index]; // Perbaikan disini
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: CardImunisasi(dataAnak: dataAnak), // Perbaikan disini
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
