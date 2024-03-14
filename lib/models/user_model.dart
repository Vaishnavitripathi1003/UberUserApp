import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? phone;
  String? name;
  String? id;
  String? email;
  String? password;
  UserModel({this.email, this.name, this.password,this.phone});

  UserModel.fromSnapshot(DataSnapshot snap) {

    id = snap.key;
    email = (snap.value as dynamic)["email"];
    name = (snap.value as dynamic)["name"];
    phone = (snap.value as dynamic)["phone"];
    password = (snap.value as dynamic)["password"];
  }
}
