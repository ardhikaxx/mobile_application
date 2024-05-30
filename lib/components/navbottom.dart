import 'package:flutter/material.dart';
import 'package:posyandu_app/home/dashboard_page.dart';
import 'package:posyandu_app/home/userprofile.dart';
import 'package:posyandu_app/home/education.dart';
import 'package:posyandu_app/home/grafik.dart';
import 'package:posyandu_app/home/imunisasi.dart';
import 'package:posyandu_app/model/user.dart';

class NavigationButtom extends StatefulWidget {
  final UserData userData;
  const NavigationButtom({super.key, required this.userData});

  @override
  State<NavigationButtom> createState() => _NavigationButtomState();
}

class _NavigationButtomState extends State<NavigationButtom> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late UserData userData;

  @override
  void initState() {
    userData = widget.userData;
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          DashboardPage(userData: widget.userData),
          Education(userData: widget.userData),
          Grafik(userData: widget.userData),
          Imunisasi(userData: widget.userData),
          Profile(userData: widget.userData),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F6ECD),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildNavBarItem(Icons.home, "Home", 0),
            _buildNavBarItem(Icons.article, "Edukasi", 1),
            _buildNavBarItem(Icons.insert_chart, "Grafik", 2),
            _buildNavBarItem(Icons.medical_services, "Imunisasi", 3),
            _buildNavBarItem(Icons.person_2_rounded, "Profile", 4),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF0F6ECD),
          unselectedItemColor: const Color(0xFF0F6ECD),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF0F6ECD) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 25,
          color: _selectedIndex == index ? Colors.white : const Color(0xFF0F6ECD),
        ),
      ),
      label: label,
    );
  }
}