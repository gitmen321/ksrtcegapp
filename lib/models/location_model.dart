// lib/models/location_model.dart
class LocationModel {
  final String driverId;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationModel({
    required this.driverId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
