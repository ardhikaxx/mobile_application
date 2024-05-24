import 'package:flutter/material.dart';
import 'package:posyandu_app/components/card_artikel.dart';
import 'package:posyandu_app/controller/artikel_controller.dart';
import 'package:posyandu_app/home/detail_education.dart';

class Education extends StatefulWidget {
  final dynamic userData;
  const Education({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  ArtikelController artikelController = ArtikelController();

  @override
  void initState() {
    super.initState();
    fetchArtikelData();
  }

  Future<void> fetchArtikelData() async {
    try {
      await artikelController.fetchArtikelData(context);
      setState(() {});
    } catch (e) {
      print('Error fetching artikel data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edukasi',
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
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Yuk bunda, baca edukasi untuk memperoleh informasi tentang pola asuh, kesehatan untuk pertumbuhan balita.',
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
            child: FutureBuilder(
              future: artikelController.fetchArtikelData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: ArtikelController.artikelData.length,
                    itemBuilder: (context, index) {
                      final artikel = ArtikelController.artikelData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CardArtikel(
                          judul: artikel.judul,
                          gambar: artikel.gambar,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailEducation(
                                  judul: artikel.judul,
                                  gambar: artikel.gambar,
                                  isi: artikel.isi,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}