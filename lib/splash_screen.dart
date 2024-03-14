import 'dart:async';

/*
import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/mainScreens/main_screen.dart';
*/
import 'package:flutter/material.dart';
import 'package:users_app/authentication/signup_screen.dart';

import 'assistants/assistant_methods.dart';
import 'authentication/login_screen.dart';
import 'global/global.dart';
import 'mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    fAuth.currentUser != null
        ? 6
        : null;
    Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseuser = fAuth.currentUser;
        //send user to home screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        //send user to home screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),
              SizedBox(
                height: 10,
              ),
              Text(
                "Uber & indriver Clone App",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
