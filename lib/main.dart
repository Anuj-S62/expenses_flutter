import 'package:expenses_flutter/chatsysten/chatscreen.dart';
import 'package:expenses_flutter/screens/items.dart';
import 'package:expenses_flutter/screens/login.dart';
import 'package:expenses_flutter/screens/mainscreen.dart';
import 'package:expenses_flutter/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      // print(User);
      print('User is signed in!');
    }
  });
  runApp(MaterialApp(
    // home: Scaffold(body: Login()),
      debugShowCheckedModeBanner: false,
    home : await getLandingPage(),
    // home : ChatScreen(),
    // home: Login(),
    routes: {
        '/chatscreen' : (contex) => ChatScreen(),
      '/login':(context) => Login(),
      '/home' : (context) => MainScreen(""),
      '/SignUp' : (context) => SignUp()
    },
  ));
}


Future<Widget> getLandingPage() async {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
        print("Logged in:- main");
        return MainScreen(snapshot.data!.uid);
      }
      print("Logged out:- main");
      return Login();
    },
  );
}