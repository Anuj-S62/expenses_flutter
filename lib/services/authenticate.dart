import 'package:firebase_auth/firebase_auth.dart';

Future<String?> register(String userName,String email,String pass) async{
  try{
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user name set");
      user.updateDisplayName(userName);
      return user.uid;
    }else {
      print('Uid not found');
      return null;
    }
  }catch(e){
    print(e);
    return null;
  }
}

Future<String?> SignIn(String email, String pass) async{
  try {
   dynamic type = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      print('Uid not found');
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future signOut() async {
  try {
    return await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}