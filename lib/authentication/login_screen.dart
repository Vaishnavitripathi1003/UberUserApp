import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/splash_screen.dart';

import '../global/global.dart';
import '../mainScreens/main_screen.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController emailtextEditingController=TextEditingController();
 TextEditingController passwordtextEditingController=TextEditingController();


   validateForm(){
     if(!emailtextEditingController.text.contains("@gmail.com"))
     {
       Fluttertoast.showToast(msg: 'please enter valid mail',);
       //return false;
     }
     else if(!emailtextEditingController.text.isNotEmpty)
     {
       Fluttertoast.showToast(msg: 'please enter valid Password',);
       //  return false;
     }

     else
     {
       loginUserNow();
      // saveDriverInfoNow();
       /*showDialog(context: context,
            barrierDismissible: false,
            builder:(BuildContext c){
          return ProgressDialog(msg: "processing please wait........",);
            },
        );*/
     }
     // return true;
   }
   loginUserNow() async
   {
     showDialog(context: context,
       barrierDismissible: false,
       builder:(BuildContext c){
         return ProgressDialog(msg: "processing please wait........",);
       },
     );

     final User? firebaseuser=(
         await fAuth.signInWithEmailAndPassword(
             email: emailtextEditingController.text.trim(),
             password: passwordtextEditingController.text.trim()
         ).catchError((msg){
           Navigator.pop(context);
           Fluttertoast.showToast(msg: "Please Check Email or Password");
         })
     ).user;

     if(firebaseuser!=null)
     {currentFirebaseuser=firebaseuser;
       Fluttertoast.showToast(msg: "Login Success ");
       Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));

     }
     else
     {
       Navigator.pop(context);
       Fluttertoast.showToast(msg: "Please Check Email or Password");
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const  SizedBox(height: 20,),
            Padding(
               padding: const EdgeInsets.all(8.0),
                 child: Image.asset('images/logo.png'),
    ),
            const  SizedBox(height: 20,),
            const Text(
                "Login as a User",
                style:TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                )
            ),
            TextField(
              controller: emailtextEditingController,
              keyboardType: TextInputType.emailAddress,
              style:const  TextStyle(color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "E-Mail",
                hintText: "E-Mail",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize:10,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize:14,
                ),
              ),
            ),
            TextField(
              controller: passwordtextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style:const  TextStyle(color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "password",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize:10,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize:14,
                ),
              ),
            ),
            const  SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                validateForm();
               // Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));


              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
              ),
              child:Text(
                "LogIn",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18
                ),
              ),
            ),
            TextButton(
              child: const Text(
                "Do not  have an Account? SignUp here ",
                style: TextStyle(
                  color: Colors.grey,
                ),

              ),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));

            },
            ),

          ],
),
      ),
    );
  }
}
