import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_flutter/screens/login.dart';
import 'package:expenses_flutter/screens/mainscreen.dart';
import 'package:expenses_flutter/services/authenticate.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String userID;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

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
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    height: 550,
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
                              "SIGN UP",
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
                                  controller: _usernameController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[200]),
                                  decoration: const InputDecoration(
                                    // labelText: "Username", //babel text
                                    hintText: "UserName", //hint text
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
                                      Icons.people,
                                      color: Colors.grey,
                                    ), //prefix iocn
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors
                                            .grey), //hint text style//label style
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[200]),
                                  decoration: const InputDecoration(
                                    // labelText: "Username", //babel text
                                    hintText: "Enter your email", //hint text
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
                                      Icons.people,
                                      color: Colors.grey,
                                    ), //prefix iocn
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors
                                            .grey), //hint text style//label style
                                  ),
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _emailController.text = value.toString();
                                  //   });
                                  // },
                                  // initialValue: "Text"
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[200]),
                                  decoration: const InputDecoration(
                                    // labelText: "Username", //babel text
                                    hintText: "Password", //hint text
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
                                      Icons.key_outlined,
                                      color: Colors.grey,
                                    ), //prefix iocn
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors
                                            .grey), //hint text style//label style
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _confirmPassController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[200]),
                                  decoration: const InputDecoration(
                                    hintText: "Confirm Password", //hint text
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
                                      Icons.key_outlined,
                                      color: Colors.grey,
                                    ), //prefix iocn
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors
                                            .grey), //hint text style//label style
                                  ),
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
                                margin: const EdgeInsets.only(top: 20.0),
                                // color: Colors.grey[700],
                                child: TextButton(
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey[300]),
                                  ),
                                  onPressed: () async{
                                    String? navi;
                                    if (_passwordController.text != _confirmPassController.text) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text("Password not matching")));
                                    } else if (_passwordController.text.length < 6) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text(
                                              "Password should be at least 6 characters")));
                                    }
                                    else if(_usernameController.text.length<=0){
                                      const SnackBar(
                                          content: Text("UserName cannot be empty"));
                                    }
                                    else{
                                      navi = await register(_usernameController.text, _emailController.text, _passwordController.text);
                                      if(navi!=null){
                                        userID = navi;
                                        print(userID);
                                        CollectionReference db = FirebaseFirestore.instance.collection("User");
                                          // Call the user's CollectionReference to add a new user
                                          await db.doc(userID)
                                              .set({
                                            'Budget' : 0.0,
                                            'Expenditure': 0.0, // John Doe
                                            'itemarray' : [], // Stokes and Sons
                                            'Name' : _usernameController.text // 42
                                          })
                                              .then((value) => Navigator.pushReplacement<void, void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (BuildContext context) => MainScreen(userID),
                                              ))
                                              .catchError((error) => print("Failed to add user: $error")));
                                        _emailController.clear();
                                        _passwordController.clear();
                                        // _usernameController.clear();
                                        _confirmPassController.clear();
                                      }
                                    }
                                    // FirebaseFirestore
                                  },
                                  // color: Colors.blue,
                                ),
                              )
                            ],
                          ))
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
                    margin: const EdgeInsets.only(top: 20.0),
                    // color: Colors.grey[700],
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(
                            "Already Have an Account ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w200
                            ),
                          ),
                          Text("SignIn ",
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
                      onPressed: () async {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Login(),
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
