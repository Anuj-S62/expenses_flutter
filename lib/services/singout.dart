import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_flutter/screens/login.dart';
import 'package:expenses_flutter/services/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12.0,10,12,10),
        child: ElevatedButton(
          onPressed: (){
            signOut();
            Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Login(),
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            elevation: 5,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // <-- Radius
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Text("SignOut",style: TextStyle(fontWeight: FontWeight.w500,letterSpacing: 2,color: Colors.grey[400],fontSize: 25),),
          ),
        )
    );;
  }
}

