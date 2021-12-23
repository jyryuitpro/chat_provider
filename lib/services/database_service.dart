import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGES_COLLECTION = 'Messages';

class DatabaseService {
  final FirebaseStorage _db = FirebaseStorage.instance;

  DatabaseService() {}
}
