import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

double? temp;

Future budgetDialog(context,userId) async{
  showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        backgroundColor: Colors.grey[900],
        title: Text("Set Budget",style: TextStyle(color: Colors.grey[200])),
        content: TextField(
          style: TextStyle(color: Colors.grey),
          keyboardType: TextInputType.number,
          onChanged: (text){
            temp = double.parse(text);
          },
        ),
        actions: [
          TextButton(
            child: Text("OK",style: TextStyle(color: Colors.brown[400]),),
            onPressed: (){
              if(temp!=null){FirebaseFirestore.instance.collection('User').doc(userId).update({'Budget':temp});}
              Navigator.of(context).pop();
            },

          )
        ],
      )
  );
}