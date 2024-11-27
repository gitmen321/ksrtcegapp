import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartJourneyScreen extends StatefulWidget {
  @override
  _StartJourneyScreenState createState() => _StartJourneyScreenState();
}

class _StartJourneyScreenState extends State<StartJourneyScreen> {
  bool isJourneyStarted = false;
  bool isJourneyStopped = false;

  @override
  void initState() {
    super.initState();
    _loadJourneyStatus();
  }

  Future<void> _loadJourneyStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isJourneyStarted = prefs.getBool('isJourneyStarted') ?? false;
      isJourneyStopped = prefs.getBool('isJourneyStopped') ?? false;
    });
  }

  Future<void> _saveJourneyStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isJourneyStarted', isJourneyStarted);
    await prefs.setBool('isJourneyStopped', isJourneyStopped);
  }

  Future<bool> _showConfirmationDialog(String action) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("$action Journey"),
            content: Text("Are you sure you want to $action the journey?"),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: Text("Yes"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _handleStartTrip() async {
    if (isJourneyStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You already started your journey!")),
      );
      return;
    }

    final confirmed = await _showConfirmationDialog("Start");
    if (confirmed) {
      setState(() {
        isJourneyStarted = true;
        isJourneyStopped = false; // Reset stop state
      });
      await _saveJourneyStatus();
    }
  }

  void _handleStopTrip() async {
    if (isJourneyStopped) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You already stopped your journey!")),
      );
      return;
    }

    final confirmed = await _showConfirmationDialog("Stop");
    if (confirmed) {
      setState(() {
        isJourneyStopped = true;
        isJourneyStarted = false; // Reset start state
      });
      await _saveJourneyStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                  radius: 19,
                  backgroundImage: AssetImage('assets/logo/ktracimage.png')
                ),
                const SizedBox(width: 10),
              Text('Start Journey',
                  style: Theme.of(context).primaryTextTheme.titleMedium),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                backgroundColor: const Color.fromARGB(255, 52, 105, 2),
              ),
              onPressed: _handleStartTrip,
              child: const Text(
                'Start Your Trip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                backgroundColor: const Color.fromARGB(255, 207, 14, 14),
              ),
              onPressed: _handleStopTrip,
              child: const Text(
                'Stop Your Trip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
