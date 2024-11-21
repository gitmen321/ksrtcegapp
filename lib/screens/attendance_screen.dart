// lib/screens/attendance_screen.dart
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mark Your Attendance')),
      body: Center(
        child: Text(
          'Attendance Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
