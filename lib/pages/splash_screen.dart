
import 'package:flutter/material.dart';
import 'package:hafezi_quran_majeed/pages/home_screen.dart';
import 'package:hafezi_quran_majeed/style/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    
    final prefs = await SharedPreferences.getInstance();
    prefs.getInt('last_read_page') ?? 0;
    
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 60,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'হাফেজী কুরআন মাজিীদ',
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Bengali',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'সহজে কুরআন তিলাওয়াত ও হিফজ করুন',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontFamily: 'Bengali',
              ),
            ),
            const SizedBox(height: 48),
            // লোডিং ইন্ডিকেটর
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      )
    );
  }
}