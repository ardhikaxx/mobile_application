import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:posyandu_app/components/navbottom.dart';
import 'package:posyandu_app/auth/login.dart';
import 'package:posyandu_app/model/user.dart';

class ApiConfig {
  static String apiUrl = "https://posyandubayibalita.com";

  void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }
}

class AuthController {
  static int? _noKk;
  int? getNoKk() => _noKk;

  static Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/login";
      final response = await http.post(Uri.parse(apiUrl),
          body: {'email_orang_tua': email, 'password_orang_tua': password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        UserData userData = UserData.fromJson(jsonData['data']['user']);
        _noKk = userData.noKk;
        // ignore: use_build_context_synchronously
        _showMessageDialog(context, userData.namaIbu, userData);
      } else {
        // ignore: use_build_context_synchronously
        _showLoginErrorDialog(context);
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      _showLoginErrorDialog(context);
    }
  }

  static Future<UserData?> dataProfile(BuildContext context) async {
  try {
    final responseData = await http.get(
      Uri.parse("${ApiConfig.apiUrl}/api/auth/dataProfile?no_kk=$_noKk"),
    );
    if (responseData.statusCode == 200) {
      final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
      final userData =
          UserData.fromJson(jsonGet['user'] as Map<String, dynamic>);
      return userData;
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}

  static Future<bool> updateProfile(
  BuildContext context,
  int noKk,
  String namaIbu,
  String namaAyah,
  String alamat,
  String telepon,
) async {
  try {
    final String apiUrl = "${ApiConfig.apiUrl}/api/auth/updateProfile";
    final response = await http.put(
      Uri.parse(apiUrl),
      body: {
        'no_kk': noKk.toString(),
        'nama_ibu': namaIbu,
        'nama_ayah': namaAyah,
        'alamat': alamat,
        'telepon': telepon,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error Updating profile: $error');
    return false;
  }
}

  static void showErrorUpdate(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Gagal',
      desc: 'Profil Gagal di Edit',
    ).show();
  }

  Future<void> logout(BuildContext context) async {
    _noKk = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static Future<void> register(
    BuildContext context, {
    required String noKk,
    required String nikIbu,
    required String namaIbu,
    required String nikAyah,
    required String namaAyah,
    required String alamat,
    required String telepon,
    required String email,
    required String golDarah,
    required String tempatLahir,
    required String tanggalLahir,
    required String password,
  }) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/register";
      final response = await http.post(Uri.parse(apiUrl), body: {
        'no_kk': noKk,
        'nik_ibu': nikIbu,
        'nama_ibu': namaIbu,
        'nik_ayah': nikAyah,
        'nama_ayah': namaAyah,
        'alamat': alamat,
        'telepon': telepon,
        'email_orang_tua': email,
        'gol_darah_ibu': golDarah,
        'tempat_lahir_ibu': tempatLahir,
        'tanggal_lahir_ibu': tanggalLahir,
        'password_orang_tua': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        _showSuccessDialog(context);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        _showErrorDialog(context);
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      _showErrorDialog(context);
    }
  }

  static void _showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Berhasil',
      desc: 'Akun Anda telah berhasil didaftarkan!',
    ).show();
  }

  static void _showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Registrasi Gagal',
      desc: 'Maaf, terjadi kesalahan saat melakukan registrasi.',
    ).show();
  }

  static Future<bool> checkEmail(BuildContext context, String email) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/check-email";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email_orang_tua': email},
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final message = jsonData['message'] as String;
        return message == 'true';
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  static Future<void> changePassword(
      BuildContext context, String email, String newPassword) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/change-password";
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email_orang_tua': email,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String;
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: message,
          btnOkText: 'OK',
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ).show();
      } else {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String;

        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: message,
        ).show();
      }
    } catch (e) {
      print('Error: $e');
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Gagal memperbarui password',
      ).show();
    }
  }
}

void _showMessageDialog(BuildContext context, String data, UserData userData) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Login Successful',
    desc: 'Selamat Datang, $data!',
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Get.off(() => NavigationButtom(userData: userData));
  });
}

void _showLoginErrorDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Login Gagal',
    desc: 'Email atau password salah. Silakan coba lagi.',
    btnOkOnPress: () {},
  ).show();
}
