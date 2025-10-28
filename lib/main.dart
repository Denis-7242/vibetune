import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/theme_provider.dart';
import 'providers/player_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const VibeTuneApp());
}

class VibeTuneApp extends StatelessWidget {
  const VibeTuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'VibeTune',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme.copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                themeProvider.lightTheme.textTheme,
              ),
            ),
            darkTheme: themeProvider.darkTheme.copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                themeProvider.darkTheme.textTheme,
              ),
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}