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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Anak: ${dataAnak['nama_anak']}',
              style: const TextStyle(
                color: Color(0xFF0F6ECD),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'NIK Anak : ${dataAnak['nik_anak']}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Tempat Lahir Anak : ${dataAnak['tempat_lahir_anak']}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text('Tanggal Lahir Anak : ${dataAnak['tanggal_lahir_anak']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            Text(
              'Golongan Darah : ${dataAnak['gol_darah_anak']}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Anak Ke : ${dataAnak['anak_ke']}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Jenis Kelamin : ${dataAnak['jenis_kelamin_anak']}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailImunisasi(dataAnak: dataAnak),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0F6ECD), 
                foregroundColor: Colors.white, 
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Lihat Riwayat Posyandu'),
            ),
          ],
        ),
      ),
    );
  }
}
