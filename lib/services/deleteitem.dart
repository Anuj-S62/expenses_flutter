import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteItem extends StatelessWidget {
  // const DeleteItem({Key? key}) : super(key: key);
  String userId;

  Map mp;
  DeleteItem(this.userId,this.mp, {super.key});

  @override
  Widget build(BuildContext context) {
    return   IconButton(
      onPressed: ()async{
        double temp = mp['Itemprice'];
        FirebaseFirestore.instance.collection('User').doc(userId).update({'Expenditure':FieldValue.increment(-1*temp)});
        FirebaseFirestore.instance.collection('User').doc(userId).update({
          'itemarray': FieldValue.arrayRemove([{'Itemprice': mp['Itemprice'], 'Itemname': mp['Itemname'], 'Itemid': mp['Itemid']}]),
        });
      },
      icon: Icon(Icons.delete,color: Colors.brown[100],size: 30),
    );
  }
}

