import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:expenses_flutter/services/setbudget.dart';

class Budget extends StatefulWidget {
  final String ?userId;
  const Budget(this.userId);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  final db = FirebaseFirestore.instance;

  @override

  Widget build(BuildContext context) {
    final Stream docRef = FirebaseFirestore.instance.collection("User").doc(widget.userId).snapshots();
    // print(docRef);
    return StreamBuilder(
      stream: docRef,
      builder: (context,snapshot){
        if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState==ConnectionState.waiting){
          return Container(
            height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              child: Center(child: const Text("Data not found")));
        }
        return Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 25,color: Colors.brown ),
                        onPressed: () {
                          budgetDialog(context,widget.userId);
                        },
                      ),
                      Text("Monthly Budget:",style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 23,
                          color: Colors.grey[200],
                          letterSpacing: 1

                      ),),
                    ],
                  ),

                  Text("Rs ${(snapshot.data['Budget'])}",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                      color: Colors.grey[200]

                  ),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.wallet, size: 25,color: Colors.brown ),
                        onPressed: () {
                        },
                      ),
                      Text("Expenditure:",style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 23,
                          color: Colors.grey[200],
                          letterSpacing: 1

                      ),),
                    ],
                  ),

                  Text("Rs ${(snapshot.data['Expenditure'])}",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                      color: Colors.grey[200]

                  ),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.account_balance_rounded, size: 25,color: Colors.brown ,),
                        onPressed: () {
                          // ...
                        },
                      ),
                      Text("Remaining:",style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 23,
                          color: Colors.grey[200],
                          letterSpacing: 1

                      ),),
                    ],
                  ),
                  Text("Rs ${snapshot.data['Budget'] - snapshot.data['Expenditure']}",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                      color: Colors.grey[200]
                  ),)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
