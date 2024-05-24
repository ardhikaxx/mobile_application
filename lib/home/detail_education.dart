import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DetailEducation extends StatelessWidget {
  final String judul;
  final String gambar;
  final String isi;

  const DetailEducation({
    super.key,
    required this.judul,
    required this.gambar,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Artikel',
          style: TextStyle(
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
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              _buildImage(),
              const SizedBox(height: 20),
              // Judul
              Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              // Isi
              Text(
                isi,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return FutureBuilder(
      future: _loadImage(gambar),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data as Uint8List,
              fit: BoxFit.cover,
              width: double.infinity,
            );
          } else {
            return const Placeholder();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Uint8List?> _loadImage(String base64Image) async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(base64Image);
    if (fileInfo != null) {
      return fileInfo.file.readAsBytes();
    } else {
      final imageData = base64.decode(base64Image);
      await cacheManager.putFile(
        base64Image,
        imageData,
        fileExtension: 'jpg',
      );
      return imageData;
    }
  }
}