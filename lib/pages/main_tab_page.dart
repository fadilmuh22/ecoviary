import 'package:ecoviary/pages/automation_page.dart';
import 'package:ecoviary/pages/control_page.dart';
import 'package:ecoviary/pages/home_page.dart';
import 'package:ecoviary/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _selectedIndex = 0;

  Widget getPage() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ControlPage();
      case 2:
        return const AutomationPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getPage()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_ethernet),
            label: 'Automation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
