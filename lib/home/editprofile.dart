// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posyandu_app/model/user.dart';
import 'package:get/get.dart';
import 'package:posyandu_app/controller/auth_controller.dart';

class EditProfile extends StatefulWidget {
  final UserData userData;
  final Function(UserData updatedUserData) onUpdate;
  
  const EditProfile({Key? key, required this.userData, required this.onUpdate}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _validateAlamat = false;
  bool _validateTelepon = false;
  bool _validateNama = false;    

  late TextEditingController noKkController;
  late TextEditingController nikIbuController;
  late TextEditingController namaIbuController;
  late TextEditingController tempatLahirController;
  late TextEditingController tanggalLahirController;
  late TextEditingController golDarahIbuController;
  late TextEditingController nikAyahController;
  late TextEditingController namaAyahController;
  late TextEditingController alamatController;
  late TextEditingController teleponController;
  late TextEditingController emailController;

  UserData _getUpdatedUserData() {
    return UserData(
      noKk: widget.userData.noKk,
      nikIbu: widget.userData.nikIbu,
      namaIbu: namaIbuController.text,
      tempatLahirIbu: widget.userData.tempatLahirIbu,
      tanggalLahirIbu: widget.userData.tanggalLahirIbu,
      golDarahIbu: widget.userData.golDarahIbu,
      nikAyah: widget.userData.nikAyah,
      namaAyah: namaAyahController.text,
      alamat: alamatController.text,
      telepon: teleponController.text,
      emailOrangTua: widget.userData.emailOrangTua,
      updatedAt: widget.userData.updatedAt,
      createdAt: widget.userData.createdAt
    );
  }

@override
  void initState() {
    super.initState();
    noKkController = TextEditingController(text: widget.userData.noKk.toString());
    nikIbuController = TextEditingController(text: widget.userData.nikIbu);
    namaIbuController = TextEditingController(text: widget.userData.namaIbu);
    tempatLahirController = TextEditingController(text: widget.userData.tempatLahirIbu);
    tanggalLahirController = TextEditingController(text: widget.userData.tanggalLahirIbu);
    golDarahIbuController = TextEditingController(text: widget.userData.golDarahIbu);
    nikAyahController = TextEditingController(text: widget.userData.nikAyah);
    namaAyahController = TextEditingController(text: widget.userData.namaAyah);
    alamatController = TextEditingController(text: widget.userData.alamat);
    teleponController = TextEditingController(text: widget.userData.telepon);
    emailController = TextEditingController(text: widget.userData.emailOrangTua);
  }

  @override
  void dispose() {
    noKkController.dispose();
    nikIbuController.dispose();
    namaIbuController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    golDarahIbuController.dispose();
    nikAyahController.dispose();
    namaAyahController.dispose();
    alamatController.dispose();
    teleponController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F6ECD),
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0F6ECD),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: noKkController,
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Nomor Kartu Keluarga",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: nikIbuController,
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "NIK Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: namaIbuController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Nama Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateNama ? 'Nama tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateNama = true;
                        });
                        return 'Nama anda tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: tempatLahirController,
                            enabled: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0F6ECD),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF0F6ECD)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                              ),
                              hintText: "Tempat Lahir",
                              labelText: "Tempat Lahir",
                              labelStyle: const TextStyle(
                                color: Color(0xFF0F6ECD),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: tanggalLahirController,
                            enabled: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0F6ECD),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF0F6ECD)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                              ),
                              hintText: "Tanggal Lahir",
                              labelText: "Tanggal Lahir",
                              labelStyle: const TextStyle(
                                color: Color(0xFF0F6ECD),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: golDarahIbuController,
                    enabled : false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Golongan Darah Ibu",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                    controller: nikAyahController,
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "NIK Ayah",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                    controller: namaAyahController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Nama Ayah",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateNama ? 'Nama tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateNama = true;
                        });
                        return 'Nama anda tidak boleh kosong';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                    controller: alamatController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan alamat anda...",
                      labelText: "Alamat",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText:
                          _validateAlamat ? 'Alamat tidak boleh kosong' : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateAlamat = true;
                        });
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: teleponController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      hintText: "Masukkan nomor telepon anda...",
                      labelText: "Telepon",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      errorText: _validateTelepon
                          ? 'Nomor telepon tidak boleh kosong'
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _validateTelepon = true;
                        });
                        return 'Nomor telepon tidak boleh kosong';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF0F6ECD),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF0F6ECD)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      labelText: "Email",
                      labelStyle: const TextStyle(
                        color: Color(0xFF0F6ECD),
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F6ECD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await AuthController.updateProfile(
                            context,
                            namaIbuController,
                            namaAyahController,
                            alamatController,
                            teleponController,
                            );
                            if (success) {
                              AuthController.showSuccessUpdate(context);
                              UserData updatedUserData = _getUpdatedUserData();
                              widget.onUpdate(updatedUserData);
                              Navigator.pop(context);
                            } else {
                              AuthController.showErrorUpdate(context);
                            }
                          }
                        },
                      child: const Text(
                        "SIMPAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    ),
    );
  }
}
