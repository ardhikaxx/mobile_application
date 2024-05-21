import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:posyandu_app/controller/auth_controller.dart';

class GrafikController {
  static String apiUrl = "http://10.10.182.23:8000";
  static List posyanduData = [];

  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }

  static Future<void> fetchPosyanduData(BuildContext context) async {
    try {
      final responseData = await http.get(
        Uri.parse("${GrafikController.apiUrl}/api/auth/dataGrafik"),
        headers: {'Authorization': 'Bearer ${AuthController.getToken()}'},
      );
      if (responseData.statusCode == 200) {
        final jsonData = jsonDecode(responseData.body) as Map<String, dynamic>;
        posyanduData = jsonData['data'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}