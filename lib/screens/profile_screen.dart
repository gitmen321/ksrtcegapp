import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksrtcegapp/constants/mongo_constants.dart';
import 'package:ksrtcegapp/services/mongo_db_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// MongoDB constants
const String mongoUri = MongoConstants.mongoUrl; // Replace with your URI
const String driversCollectionName = "drivers";
const String conductorsCollectionName = "conductors";


// ProfileScreen widget
class ProfileScreen extends StatefulWidget {
  final String pen;

  const ProfileScreen({super.key, required this.pen});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Map<String, dynamic>? driverDetails;
  bool isLoading = true;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadDriverDetails();
  }

  Future<void> _loadDriverDetails() async {
    final details = await databaseService.fetchDriverDetails(widget.pen);
    //databaseService.fetchDriverDetails(widget.pen);
    setState(() {
      driverDetails = details;
      //print(driverDetails);
     // print(driverDetails?['Designation ']);
     // print(driverDetails.runtimeType);
     // driverDetails?.forEach((key, value) {
       // print('$key: $value');
      //});


      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 95, 151),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.sahitya(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 5, 95, 151),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color.fromARGB(255, 5, 95, 151),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : driverDetails == null
            ? const Center(
          child: Text(
            'Failed to load driver details',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/ksrtcblue.png"),
              ),
              const SizedBox(height: 20),
              Text(
                '${driverDetails?['EmployeeName'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'PEN: ${driverDetails?['PEN'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Designation: ${driverDetails?['Designation '] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
             // print("designation fetched:${driverDetails['Designation']}");
              const SizedBox(height: 8),
              Text(
                'Unit: ${driverDetails?['UNIT'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${driverDetails?['is_Permanent'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Leave Status: ${driverDetails?['on_leave'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 95, 151),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Text(
                    'Back to Dashboard',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Function to fetch driver details from MongoDB
