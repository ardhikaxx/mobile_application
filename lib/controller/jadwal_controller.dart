import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class JadwalPosyanduController {
  static String apiUrl = 'http://192.168.1.42:8000';

  static Future<List<dynamic>> fetchJadwalPosyandu(int bulan, int tahun) async {
    final url = Uri.parse('$apiUrl/api/jadwal-posyandu?bulan=$bulan&tahun=$tahun');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal Menampilkan Jadwal Posyandu');
    }
  }
}