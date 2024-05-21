import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

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
            const Center(
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildBarChartCard('Berat Badan (kg)', beratBadanData, Colors.blue, posyanduData),
                  const SizedBox(height: 20),
                  _buildBarChartCard('Tinggi Badan (cm)', tinggiBadanData, Colors.green, posyanduData),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBeratBadanData(List<dynamic> data) {
    return data.asMap().entries.map<BarChartGroupData>((entry) {
      final index = entry.key;
      final posyandu = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: posyandu['bb_anak'].toDouble(),
            color: Colors.blue,
          ),
        ],
      );
    }).toList();
  }

  List<BarChartGroupData> _createTinggiBadanData(List<dynamic> data) {
    return data.asMap().entries.map<BarChartGroupData>((entry) {
      final index = entry.key;
      final posyandu = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: posyandu['tb_anak'].toDouble(),
            color: Colors.green,
          ),
        ],
      );
    }).toList();
  }

  Widget _buildBarChartCard(String title, List<BarChartGroupData> data, Color color, List<dynamic> posyanduData) {
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
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: data,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final month = _getMonthName(posyanduData[value.toInt()]['tanggal_posyandu']);
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(month),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String date) {
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final monthNumber = int.parse(DateFormat('MM').format(DateFormat('yyyy-MM-dd').parse(date)));
    return monthNames[monthNumber - 1];
  }
}

class ChartData {
  final String month;
  final double value;

  ChartData(this.month, this.value);
}