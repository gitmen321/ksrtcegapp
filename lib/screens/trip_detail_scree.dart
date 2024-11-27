import 'package:flutter/material.dart';
import 'package:ksrtcegapp/theme/pallet.dart';

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
              Text('Trip Details',
                  style: Theme.of(context).primaryTextTheme.titleMedium,),
            ],
          ),
        ),
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
            ?  Center(child: CircularProgressIndicator(
              color: Pallet.redColor,
            ))
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
                              Text('${index + 1}', style: Theme.of(context).primaryTextTheme.bodyMedium,),
                               Text(
                                'Bus Number:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                trip['bus_number'] ?? 'N/A',
                                style:Theme.of(context).primaryTextTheme.bodySmall
                              ),
                              const SizedBox(height: 10),
                               Text(
                                'Trip Route:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${trip['departure_location']['depo'] ?? 'N/A'} to ${trip['arrival_location']['depo'] ?? 'N/A'}',
                                style:Theme.of(context).primaryTextTheme.bodySmall
                              ),
                              const SizedBox(height: 10),
                               Text(
                                'Start Time:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                trip['start_time'] ?? 'N/A',
                                style:Theme.of(context).primaryTextTheme.bodySmall
                              ),
                              const SizedBox(height: 10),
                               Text(
                                'End Time:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                trip['end_time'] ?? 'N/A',
                                style:Theme.of(context).primaryTextTheme.bodySmall
                              ),
                              const SizedBox(height: 10),
                               Text(
                                'Trip Type:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                trip['trip_type'] ?? 'N/A',
                                style:Theme.of(context).primaryTextTheme.bodySmall
                              ),
                              const SizedBox(height: 10),
                               Text(
                                'Date:',
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                trip['start_date']?.toString().split('T')[0] ??
                                    'N/A',
                                style:Theme.of(context).primaryTextTheme.bodySmall
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
