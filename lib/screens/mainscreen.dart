import 'package:expenses_flutter/screens/drawer.dart';
import 'package:expenses_flutter/services/additem.dart';
import 'package:expenses_flutter/screens/budget.dart';
import 'package:expenses_flutter/screens/items.dart';
import 'package:expenses_flutter/services/singout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class MainScreen extends StatelessWidget {
  final String userId;
  MainScreen(this.userId);

  final ScrollController _controller = ScrollController();

  final db = FirebaseFirestore.instance;

  final Stream docRef = FirebaseFirestore.instance.collection("User").doc("Budget").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // print();
      stream: docRef,
      builder: (context,snapshot){
        print(userId);
        if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState==ConnectionState.waiting){
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: const Text("Expenses",style: TextStyle(color: Colors.grey,letterSpacing: 1),),
              backgroundColor: Colors.grey[900],
            ),
            drawer: AppDrawer(userId),
            body: Center(
              child: Text("Data Not Found",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 40,letterSpacing: 1,color: Colors.grey),),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: const Text("Expenses",style: TextStyle(color: Colors.grey,letterSpacing: 1),),
            backgroundColor: Colors.grey[900],
          ),
          drawer: AppDrawer(userId),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _controller,
            children: [
              Budget(userId!),
              const SizedBox(height: 10,),

              AddItem(userId!),
              Items(userId!),
            ],
          ),
        );
      },
    );
  }
}
