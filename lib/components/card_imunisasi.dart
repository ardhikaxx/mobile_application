import 'package:flutter/material.dart';
import 'package:posyandu_app/home/detail_imunisasi.dart';

class CardImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const CardImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailImunisasi(dataAnak: dataAnak),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FE),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 300,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Anak: ${dataAnak['nama_anak']}',
              style: TextStyle(
                color: const Color(0xFF0F6ECD),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text('NIK Anak : ${dataAnak['nik_anak']}'),
            Text('Tempat Lahir Anak : ${dataAnak['tempat_lahir_anak']}'),
            Text('Tanggal Lahir Anak : ${dataAnak['tanggal_lahir_anak']}'),
            Text('Golongan Darah : ${dataAnak['gol_darah_anak']}'),
            Text('Anak Ke : ${dataAnak['anak_ke']}'),
            Text('Jenis Kelamin : ${dataAnak['jenis_kelamin_anak']}'),
          ],
        ),
      ),
    );
  }
}
