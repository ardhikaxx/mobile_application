import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_app/controller/auth_controller.dart';
import 'package:posyandu_app/home/editprofile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:posyandu_app/model/user.dart';

class Profile extends StatefulWidget {
  final UserData userData;
  const Profile({Key? key, required this.userData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserData userData;
  late String token;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
    token = AuthController.getToken();
    userData = widget.userData;
  }

  void _updateProfile(UserData updatedUserData) {
    setState(() {
      userData = updatedUserData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F6ECD),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: _buildProfileBody(token),
    );
  }

  Widget _buildProfileBody(String token) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0F6ECD),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userData.namaIbu,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      userData.nikIbu.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          _buildEditButton(),
          const SizedBox(height: 20),
          _buildLogoutButton(token),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>EditProfile(
                  userData: userData,
                  onUpdate: _updateProfile
                ),
                ),
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF3F8FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(right: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F6ECD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF0F6ECD), // Text color
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFF0F6ECD), size: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(String token) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            _showLogoutConfirmation(token);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF3F8FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(right: 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F6ECD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.logout, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFF0F6ECD),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(String token) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      title: 'Konfirmasi',
      desc: 'Apakah Anda yakin ingin logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await AuthController.logout(Get.context!, token);
      },
    ).show();
  }
}
