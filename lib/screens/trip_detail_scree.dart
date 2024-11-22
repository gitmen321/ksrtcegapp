import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksrtcegapp/constants/mongo_constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;



// TripDetailsScreen class
class TripDetailsScreen extends StatefulWidget {

 // final Map<String, dynamic> tripDetails;
  final String tripId;

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  Map<String, dynamic>? tripDetails;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadTripDetails();
  }

  Future<void> _loadTripDetails() async {
    final details = await fetchTripDetails(widget.tripId);
    setState(() {
      tripDetails = details;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Details',
          style: GoogleFonts.sahitya(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 5, 95, 151),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color.fromARGB(255, 203, 203, 188),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : tripDetails == null
            ? const Center(
          child: Text(
            'Failed to load trip details',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bus Number:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tripDetails?['bus_number'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Trip Route:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${tripDetails?['departure_location']?['name'] ?? 'N/A'} to ${tripDetails?['arrival_location']?['name'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Start Time:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tripDetails?['start_time'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'End Time:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tripDetails?['end_time'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Trip Type:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tripDetails?['trip_type'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Date:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 95, 151),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tripDetails?['start_date']?.toString().split('T')[0] ??
                    'N/A',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color.fromARGB(255, 5, 95, 151),
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
                      style: TextStyle(
                          fontSize: 16, color: Colors.white),
                    ),
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


// Function to fetch trip details from MongoDB
Future<Map<String, dynamic>?> fetchTripDetails(String tripId) async {
  String mongoUri = MongoConstants.mongoUrl;
  //  'mongodb+srv://<username>:<password>@ksrtc.obehd.mongodb.net/KSRTC';
  const String tripsCollectionName = 'trips';
  const String vehiclesCollectionName = 'vehicles';

  try {
    // Connect to the database
    final db = await mongo.Db.create(mongoUri);
    await db.open();

    // Access the trips collection
    final collection = db.collection(tripsCollectionName);

    // Fetch a single trip document using the trip ID
    final trip = await collection.findOne(mongo.where.eq('trip_id', tripId));

    // Convert ObjectId to String if necessary
    if (trip != null) {
      // Convert ObjectId to String
      trip['_id'] = trip['_id'].toHexString();
      trip['vehicle_id'] = trip['vehicle_id']?.toHexString();
      trip['driver_id'] = trip['driver_id']?.toHexString();
      trip['conductor_id'] = trip['conductor_id']?.toHexString();

      // Fetch bus number from vehicles collection
      if (trip['vehicle_id'] != null) {
        final vehiclesCollection = db.collection(vehiclesCollectionName);
        final vehicle = await vehiclesCollection
            .findOne(mongo.where.eq('_id', mongo.ObjectId.parse(trip['vehicle_id'])));

        // Add the bus number to the trip details
        trip['bus_number'] = vehicle?['BUSNO'] ?? 'N/A';
        //print(trip['bus_number']);
      }
    }


    await db.close();
    return trip;
  } catch (e) {
    print('Error fetching trip details: $e');
    return null;
  }
}
