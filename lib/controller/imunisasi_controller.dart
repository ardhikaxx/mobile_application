import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:posyandu_app/controller/auth_controller.dart';

class ImunisasiController {
  static String apiUrl = "https://posyandubayibalita.com";
  static List imunisasiData = [];

  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }

  static Future<void> fetchDataImunisasi(BuildContext context) async {
    try {
      final noKk = AuthController().getNoKk();
      if (noKk == null) {
        throw Exception('No KK not found');
      }

      final response = await http.get(
        Uri.parse('$apiUrl/api/auth/dataImunisasi?no_kk=$noKk'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData.toString());
        if (jsonData['data_anak'] != null && jsonData['data_anak'] is List) {
          imunisasiData = jsonData['data_anak'];
        } else {
          imunisasiData = [];
        }
      } else {
        debugPrint('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Kesalahan mengambil data: $e');
    }
  }
}
