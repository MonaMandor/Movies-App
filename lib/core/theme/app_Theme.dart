// core/theme/app_Theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveText {
  static double responsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    // You can adjust the multiplier based on your design requirements
    double scaleFactor =
        screenWidth / 375.0; // Assuming the base design width is 375.0

    return (baseSize * scaleFactor).roundToDouble();
  }
}

class AppTheme {
  final BuildContext context;
  AppTheme(this.context);
  ThemeData get theme => ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 22),
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headlineMedium: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 20),
            fontWeight: FontWeight.w700,
            color: AppColors.primaryTextColor,
          ),
          headlineSmall: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 22),
            fontWeight: FontWeight.w500,
            color: AppColors.primaryTextColor,
          ),
          titleMedium: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
          /* bodyMedium: GoogleFonts.notoKufiArabic(
        fontSize: ResponsiveText.responsiveFontSize(context, 12),
            fontWeight: FontWeight.w400,
            color: AppColors.seventhTextColor,
          ), */
          /* bodyLarge:  GoogleFonts.notoKufiArabic(
             fontSize: ResponsiveText.responsiveFontSize(context, 14),
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryTextColor,
          ), */
          /*  bodySmall: 
          GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 13),
            fontWeight: FontWeight.w400,
            color: Color(0xFF444447),
          ), */
          labelLarge: GoogleFonts.notoKufiArabic(
              fontSize: ResponsiveText.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor),
          labelMedium: GoogleFonts.notoKufiArabic(
              fontSize: ResponsiveText.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w900,
              color: Colors.white),
          labelSmall: GoogleFonts.notoKufiArabic(
              fontSize: ResponsiveText.responsiveFontSize(context, 16),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor),
          bodySmall: GoogleFonts.notoKufiArabic(
              fontSize: ResponsiveText.responsiveFontSize(context, 13),
              fontWeight: FontWeight.w500,
              color: AppColors.primaryTextColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 12),
            fontWeight: FontWeight.w300,
            color: AppColors.primaryColor,
          ),
          labelStyle: GoogleFonts.notoKufiArabic(
            fontSize: ResponsiveText.responsiveFontSize(context, 16),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffoldBackground,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.fourthTextColor,
          
        ),
     
      );
}
