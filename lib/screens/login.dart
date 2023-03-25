import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_flutter/screens/mainscreen.dart';
import 'package:expenses_flutter/screens/signup.dart';
import 'package:expenses_flutter/services/authenticate.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String currUser = "";
  dynamic data;
  // Future<String> check(String temp)async{
  //   dynamic data = await FirebaseFirestore.instance.collection("User").doc('currUser').get();
  //   print(data['Curruserid']);
  //   return data['Curruserid'];
  // }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: TextStyle(color: Colors.grey, letterSpacing: 1),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey[900],
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Center(
                  child: Container(
                    height: 400,
                    width: 300,
                    // color: Colors.grey[800],
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      color: Colors.grey[800],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ), //BoxShadow
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 15, 12, 15),
                      child: ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Center(
                                child: Text(
                                  "MEMBER LOGIN",
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      color: Colors.grey[500]),
                                )),
                          ),
                          Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: _emailController,
                                        style: TextStyle(fontSize: 20,
                                            color: Colors.grey[200]),
                                        decoration: const InputDecoration(
                                          // labelText: "Username", //babel text
                                          hintText: "Enter your email",
                                          //hint text
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.5),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.people, color: Colors.grey,),
                                          //prefix iocn
                                          hintStyle: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors
                                                  .grey), //hint text style//label style
                                        )
                                      // initialValue: "Text"
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: _passwordController,
                                        style: TextStyle(fontSize: 20,
                                            color: Colors.grey[200]),
                                        decoration: const InputDecoration(
                                          // labelText: "Username", //babel text
                                          hintText: "Password",
                                          //hint text
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.5),
                                          ),
                                          prefixIcon: Icon(Icons.key_outlined,
                                            color: Colors.grey,),
                                          //prefix iocn
                                          hintStyle: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors
                                                  .grey), //hint text style//label style
                                        )
                                      // initialValue: "Text"
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                      color: Colors.grey[700],
                                    ),
                                    margin: const EdgeInsets.only(
                                        top: 20.0
                                    ),
                                    // color: Colors.grey[700],
                                    child: TextButton(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[300]
                                        ),
                                      ),
                                      onPressed: () async {
                                        String? UserId = await SignIn(
                                            _emailController.text,
                                            _passwordController.text);
                                        if (UserId == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              const SnackBar(
                                                  content: Text("Can't Login")));
                                        }
                                        else {
                                          print("hello");
                                          Navigator.pushReplacement<void, void>(
                                              context,
                                              MaterialPageRoute<void>(
                                              builder: (BuildContext context) => MainScreen(UserId),
                                        ));
                                        }
                                      },
                                      // color: Colors.blue,
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      color: Colors.grey[900],
                    ),
                    margin: const EdgeInsets.only(
                        top: 20.0
                    ),
                    // color: Colors.grey[700],
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(
                            "Don't Have an Account ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w200
                            ),
                          ),
                          Text("SignUp ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w900
                          ),),
                          Text("Here!",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w200
                            ),)
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),);
                      },
                      // color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
