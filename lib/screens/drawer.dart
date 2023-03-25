import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_flutter/services/authenticate.dart';
import 'package:expenses_flutter/services/singout.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class AppDrawer extends StatelessWidget {
  // const AppDrawer({Key? key}) : super(key: key);
  final String userId;
  AppDrawer(this.userId);
  @override

  Widget build(BuildContext context) {
    final Stream docRef = FirebaseFirestore.instance.collection("User").doc(userId).snapshots();
    return StreamBuilder(
        stream: docRef,
        builder: (context,snapshot) {
          if (!snapshot.hasData || snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width,
                width: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Center(child: const Text("Data not found")));
          }
          return Drawer(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Expenses",style: TextStyle(color: Colors.grey,letterSpacing: 1),),
                backgroundColor: Colors.grey[900],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[900],
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/50,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey[800]
                                ),
                                child: Center(child: Text(snapshot.data['Name'][0].toString().capitalized,style: TextStyle(color: Colors.grey[300],fontSize: 50),)),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18.0,0,0,0),
                              child: Text(snapshot.data['Name'].toString().toUpperCase(),style: TextStyle(color: Colors.grey[300],fontSize: 20,letterSpacing: 2),),
                            )

                          ],
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.grey[800],
                      height: MediaQuery.of(context).size.height*(0.7329),
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed:()=> Navigator.pushNamed(context, "/chatscreen"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[800],
                                        elevation: 0
                                    ),

                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_outlined,size: 25,color: Colors.grey[300],),
                                        Text(" Chat",style: TextStyle(fontSize: 20,color: Colors.grey[300]),)
                                      ],
                                    )

                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ElevatedButton(onPressed: signOut,
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[800],
                                      elevation: 0
                                    ),

                                    child: Row(
                                      children: [
                                        Icon(Icons.logout,size: 25,color: Colors.grey[300],),
                                        Text(" Logout",style: TextStyle(fontSize: 20,color: Colors.grey[300]),)
                                      ],
                                    )

                                )
                                // EButton(onPressed: signOut, icon: Icon(Icons.logout,size: 25,),),
                                // Text("Logout",style: TextStyle(fontSize: 20,color: Colors.brown[900]),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }); //Drawer;
  }
}
