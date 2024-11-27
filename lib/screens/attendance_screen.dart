// lib/screens/attendance_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ksrtcegapp/theme/pallet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}


class _AttendanceScreenState extends State<AttendanceScreen> {

  String currentDate = DateFormat('dd - MMMM - yyyy').format(DateTime.now());
  double percentage = 0.0; 
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());
  String checkinTime = '';
  String buttonText = "Check In";
  bool isCheckedIn = false;
  DateTime? checkInDateTime;
  Timer? _timer;











   @override
  void initState() {
    super.initState();
    _loadCheckInStatus();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(title: Row(
          children: [
            const CircleAvatar(
                  radius: 19,
                  backgroundImage: AssetImage('assets/logo/ktracimage.png')
                ),
                const SizedBox(width: 10),
            Text('Attendance',style: Theme.of(context).primaryTextTheme.titleMedium,),
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.black, size: 18),
                const SizedBox(width: 10),
                Text(
                  currentDate,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 13.0,
              percent: percentage, // Dynamic percentage
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentTime,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text("Today",
                      style: TextStyle(fontSize: 16, color: Colors.white54)),
                ],
              ),
              progressColor: Pallet.redColor,
            ),
            const SizedBox(height: 15),
            // Check-in time display
            Text(
              checkinTime,
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            // Check In/Out Button
            ElevatedButton(
              onPressed: _onCheckInOutPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Pallet.redColor, // Button background color
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedIsCheckedIn = prefs.getBool('isCheckedIn');
    String? storedCheckInTime = prefs.getString('checkInDateTime');

    if (storedIsCheckedIn != null && storedCheckInTime != null) {
      setState(() {
        isCheckedIn = storedIsCheckedIn;
        checkInDateTime = DateTime.parse(storedCheckInTime);
        buttonText = isCheckedIn ? "Check Out" : "Check In";
        checkinTime = "Checked-in at ${DateFormat('hh:mm a').format(checkInDateTime!)}";
        if (isCheckedIn) {
          startTimer();
        }
      });
    }
  }

   Future<void> _saveCheckInStatus(bool isCheckedIn, DateTime? checkInDateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCheckedIn', isCheckedIn);
    if (checkInDateTime != null) {
      await prefs.setString('checkInDateTime', checkInDateTime.toIso8601String());
    }
  }

   Future<void> _clearCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isCheckedIn');
    await prefs.remove('checkInDateTime');
  }

   void startTimer() {
    const oneMinute = Duration(minutes: 1);
    _timer = Timer.periodic(oneMinute, (Timer timer) {
      setState(() {
        calculateProgress();
      });
    });
  }

    void _onCheckInOutPressed() async {

  if (!isCheckedIn) {
    // Check-in logic
    setState(() {
      isCheckedIn = true;
      buttonText = "Check Out";
      checkInDateTime = DateTime.now();
      checkinTime = "Checked-in at ${DateFormat('hh:mm a').format(checkInDateTime!)}";
      startTimer();
    });

    // Save the check-in status and time locally
    await _saveCheckInStatus(isCheckedIn, checkInDateTime);

    // Call the MongoDB check-in function

    _showToast("Attendance marked successfully");
  } else {
    // Check-out logic
    setState(() {
      isCheckedIn = false;
      buttonText = "Check In";
      _timer?.cancel(); // Stop the timer when checked out
      percentage = 0.0; // Reset the progress
    });

    // Clear the check-in status locally
    await _clearCheckInStatus();


    _showToast("Attendance mark ended successfully");
  }
}

  void calculateProgress() {
    if (checkInDateTime != null) {
        final now = DateTime.now();
        final elapsed = now.difference(checkInDateTime!).inMinutes; // Elapsed minutes since check-in

        // For testing: change 12 * 60 (720 minutes for 12 hours) to a smaller value
        const totalMinutes = 12 * 60; // For testing, set total to 12 minutes

        setState(() {
            percentage = elapsed / totalMinutes;
            if (percentage >= 1.0) {
                percentage = 1.0; // Cap at 100% once 12 minutes have passed (for testing)
                _timer?.cancel(); // Stop the timer when the period is over
            }
        });
    }
}

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

   @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }
}
