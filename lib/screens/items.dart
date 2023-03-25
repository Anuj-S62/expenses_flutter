import 'package:expenses_flutter/services/deleteitem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Items extends StatelessWidget {

  final String userId;
  const Items(this.userId);

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection("User").doc(userId);
    return StreamBuilder(
        stream: docRef.snapshots(),
      builder: (context,snapshot){
          // print((snapshot.data!)['itemarray']);
          if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState==ConnectionState.waiting){
            return Container(
              child: Center(child: Text("Data not found")),
            );
          }
          Object? data = snapshot.data;
          List itemList = (data as dynamic)['itemarray'];
          return itemList.isNotEmpty ? Column(
              children: itemList.map((mp) =>
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,8,10,8),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 30,
                        child: Icon(Icons.production_quantity_limits,color: Colors.grey[500],size: 35,),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0,3,0,7),
                        child: Text(mp['Itemname'].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.grey[200],letterSpacing: 1),),
                      ),
                      subtitle: Text("Price : " + (mp['Itemprice']).toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey[200])),
                      tileColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      trailing: DeleteItem(userId,mp)
                    ),
                  ),
                ),
              ).toList(),
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text("No Items",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300,color: Colors.grey[200])),
              const SizedBox(height: 10,)
            ],
          );
      },
    );
  }
}