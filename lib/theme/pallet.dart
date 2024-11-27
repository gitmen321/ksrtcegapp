
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});


class Pallet {
  static const sharpBlue = Color.fromRGBO(0, 27, 230, 1);


  static const blackColor = Color.fromRGBO(0, 0, 0, 1);
  static const greyColor = Color.fromRGBO(68, 70, 70, 1);
  static const drawerColor = Color.fromRGBO(20, 19, 19, 1);
  static const whiteColor = Colors.white;
    static var redColor = const Color.fromARGB(255, 183, 22, 11);
  static var offredColor = const Color.fromARGB(255, 219, 45, 32);
  static var gradientColor = LinearGradient(colors: [whiteColor,redColor]);


  static const blueColor = Color.fromARGB(255, 0, 109, 181);
  static const orangColor = Color.fromARGB(255, 227, 126, 2);
  static const progressColor = Color.fromARGB(255, 68, 177, 255);
  static const yellowColor = Color.fromARGB(255, 255, 243, 68);
  static const offwhite = Color.fromARGB(255, 201, 212, 220);
  static const greenColor = Color.fromARGB(255, 18, 218, 0);
  static const offGreen = Color.fromARGB(255, 0, 249, 166);

  static const progresgreen = Color.fromARGB(255, 20, 139, 9);
  static const themeColor = Color.fromARGB(219, 44, 7, 1);

  static const greyColor2 = Colors.grey;

  static var appTheme = ThemeData(
    // scaffoldBackgroundColor: whiteColor,
    // cardColor: greyColor,
    appBarTheme:  AppBarTheme(
      elevation: 3.0,

      // shape:  const ContinuousRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(30),
      //         bottomRight: Radius.circular(30),
      //       ),
      //     ),
      backgroundColor:redColor ,
      iconTheme: const IconThemeData(
        
        color: whiteColor,
        size: 22,
        
      ),
    ),
    primaryTextTheme: TextTheme(
      titleMedium: GoogleFonts.sahitya(
                  color: whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
      bodyMedium:   GoogleFonts.sahitya(
                  color: blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),           
      bodySmall: GoogleFonts.lato(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),  


    ),
    buttonTheme: ButtonThemeData(
      buttonColor: redColor,
    ),
    // drawerTheme: const DrawerThemeData(
    //   backgroundColor: drawerColor,
    // ),
    // primaryColor: blackColor,
    iconTheme:  IconThemeData(
      color: Pallet.redColor,
      size: 30,

    ),

    // iconButtonTheme: const IconButtonThemeData(
    //   style: ButtonStyle(
    //     // backgroundColor: WidgetStatePropertyAll(Pallet.whiteColor),
    //     iconColor: WidgetStatePropertyAll(Pallet.whiteColor),
    //     iconSize: WidgetStatePropertyAll(30),
    //   ),
    // ),
  );
}
class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(Pallet.appTheme);
}