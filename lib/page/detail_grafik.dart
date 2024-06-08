import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailGrafik extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailGrafik({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    final posyanduData = dataAnak['posyandu'];
    final beratBadanData = _createBeratBadanData(posyanduData);
    final tinggiBadanData = _createTinggiBadanData(posyanduData);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataAnak['nama_anak'],
          style: const TextStyle(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
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
                width: double.infinity,
                height: 65,
                child: const Center(
                  child: Text(
                    'Grafik Pertumbuhan dan Perkembangan Anak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F6ECD),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Grafik Perkembangan Berat Badan Anak',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildBarChartCard(
                      'Berat Badan (kg)', beratBadanData, Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    'Grafik Perkembangan Tinggi Badan Anak',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildBarChartCard(
                      'Tinggi Badan (cm)', tinggiBadanData, Colors.green),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartSampleData> _createBeratBadanData(List<dynamic> data) {
    return data.asMap().entries.map<ChartSampleData>((entry) {
      final posyandu = entry.value;
      double? bbAnak = double.tryParse(posyandu['bb_anak'].toString());
      return ChartSampleData(
        month: _getMonthName(posyandu['tanggal_posyandu']),
        value: bbAnak ?? 0.0, // Default to 0.0 if conversion fails
      );
    }).toList();
  }

  List<ChartSampleData> _createTinggiBadanData(List<dynamic> data) {
    return data.asMap().entries.map<ChartSampleData>((entry) {
      final posyandu = entry.value;
      double? tbAnak = double.tryParse(posyandu['tb_anak'].toString());
      return ChartSampleData(
        month: _getMonthName(posyandu['tanggal_posyandu']),
        value: tbAnak ?? 0.0, // Default to 0.0 if conversion fails
      );
    }).toList();
  }

  Widget _buildBarChartCard(
      String title, List<ChartSampleData> data, Color color) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF0F6ECD),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                primaryYAxis: const NumericAxis(),
                series: <CartesianSeries<ChartSampleData, String>>[
                  ColumnSeries<ChartSampleData, String>(
                    dataSource: data,
                    xValueMapper: (ChartSampleData sales, _) => sales.month,
                    yValueMapper: (ChartSampleData sales, _) => sales.value,
                    color: color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String date) {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    final monthNumber = int.parse(
        DateFormat('MM').format(DateFormat('yyyy-MM-dd').parse(date)));
    return monthNames[monthNumber - 1];
  }
}

class ChartSampleData {
  final String month;
  final double value;

  ChartSampleData({required this.month, required this.value});
}