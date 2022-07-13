import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ApplicationLoginState { loggedOut, loggedIn }

class ApplicationState extends ChangeNotifier {
  User? user;
  ApplicationLoginState loginState = ApplicationLoginState.loggedIn;
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((userFir) {
      if (userFir != null) {
        loginState = ApplicationLoginState.loggedIn;
      } else {
        loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
             password: password);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  Future<void> signUp(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      UserCredential userCredential= await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
             password: password);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  void signOut() async{
    await FirebaseAuth.instance.signOut();
  }
}
