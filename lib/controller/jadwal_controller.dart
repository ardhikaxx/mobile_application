import 'package:http/http.dart' as http;
import 'dart:convert';

class JadwalPosyanduController {
  static String apiUrl = 'https://posyandubayibalita.com';

  static Future<List<dynamic>> fetchJadwalPosyandu(int bulan, int tahun) async {
    final url = Uri.parse('$apiUrl/api/jadwal-posyandu?bulan=$bulan&tahun=$tahun');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      print('Gagal Menampilkan Jadwal Posyandu');
      return [];
    }
  }
}