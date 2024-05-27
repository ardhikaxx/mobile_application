import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Imunisasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFF0F6ECD),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
      ),
    );
  }
}
