import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksrtcegapp/constants/mongo_constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../services/mongo_db_service.dart';

// TripDetailsScreen class
class TripDetailsScreen extends StatefulWidget {
  final String pen;


  const TripDetailsScreen({super.key, required this.pen});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {

  List<Map<String, dynamic>>? trips;
  bool isLoading = true;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadTripDetails();
  }

  Future<void> _loadTripDetails() async {
    final details = await databaseService.fetchTripDetailsByPEN(widget.pen);
    setState(() {
      trips = details;
      print(trips);
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
              Color.fromARGB(255, 203, 203, 188),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : trips == null || trips!.isEmpty
            ? const Center(
          child: Text(
            'No trips found for this PEN',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: trips!.length,
          itemBuilder: (context, index) {
            final trip = trips![index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${index+1}'),
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
                      trip['bus_number'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      '${trip['departure_location']['depo']?? 'N/A'} to ${trip['arrival_location']['depo'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      trip['start_time'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      trip['end_time'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      trip['trip_type'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      trip['start_date']?.toString().split('T')[0] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }
}

