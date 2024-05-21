import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ArtikelController {
  static String apiUrl = 'http://10.10.182.23:8000';
  static List<dynamic> artikelData = [];

  Future<void> fetchArtikelData(BuildContext context) async {
    try {
      final responseData = await http.get(
        Uri.parse("${ArtikelController.apiUrl}/api/artikels"),
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final artikelDataFromApi = jsonGet['data'] as List<dynamic>;

        final currentDate = DateTime.now();
        final filteredArtikels = artikelDataFromApi.where((artikel) {
          final uploadDate = DateTime.parse(artikel['tanggal_upload']);
          return uploadDate.year == currentDate.year &&
              uploadDate.month == currentDate.month &&
              uploadDate.day == currentDate.day;
        }).toList();

        List<dynamic> processedArtikels = [];
        for (var artikelJson in filteredArtikels) {
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
  final DateTime tanggalUpload;
  final String deskripsi;

  Artikel({
    required this.judul,
    required this.gambar,
    required this.tanggalUpload,
    required this.deskripsi,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      judul: json['judul'] ?? '',
      gambar: json['gambar'] ?? '',
      tanggalUpload: json['tanggal_upload'] != null
          ? DateTime.parse(json['tanggal_upload'])
          : DateTime.now(),
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}
