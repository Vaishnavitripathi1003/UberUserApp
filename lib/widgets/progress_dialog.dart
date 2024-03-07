import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
   String? msg;
   ProgressDialog({this.msg});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:Colors.black54 ,
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)
        ) ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(width:6.0,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),

              ),
              const SizedBox(width:26.0,),
              Text(
                msg!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
