import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailImunisasi({Key? key, required this.dataAnak}) : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return IntrinsicWidth(
                child: DataTable(
                  columnSpacing: 10,
                  headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xFF0F6ECD)),
                  columns: <DataColumn>[
                    DataColumn(
                      numeric: false,
                      label: Container(
                        width: 65, // Sesuaikan dengan lebar yang diinginkan
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tanggal',
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: false,
                      label: Container(
                        width: 50, // Sesuaikan dengan lebar yang diinginkan
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'TB',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: false,
                      label: Container(
                        width: 50, // Sesuaikan dengan lebar yang diinginkan
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'BB',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: false,
                      label: Container(
                        width: 50, // Sesuaikan dengan lebar yang diinginkan
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Umur',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: false,
                      label: Container(
                        width: 80, // Sesuaikan dengan lebar yang diinginkan
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Nama Vaksin',
                          maxLines: 5,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(dataAnak['posyandu'].length, (index) {
                    final posyanduData = dataAnak['posyandu'][index];
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 60, // Sesuaikan dengan lebar yang diinginkan
                            child: Text(
                              posyanduData['tanggal_posyandu'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 50, // Sesuaikan dengan lebar yang diinginkan
                            child: Text(
                              '${posyanduData['tb_anak']} cm',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 50, // Sesuaikan dengan lebar yang diinginkan
                            child: Text(
                              '${posyanduData['bb_anak']} kg',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 50, // Sesuaikan dengan lebar yang diinginkan
                            child: Text(
                              '${posyanduData['umur_anak']} bulan',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 80, // Sesuaikan dengan lebar yang diinginkan
                            child: Text(
                              posyanduData['nama_vaksin'].join(', '),
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
