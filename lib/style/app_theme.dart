import 'package:hafezi_quran_majeed/style/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Bengali',
        ),
        centerTitle: true,
        backgroundColor: AppColors.actionBarColor,
        foregroundColor: AppColors.whiteColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          minimumSize: Size(250, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Bengali',
          ),
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: AppColors.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.textColor,
          fontFamily: 'Bengali',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textColor,
          fontFamily: 'Bengali',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
