import 'package:dlgc_hymnal/features/home/home_screen.dart';
import 'package:dlgc_hymnal/core/services/settings_service.dart';
import 'package:dlgc_hymnal/core/providers/theme_provider.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await SettingsService.init();
  } catch (e) {
    print('Settings initialization failed: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextSizeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Divine Love Gospel Hymnal',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(initialIndex: 0),
          );
        },
      ),
    );
  }
}