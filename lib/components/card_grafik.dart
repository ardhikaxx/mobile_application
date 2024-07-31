import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posyandu_app/page/detail_grafik.dart';

class CardAnak extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const CardAnak({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    IconData genderIcon;
    Color backgroundColor;
    Color iconColor;

    if (dataAnak['jenis_kelamin_anak'] == 'Laki-laki') {
      genderIcon = FontAwesomeIcons.person;
      backgroundColor = Colors.blue.shade200;
      iconColor = Colors.blue.shade400;
    } else {
      genderIcon = FontAwesomeIcons.personDress;
      backgroundColor = Colors.pink.shade200;
      iconColor = Colors.pink.shade400;
    }

    // Default values if 'posyandu' is empty
    final latestAge = dataAnak['posyandu'].isNotEmpty
        ? dataAnak['posyandu'].last['umur_anak']
        : 'Tidak ada data';

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
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 300,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 65,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    genderIcon,
                    color: iconColor,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dataAnak['nama_anak'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dataAnak['jenis_kelamin_anak'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$latestAge bulan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}