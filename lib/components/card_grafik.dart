import 'package:flutter/material.dart';
import 'package:posyandu_app/home/detail_grafik.dart';

class CardAnak extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const CardAnak({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailGrafik(dataAnak: dataAnak),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 300,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dataAnak['nama_anak'],
                style: const TextStyle(
                  color: Color(0xFF0F6ECD),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF0F6ECD),
              ),
            ],
          ),
        ),
      ),
    );
  }
}