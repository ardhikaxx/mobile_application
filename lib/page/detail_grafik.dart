import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailGrafik extends StatelessWidget {
  final Map<String, dynamic> dataAnak;

  const DetailGrafik({super.key, required this.dataAnak});

  @override
  Widget build(BuildContext context) {
    final posyanduData = dataAnak['posyandu'];
    final beratBadanData = _createBeratBadanData(posyanduData);
    final tinggiBadanData = _createTinggiBadanData(posyanduData);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          dataAnak['nama_anak'],
          style: const TextStyle(
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
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF006BFA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    'Grafik Pertumbuhan dan Perkembangan Anak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        'Grafik Perkembangan Berat Badan Anak',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBarChartCard(
                          'Berat Badan (kg)',
                          beratBadanData,
                          const Color(0xFFBCE7F0),
                          const Color(0xFF00A1E4),
                          FontAwesomeIcons.weightScale,
                          Colors.black),
                      const SizedBox(height: 20),
                      const Text(
                        'Grafik Perkembangan Tinggi Badan Anak',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBarChartCard(
                          'Tinggi Badan (cm)',
                          tinggiBadanData,
                          const Color(0xFFCFE9BC),
                          const Color(0xFF7BBF6A),
                          FontAwesomeIcons.ruler,
                          Colors.black),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
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
        value: bbAnak ?? 0.0,
      );
    }).toList();
  }

  List<ChartSampleData> _createTinggiBadanData(List<dynamic> data) {
    return data.asMap().entries.map<ChartSampleData>((entry) {
      final posyandu = entry.value;
      double? tbAnak = double.tryParse(posyandu['tb_anak'].toString());
      return ChartSampleData(
        month: _getMonthName(posyandu['tanggal_posyandu']),
        value: tbAnak ?? 0.0,
      );
    }).toList();
  }

  Widget _buildBarChartCard(String title, List<ChartSampleData> data,
      Color backgroundColor, Color chartColor, IconData icon, Color iconColor) {
    return Card(
      color: backgroundColor,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
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
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: FaIcon(
                    icon,
                    color: chartColor,
                    size: 25,
                  ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  majorGridLines: MajorGridLines(
                    color: Colors.grey[200]!,
                    width: 1,
                    dashArray: const [5, 5],
                  ),
                ),
                series: <CartesianSeries>[
                  ColumnSeries<ChartSampleData, String>(
                    dataSource: data,
                    xValueMapper: (ChartSampleData sales, _) => sales.month,
                    yValueMapper: (ChartSampleData sales, _) => sales.value,
                    color: chartColor,
                    borderRadius: BorderRadius.circular(5),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: const Legend(
                  isVisible: false,
                ),
                plotAreaBorderWidth: 0,
                borderWidth: 0,
                plotAreaBackgroundColor: Colors.transparent,
                plotAreaBorderColor: Colors.transparent,
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
