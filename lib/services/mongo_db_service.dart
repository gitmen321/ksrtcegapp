import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:ksrtcegapp/constants/mongo_constants.dart';

class DatabaseService {
  // MongoDB URI
  static const String mongoDbUri = 'mongodb://johnseby:KSRTCFLEET@ksrtc-shard-00-00.obehd.mongodb.net:27017,ksrtc-shard-00-01.obehd.mongodb.net:27017,ksrtc-shard-00-02.obehd.mongodb.net:27017/KSRTC?authSource=admin&replicaSet=atlas-abcdef-shard-0&ssl=true&directConnection=true';

  
  // MongoDB Client
 // late Db _db;

  // Connect to the database
  // Future<void> connect() async {
  //   try {
  //     _db = Db(mongoDbUri);
  //     await _db.open();
  //     print("MongoDB Connected Successfully!");
  //   } catch (e) {
  //     print("Failed to connect to MongoDB: $e");
  //   }
  // }

  // Check connection status
  // bool isConnected() {
  //   return _db.isConnected;
  // }

  // Close the connection
  // Future<void> closeConnection() async {
  //   await _db.close();
  //   print("MongoDB Connection Closed.");
  // }



 // import 'package:mongo_dart/mongo_dart.dart' as mongo;


  /// Standalone function to validate login
  Future<String?> validateLogin(String pen) async {
    final String mongoUri = MongoConstants.mongoUrl; // Replace with your MongoDB URI
    final String driversCollectionName = "drivers";
    final String conductorsCollectionName = "conductors";

    try {
      final db = await mongo.Db.create(mongoUri);
      await db.open();
      print("MongoDB Connected Successfully!");

      // Check in drivers collection
      final driversCollection = db.collection(driversCollectionName);
      final driver = await driversCollection.findOne(mongo.where.eq('PEN', pen));
      if (driver != null) {
        await db.close();
        print("MongoDB Connection Closed.");
        return pen; // Return PEN if found in drivers collection
      }

      // Check in conductors collection
      final conductorsCollection = db.collection(conductorsCollectionName);
      final conductor = await conductorsCollection.findOne(mongo.where.eq('PEN', pen));
      if (conductor != null) {
        await db.close();
        return pen; // Return PEN if found in conductors collection
      }

      await db.close();
      return null; // Return null if PEN is not found
    } catch (e) {
      print("Error during login validation: $e");
      return null;
    }
  }


}
