import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posyandu_app/page/detail_imunisasi.dart';

class CardImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const CardImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color iconColor;

    if (dataAnak['jenis_kelamin_anak'] == 'Laki-laki') {
      backgroundColor = Colors.blue.shade200;
      iconColor = Colors.blue.shade400;
    } else {
      backgroundColor = Colors.pink.shade200;
      iconColor = Colors.pink.shade400;
    }

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
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        width: 300,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.fileWaveform,
                      color: iconColor,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  dataAnak['nama_anak'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'NIK Anak : ${dataAnak['nik_anak']}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Tempat Lahir Anak : ${dataAnak['tempat_lahir_anak']}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text('Tanggal Lahir Anak : ${dataAnak['tanggal_lahir_anak']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            Text(
              'Golongan Darah : ${dataAnak['gol_darah_anak']}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Anak Ke : ${dataAnak['anak_ke']}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Jenis Kelamin : ${dataAnak['jenis_kelamin_anak']}',
              style: const TextStyle(
                color: Colors.white,
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
                backgroundColor: Colors.white,
                foregroundColor: iconColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Lihat Riwayat Posyandu', 
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
