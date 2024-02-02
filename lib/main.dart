import 'package:ecoviary/utils/colors.dart';
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
          primary: MyColor.globalGreen0,
          onPrimary: MyColor.semanticNeutralPlus8,
          primaryContainer: MyColor.globalGreenPlus3,
          inversePrimary: MyColor.globalGreen3,
          tertiary: MyColor.globalBlue3,
          onTertiary: MyColor.semanticNeutralPlus8,
          tertiaryContainer: MyColor.globalBluePlus3,
          secondary: MyColor.semanticNeutral0,
          onSecondary: MyColor.semanticNeutralPlus1,
          secondaryContainer: MyColor.semanticNeutralPlus3,
          onSecondaryContainer: MyColor.semanticNeutral4,
          error: MyColor.globalRed3,
          onError: MyColor.semanticNeutralPlus8,
          errorContainer: MyColor.globalRedPlus3,
          brightness: Brightness.light,
          background: MyColor.semanticNeutralPlus6,
          onBackground: MyColor.semanticNeutral4,
          surface: MyColor.semanticNeutralPlus4,
          onSurface: MyColor.semanticNeutral4,
          inverseSurface: MyColor.semanticNeutral4,
          surfaceTint: MyColor.globalBlue0,
          outline: MyColor.semanticNeutralPlus2,
        ),
        textTheme: GoogleFonts.publicSansTextTheme(
          const TextTheme().copyWith(
            displayLarge: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: MyColor.semanticNeutral4,
            ),
            titleMedium: const TextStyle(
              fontSize: 10,
              color: MyColor.semanticNeutral4,
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: MyColor.globalGreen0,
            ),
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
            borderSide: const BorderSide(
              color: MyColor.semanticNeutralPlus3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColor.semanticNeutralPlus3,
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
