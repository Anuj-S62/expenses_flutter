import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class AddItem extends StatefulWidget {
  String userId;
  AddItem(this.userId);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  final db = FirebaseFirestore.instance;


  String? itemName;
  double? itemPrice;
  double qty = 1;

  Future itemDialog() async{
    final Stream docRef = FirebaseFirestore.instance.collection("User").doc(widget.userId).snapshots();    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          backgroundColor: Colors.grey[900],
          title: Text("Add Item",style: TextStyle(color: Colors.grey[300])),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.grey,letterSpacing: 1),
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(
                      color: Colors.brown, //<-- SEE HERE
                    ),
                  ),
                  onChanged: (text){
                    setState(() {
                      itemName = text;
                    });
                  },
                ),

                TextField(
                  style: TextStyle(color: Colors.grey,letterSpacing: 1),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Item Price',
                    labelStyle: TextStyle(
                      color: Colors.brown, //<-- SEE HERE
                    ),
                  ),
                  onChanged: (text){
                    setState(() {
                      itemPrice = double.parse(text);
                    });
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.grey,letterSpacing: 1),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Item Quantity',
                    labelStyle: TextStyle(
                      color: Colors.brown, //<-- SEE HERE
                    ),
                  ),
                  onChanged: (text){
                    setState(() {
                      qty = double.parse(text);
                    });
                  },
                ),
              ],
            ),
          ),


          actions: [
            TextButton(
              child: Text("OK",style: TextStyle(color: Colors.brown[400]),),
              onPressed: (){
                if(itemName!=null && itemPrice!=null) {
                  int Itemid = Random().nextInt(1000);
                  FirebaseFirestore.instance.collection('User')
                      .doc(widget.userId)
                      .update({
                    'itemarray': FieldValue.arrayUnion(
                        [{'Itemprice': (itemPrice!*qty), 'Itemname': itemName! + " x $qty",'Itemid':Itemid }]),
                  });
                  db.collection('User').doc(widget.userId).update({'Expenditure':FieldValue.increment(itemPrice!*qty)});
                  setState(() {
                    itemName = null;
                    itemPrice = null;
                    qty = 1;
                  });
                }
                Navigator.of(context).pop();
              },

            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12.0,10,12,10),
        child: ElevatedButton(
          onPressed: (){
            itemDialog();
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
            child: Text("Add Item",style: TextStyle(fontWeight: FontWeight.w500,letterSpacing: 2,color: Colors.grey[400],fontSize: 25),),
          ),
        )
    );
  }
}
