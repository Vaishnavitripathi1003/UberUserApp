import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/user_model.dart';

class AssistantMethods {
  static void readCurrentOnlineUserInfo() {
    currentFirebaseuser = fAuth.currentUser;
    //get detail of user who is online
    DatabaseReference userref =
        FirebaseDatabase.instance.ref().child(currentFirebaseuser!.uid);
    userref.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        Fluttertoast.showToast(msg: "name=" + userModelCurrentInfo!.name.toString());

      }
    });
  }
}
