import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  // MongoDB URI
  static const String mongoDbUri = 'mongodb://johnseby:KSRTCFLEET@ksrtc-shard-00-00.obehd.mongodb.net:27017,ksrtc-shard-00-01.obehd.mongodb.net:27017,ksrtc-shard-00-02.obehd.mongodb.net:27017/KSRTC?authSource=admin&replicaSet=atlas-abcdef-shard-0&ssl=true&directConnection=true';

  
  // MongoDB Client
  late Db _db;

  // Connect to the database
  Future<void> connect() async {
    try {
      _db = Db(mongoDbUri);
      await _db.open();
      print("MongoDB Connected Successfully!");
    } catch (e) {
      print("Failed to connect to MongoDB: $e");
    }
  }

  // Check connection status
  bool isConnected() {
    return _db.isConnected;
  }

  // Close the connection
  Future<void> closeConnection() async {
    await _db.close();
    print("MongoDB Connection Closed.");
  }
}
