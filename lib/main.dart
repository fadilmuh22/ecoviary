import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecoviary/ui/pages/main_tab_page.dart';
import 'package:ecoviary/data/services/realtime_database.dart';

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
          primary: Color(0xFF1D7C4D),
          onPrimary: Color(0xFFFBFCFD),
          primaryContainer: Color(0xFFC2EBD5),
          inversePrimary: Color(0xFF0E4E30),
          tertiary: Color(0xFF113997),
          onTertiary: Color(0xFFFBFCFD),
          tertiaryContainer: Color(0xFFCDDDFF),
          secondary: Color(0xFF555F6D),
          onSecondary: Color(0xFF555F6D),
          secondaryContainer: Color(0xFFCFD6DD),
          error: Color(0xFF6F2020),
          onError: Color(0xFFFBFCFD),
          errorContainer: Color(0xFFFCCFCF),
          brightness: Brightness.light,
          background: Color(0xFFFBFCFD),
          onBackground: Color(0xFF1B242C),
          surface: Color(0xFFFBFCFD),
          onSurface: Color(0xFF1B242C),
          inverseSurface: Color(0xFF7E8B99),
          surfaceTint: Color(0xFF3062D4),
          outline: Color(0xFF9EA8B3),
        ),
        textTheme: GoogleFonts.publicSansTextTheme(
          const TextTheme().copyWith(
            displayLarge: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            titleMedium: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          hintStyle: const TextStyle(
            fontSize: 12,
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainTabPage(),
    );
  }
}
