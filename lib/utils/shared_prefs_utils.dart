// // lib/utils/shared_prefs.dart
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   static Future<void> saveTripStatus(bool isStarted) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('tripStatus', isStarted);
//   }

//   static Future<bool> getTripStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('tripStatus') ?? false;
//   }
// }
