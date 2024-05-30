import 'package:flutter/material.dart';
import 'package:posyandu_app/components/card_grafik.dart';
import 'package:posyandu_app/controller/grafik_controller.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class Grafik extends StatefulWidget {
  final dynamic userData;
  const Grafik({super.key, required this.userData});

  @override
  State<Grafik> createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  @override
  void initState() {
    super.initState();
    if (GrafikController.posyanduData.isEmpty) {
      fetchPosyanduData();
    }
  }

  Future<void> fetchPosyanduData() async {
    await GrafikController.fetchPosyanduData(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grafik',
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
                'Timbanglah Anak Anda Setiap Bulan Anak Sehat, Tambah Umur Tambah Berat, Tambah Pandai',
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
            child: GrafikController.posyanduData.isEmpty
                ? SkeletonLoader(
                    builder: const CardAnakSkeleton(),
                    items: 3,
                    period: const Duration(seconds: 2),
                    highlightColor: Colors.grey[300]!,
                    baseColor: Colors.grey[100]!,
                  )
                : ListView.builder(
                    itemCount: GrafikController.posyanduData.length,
                    itemBuilder: (context, index) {
                      final dataAnak = GrafikController.posyanduData[index];
                      MainAxisAlignment.center;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: CardAnak(dataAnak: dataAnak),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CardAnakSkeleton extends StatelessWidget {
  const CardAnakSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(
              builder: Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: 2,
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey[100]!,
              baseColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 8),
            SkeletonLoader(
              builder: Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: 2,
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey[100]!,
              baseColor: Colors.grey[300]!,
            ),
          ],
        ),
      ),
    );
  }
}