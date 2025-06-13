import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: Color(AppConstants.primaryColor),
        secondary: Color(AppConstants.secondaryColor),
        tertiary: Color(AppConstants.accentColor),
        error: Color(AppConstants.errorColor),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: TextStyle(
          fontSize: AppConstants.headingFontSize * 1.5,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: AppConstants.headingFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: AppConstants.subheadingFontSize,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.bodyFontSize,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.bodyFontSize * 0.9,
          color: Colors.black87,
        ),
        bodySmall: TextStyle(
          fontSize: AppConstants.captionFontSize,
          color: Colors.black54,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: AppConstants.subheadingFontSize,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Color(AppConstants.primaryColor)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppConstants.primaryColor),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.largePadding,
            vertical: AppConstants.defaultPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(AppConstants.primaryColor),
          side: BorderSide(color: Color(AppConstants.primaryColor), width: 2),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.largePadding,
            vertical: AppConstants.defaultPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.buttonBorderRadius,
            ),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(AppConstants.primaryColor),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.smallPadding,
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.defaultPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Color(AppConstants.primaryColor),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Color(AppConstants.errorColor),
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          borderSide: BorderSide(
            color: Color(AppConstants.errorColor),
            width: 2,
          ),
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        color: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(AppConstants.primaryColor),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100],
        selectedColor: Color(AppConstants.primaryColor),
        labelStyle: GoogleFonts.poppins(
          fontSize: AppConstants.captionFontSize,
          fontWeight: FontWeight.w500,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.smallPadding,
          vertical: AppConstants.smallPadding / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
      ),
    );
  }
}
