//import 'package:drivers_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users_app/splash_screen.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:FirebaseOptions(apiKey:
  'AIzaSyAMClwlG9nSpZlCIRkaiRqZebZYKBz5aDI', appId: '1:403230019954:android:3f2f12ec42e2bd098dcdeb', messagingSenderId: '403230019954', projectId: 'uber-ola-and-indriver-cl-c292a'));

  runApp( MyApp(
    child:MaterialApp(
      title: 'Drivers App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      home:const MySplashScreen(),
      debugShowCheckedModeBanner: false,

    ),


  ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({this.child});
  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key=UniqueKey();
  void restartApp()
  {
    setState(() {
      key= UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}



