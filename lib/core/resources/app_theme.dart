import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryColor,
      shape: CircleBorder()
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if(states.contains(WidgetState.selected)){
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorsManager.primaryColor
            );
          }
          return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorsManager.unselectedTab
          );
        },)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primaryColor,
      secondary: ColorsManager.secondaryColor,
      tertiary: ColorsManager.teritaryColor,
      onPrimary: ColorsManager.onPrimaryColor,
      onPrimaryContainer: ColorsManager.primaryColor,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: ColorsManager.fieldBorder,
      surface: ColorsManager.inputs,
      onPrimaryFixed: ColorsManager.primaryColor,
      onSurface: Colors.white,
      onSurfaceVariant: Colors.black,
      onTertiary: Colors.black,
      onTertiaryFixed: ColorsManager.unselectedTab,
      onSecondaryFixedVariant: ColorsManager.fieldBorder
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: ColorsManager.secondaryColor
      ),
      bodyMedium:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsManager.teritaryColor
      ),
        titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorsManager.primaryColor
        ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white
      ),
        labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorsManager.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: ColorsManager.primaryColor
        ),
      bodySmall: TextStyle(
        color: ColorsManager.hintTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400
      )
    )
  );
  static ThemeData darkTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.darkPrimaryColor,
          shape: CircleBorder()
      ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorsManager.darkBackgroundColor,
      indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if(states.contains(WidgetState.selected)){
            return TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorsManager.primaryColor
            );
          }
          return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorsManager.unselectedTab
          );
        },)

    ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
    scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
    colorScheme: ColorScheme.dark(
        primary: ColorsManager.darkPrimaryColor,
        secondary: ColorsManager.darkSecondaryColor,
        tertiary: ColorsManager.darkTeritaryColor,
        onPrimary: ColorsManager.darkOnPrimaryColor,
        onPrimaryContainer: Colors.white,
        onSecondaryContainer: ColorsManager.darkUnselected,
        onTertiaryContainer: ColorsManager.fieldBorderDark,
        surface: ColorsManager.darkInputs,
        onPrimaryFixed: Colors.white,
        onSurface: ColorsManager.primaryColor,
        onSurfaceVariant: Colors.white,
        onTertiary: ColorsManager.primaryColor,
        onTertiaryFixed: Colors.white,
        onSecondaryFixedVariant: ColorsManager.primaryColor
    ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorsManager.darkSecondaryColor
          ),
          bodyMedium:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorsManager.darkTeritaryColor
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
          labelMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorsManager.darkPrimaryColor,
            decoration: TextDecoration.underline,
            decorationColor: ColorsManager.darkPrimaryColor
          ),
          bodySmall: TextStyle(
              color: ColorsManager.darkTeritaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w400
          )
      )
  );
}