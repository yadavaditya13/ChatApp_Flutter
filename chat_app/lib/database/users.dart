import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  String child = "users";

  void createUser(Map data) {
    _firebaseDatabase.reference().child(child).push().set(data);
  }
}
