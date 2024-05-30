import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:posyandu_app/controller/auth_controller.dart';

class ImunisasiController {
  static String apiUrl = "http://192.168.18.50:8000";
  static List imunisasiData = [];

  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }

  static Future<void> fetchDataImunisasi(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/auth/dataImunisasi'),
        headers: {'Authorization': 'Bearer ${AuthController.getToken()}'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        
        if (jsonData['data_anak'] != null && jsonData['data_anak'] is List) {
          imunisasiData = jsonData['data_anak'];
        } else {
          imunisasiData = [];
        }
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Kesalahan mengambil data: $e');
      throw Exception('Kesalahan mengambil data: $e');
    }
  }
}
