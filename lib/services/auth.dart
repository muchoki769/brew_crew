import 'package:brew_crew/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserApp?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymously
  // Future <UserApp?> signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     // AuthResult result = await _auth.signInAnonymously();
  //     // FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email and password
  Future<UserApp?> signInWithEmailAndPassword(String email, String password)async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint('Error signing in: $e');
      return null;
    }
  }

  //register with email and password
  Future<UserApp?> registerWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;

      //creating a doc for user with uid

      await DatabaseServices(uid: user!.uid).updateUserData('0','new crew member',100);
      return _userFromFirebaseUser(user);
    }catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }
  //sign out
Future<UserApp?> signOut() async {
    try{
       await _auth.signOut();
       return null;
    }catch(e) {
      debugPrint("error signing out: ${e.toString()}");
      return null;

    }
}
}