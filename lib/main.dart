import 'package:flutter/services.dart';
import 'package:hafezi_quran_majeed/pages/bookmark_screen.dart';
import 'package:hafezi_quran_majeed/pages/home_screen.dart';
import 'package:hafezi_quran_majeed/pages/para_screen.dart';
import 'package:hafezi_quran_majeed/pages/reading_screen.dart';
import 'package:hafezi_quran_majeed/pages/splash_screen.dart';
import 'package:hafezi_quran_majeed/pages/sura_screen.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:material_ui/material_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'হাফেজী কুরআন মাজীদ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => const SplashScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/reading_screen': (context) => const ReadingScreen(),
        '/para_screen': (context) => const ParaScreen(),
        '/sura_screen': (context) => const SuraScreen(),
        '/bookmark_screen':(context) => const BookmarkScreen(),
      },
    );
  }
}