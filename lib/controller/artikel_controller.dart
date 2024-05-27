import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ArtikelController {
  static String apiUrl = 'http://192.168.1.42:8000';
  static List<dynamic> artikelData = [];

  Future<void> fetchArtikelData(BuildContext context) async {
    try {
      final responseData = await http.get(
        Uri.parse("${ArtikelController.apiUrl}/api/edukasi"),
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final artikelDataFromApi = jsonGet['data'] as List<dynamic>;

        List<dynamic> processedArtikels = [];
        for (var artikelJson in artikelDataFromApi) {
          final artikel = Artikel.fromJson(artikelJson);
          processedArtikels.add(artikel);
        }
        artikelData = processedArtikels;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class Artikel {
  final String judul;
  final String gambar;
  final String isi;

  Artikel({
    required this.judul,
    required this.gambar,
    required this.isi,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      judul: json['judul'] ?? '',
      gambar: json['foto'] ?? '',
      isi: json['isi'] ?? '',
    );
  }
}