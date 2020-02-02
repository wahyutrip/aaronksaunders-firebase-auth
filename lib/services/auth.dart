import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  // wrappinhg the firebase calls
  Future logout() {
    return FirebaseAuth.instance.signOut();
  }

  // wrappinhg the firebase calls
  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = "$firstName $lastName";
    return await user.updateProfile(info);
  }

  // wrappinhg the firebase calls
  Future<FirebaseUser> loginUser({String email, String password}) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user;
  }
}
