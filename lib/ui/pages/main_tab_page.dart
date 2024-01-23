import 'package:ecoviary/ui/pages/automation_page.dart';
import 'package:ecoviary/ui/pages/control_page.dart';
import 'package:ecoviary/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showUnselectedLabels: false,
        iconSize: 24,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FlutterRemix.home_2_fill),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterRemix.remote_control_fill),
            label: 'Kontrol',
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterRemix.git_merge_fill),
            label: 'Otomasi',
          ),
        ],
      ),
    );
  }
}
