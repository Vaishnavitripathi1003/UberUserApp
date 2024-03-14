import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nametextEditingController=TextEditingController();
  TextEditingController emailtextEditingController=TextEditingController();
  TextEditingController phonetextEditingController=TextEditingController();
  TextEditingController passwordtextEditingController=TextEditingController();

 /* bool*/ validateForm(){
    if(nametextEditingController.text.length<3)
      {
        Fluttertoast.showToast(msg: 'please fill atleast 3 characters',);
        //return false;
      }
    else if(!emailtextEditingController.text.contains("@gmail.com"))
      {
        Fluttertoast.showToast(msg: 'please enter valid mail',);
      //  return false;
      }
    else if(phonetextEditingController.text.isEmpty || phonetextEditingController.text.length<10)
    {
      Fluttertoast.showToast(msg: 'please enter valid number',);
    //  return false;
    }
    else if(passwordtextEditingController.text.isEmpty || phonetextEditingController.text.length<6)
    {
    Fluttertoast.showToast(msg: 'please enter atleast 6 letters ',);
   // return false;
    }
    else
      {
        saveUserInfoNow();
        /*showDialog(context: context,
            barrierDismissible: false,
            builder:(BuildContext c){
          return ProgressDialog(msg: "processing please wait........",);
            },
        );*/
      }
   // return true;
  }
  saveUserInfoNow() async
  {
    showDialog(context: context,
      barrierDismissible: false,
      builder:(BuildContext c){
        return ProgressDialog(msg: "processing please wait........",);
      },
    );

    final User? firebaseuser=(
        await fAuth.createUserWithEmailAndPassword(
            email: emailtextEditingController.text.trim(),
            password: passwordtextEditingController.text.trim()
        ).catchError((msg){
               Navigator.pop(context);
               Fluttertoast.showToast(msg: "Error "+msg.toString());
        })
    ).user;

    if(firebaseuser!=null)
      {
          Map usersMap={
          "id":firebaseuser.uid,
          "name":nametextEditingController.text.trim(),
          "email":emailtextEditingController.text.trim(),
          "phone":phonetextEditingController.text.trim(),
            "password":passwordtextEditingController.text.trim(),
          };
         DatabaseReference driverref= FirebaseDatabase.instance.ref().child("users");
          driverref.child(firebaseuser.uid).set(usersMap);
          currentFirebaseuser=firebaseuser;
          Fluttertoast.showToast(msg: "Account  created ");
       Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));

      }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account not created ");
      }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Register"),
        backgroundColor: Colors.grey,

      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
             const  SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/logo.png'),
              ),
              const  SizedBox(height: 10,),
              const Text(
               "Register as a user",
                   style:TextStyle(
                     fontSize: 24,
                     color: Colors.grey,
                     fontWeight: FontWeight.bold
                   )
              ),
              TextField(
                controller: nametextEditingController,
                style:const  TextStyle(color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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
                controller: phonetextEditingController,
                keyboardType: TextInputType.number,
                style:const  TextStyle(color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
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
                /* if(validateForm()) {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));

                 }*/


                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                child:Text(
                 "Create Account",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18
                  ),
              ),
              ),
              TextButton(
                child: const Text(
                  "Already have an Account? Login here ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),

                ),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));

                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
