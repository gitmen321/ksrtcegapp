// lib/main.dart
import 'package:flutter/material.dart';
import 'package:ksrtcegapp/screens/dashboard_screen.dart';
import 'package:ksrtcegapp/screens/login_screen.dart';
import 'package:ksrtcegapp/services/mongo_db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is properly initialized

  // Initialize the database connection
  DatabaseService dbService = DatabaseService();
  await dbService.connect(); // Connect to MongoDB

  if (dbService.isConnected()) {
    print("The app successfully connected to MongoDB!");
  } else {
    print("The app failed to connect to MongoDB.");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ksrtc App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: DashboardScreen(),
      home: LoginPage(),
      debugShowCheckedModeBanner: false, // Disable debug banner
    );
  }
}
