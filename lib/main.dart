import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ecoviary/ui/pages/main_tab_page.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await RealtimeDatabase.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
      title: 'EcoViary',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF0E4E30),
          onPrimary: Colors.white,
          primaryContainer: Color(0xFFC2EBD5),
          tertiary: Color(0xFF113997),
          onTertiary: Colors.white,
          tertiaryContainer: Color(0xFFCDDDFF),
          secondary: Color(0xFF555F6D),
          onSecondary: Color(0xFF555F6D),
          secondaryContainer: Color(0xFFCFD6DD),
          error: Color(0xFF6F2020),
          onError: Colors.white,
          errorContainer: Color(0xFFFCCFCF),
          brightness: Brightness.light,
          background: Colors.white,
          onBackground: Color(0xFF1B242C),
          surface: Colors.white,
          onSurface: Color(0xFF1B242C),
        ),
        useMaterial3: true,
      ),
      home: const MainTabPage(),
    );
  }
}
