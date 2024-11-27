// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ksrtcegapp/screens/dashboard_screen.dart';
import 'package:ksrtcegapp/screens/login_screen.dart';
import 'package:ksrtcegapp/theme/pallet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Ksrtc App',
      theme: theme,
      home: const LoginPage(),
      // home: DashboardScreen(pen: 'pen'),
      debugShowCheckedModeBanner: false, // Disable debug banner
    );
  }
}
