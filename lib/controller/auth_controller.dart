import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posyandu_app/components/navbottom.dart';
import 'package:posyandu_app/auth/login.dart';
import 'package:posyandu_app/model/user.dart';

class ApiConfig {
  static String apiUrl = "http://192.168.18.50:8000";

  static void setApiUrl(String newUrl) {
    apiUrl = newUrl;
  }
}

class AuthController {
  static late String _token;

  static void setToken(String token) {
    _token = token;
  }

  static String getToken() {
    return _token;
  }

  static Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/login";
      final response = await http.post(Uri.parse(apiUrl),
          body: {'email_orang_tua': email, 'password_orang_tua': password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final token = jsonData['data']['token'] as String;
        setToken(token);
        // ignore: use_build_context_synchronously
        await tokenRequest(context, token);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> dataProfile(BuildContext context, String token) async {
    try {
      final responseData = await http.get(
        Uri.parse("${ApiConfig.apiUrl}/api/auth/dataProfile"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final userData =
            UserData.fromJson(jsonGet['data'] as Map<String, dynamic>);
        // ignore: use_build_context_synchronously
        _showMessageDialog(context, userData.namaIbu, userData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<bool> updateProfile(
  BuildContext context,
  TextEditingController namaIbuController,
  TextEditingController namaAyahController,
  TextEditingController alamatController,
  TextEditingController teleponController,
) async {
  try {
    final String apiUrl = "${ApiConfig.apiUrl}/api/auth/updateProfile";
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${AuthController.getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama_ibu': namaIbuController.text,
        'nama_ayah': namaAyahController.text,
        'alamat': alamatController.text,
        'telepon': teleponController.text,
      }),
    );
    if (response.statusCode == 200) {
      // Panggil metode untuk mendapatkan data profil terbaru setelah pembaruan
      await dataProfile(context, AuthController.getToken());
      return true;
    } else {
      // ignore: use_build_context_synchronously
      showErrorUpdate(context);
      return false;
    }
  } catch (error) {
    print('Error Updating profile: $error');
    // ignore: use_build_context_synchronously
    showErrorUpdate(context);
    return false;
  }
}

  static void showSuccessUpdate(BuildContext context, UserData userData) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Berhasil',
    desc: 'Profile Berhasil di Edit!',
    btnOkOnPress: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationButtom(userData: userData),
        ),
      );
    },
  ).show();
}

  static void showErrorUpdate(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Gagal',
      desc: 'Profile Gagal di Edit',
    ).show();
  }

  static Future<void> tokenRequest(BuildContext context, String token) async {
    try {
      final responseData = await http.get(
        Uri.parse("${ApiConfig.apiUrl}/api/auth/me"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (responseData.statusCode == 200) {
        final jsonGet = jsonDecode(responseData.body) as Map<String, dynamic>;
        final userData =
            UserData.fromJson(jsonGet['data'] as Map<String, dynamic>);
        _showMessageDialog(context, userData.namaIbu, userData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> logout(BuildContext context, String token) async {
    try {
      final String apiUrl = "${ApiConfig.apiUrl}/api/auth/logout";
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $_token',
      });
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        print('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
        _showSuccessDialog(context);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        _showErrorDialog(context);
      }
    } catch (e) {
      print('Error: $e');
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
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: message,
        ).show().then((_) {
          Future.delayed(const Duration(seconds: 2), () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.bottomSlide,
              title: 'Confirmation',
              desc: 'Are you sure you want to proceed to the login page?',
              btnOkText: 'OK',
              btnOkOnPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ).show();
          });
        });
      } else {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String;

        AwesomeDialog(
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
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Failed to change password',
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
    desc: 'Welcome, $data!',
  ).show();

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => NavigationButtom(userData: userData)),
    );
  });
}
