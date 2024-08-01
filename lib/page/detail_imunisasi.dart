import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImunisasi extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailImunisasi({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F9),
      appBar: AppBar(
        title: const Text(
          'Detail Imunisasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFF006BFA),
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
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBCE7F0),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                height: 65,
                child: const Center(
                  child: Text(
                    'Riwayat Posyandu dan Imunisasi Anak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return IntrinsicWidth(
                          child: DataTable(
                            columnSpacing: 8,
                            headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xFF006BFA)),
                            columns: <DataColumn>[
                              DataColumn(
                                numeric: false,
                                label: Container(
                                  width: 70,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
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
                                  width: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
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
                                  width: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'BB',
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
                                  width: 52,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
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
                                  width: 80,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
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
                                    SizedBox(
                                      width: 65,
                                      height: 80,
                                      child: Text(
                                        posyanduData['tanggal_posyandu'],
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 50,
                                      height: 80,
                                      child: Text(
                                        '${posyanduData['tb_anak']} cm',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 50,
                                      height: 80,
                                      child: Text(
                                        '${posyanduData['bb_anak']} kg',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 52,
                                      height: 80,
                                      child: Text(
                                        '${posyanduData['umur_anak']} bulan',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Text(
                                        posyanduData['nama_vaksin'].join(', '),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}