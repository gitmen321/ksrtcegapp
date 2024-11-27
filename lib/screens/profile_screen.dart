import 'package:flutter/material.dart';
import 'package:ksrtcegapp/constants/mongo_constants.dart';
import 'package:ksrtcegapp/services/mongo_db_service.dart';
import 'package:ksrtcegapp/theme/pallet.dart';

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
      // backgroundColor: Pallet.gradientColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                  radius: 19,
                  backgroundImage: AssetImage('assets/logo/ktracimage.png')
                ),
                const SizedBox(width: 15),
              Text(
                'Profile',
                style: Theme.of(context).primaryTextTheme.titleMedium
              ),
            ],
          ),
          // backgroundColor: const Color.fromARGB(255, 5, 95, 151),
        ),
      ),
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Pallet.whiteColor,
              Pallet.redColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(
              color: Pallet.redColor,
            ))
            : driverDetails == null
            ? const Center(
          child: Text(
            'Failed to load driver details',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(20.0),
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
                style: Theme.of(context).primaryTextTheme.bodyMedium
              ),
              const SizedBox(height: 8),
              Text(
                'PEN: ${driverDetails?['PEN'] ?? 'N/A'}',
                style:Theme.of(context).primaryTextTheme.bodySmall
              ),
              const SizedBox(height: 8),
              Text(
                'Designation: ${driverDetails?['Designation '] ?? 'N/A'}',
                style: Theme.of(context).primaryTextTheme.bodySmall
              ),
             // print("designation fetched:${driverDetails['Designation']}");
              const SizedBox(height: 8),
              Text(
                'Unit: ${driverDetails?['UNIT'] ?? 'N/A'}',
                style: Theme.of(context).primaryTextTheme.bodySmall
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${driverDetails?['is_Permanent'] ?? 'N/A'}',
                style: Theme.of(context).primaryTextTheme.bodySmall
              ),
              const SizedBox(height: 8),
              Text(
                'Leave Status: ${driverDetails?['on_leave'] ?? 'N/A'}',
                style: Theme.of(context).primaryTextTheme.bodySmall
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallet.redColor,
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
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
