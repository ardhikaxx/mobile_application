import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CardArtikel extends StatelessWidget {
  final String judul;
  final String gambar;
  final Function onTap;

  const CardArtikel({
    super.key,
    required this.judul,
    required this.gambar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FE),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 317,
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: _buildImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
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
              height: 150,
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