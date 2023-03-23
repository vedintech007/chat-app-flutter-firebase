import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/services/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      print(user);

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  // register
  Future registerUserWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      print(user);

      if (user != null) {
        // call database service to update data
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  // sign out
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
