// // lib/services/mongo_service.dart
// import 'package:http/http.dart' as http;
// import '../constants/mongo_constants.dart';
// import '../models/location_model.dart';

// class MongoService {
//   static Future<void> storeLocation(LocationModel location) async {
//     const url = "${MongoConstants.mongoUrl}/location_collection";
//     final response = await http.post(
//       Uri.parse(url),
//       body: location.toJson(),
//     );

//     if (response.statusCode == 200) {
//       print("Location stored successfully!");
//     } else {
//       print("Failed to store location: ${response.body}");
//     }
//   }
// }
