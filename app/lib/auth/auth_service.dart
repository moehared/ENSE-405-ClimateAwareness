import 'package:app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  String _signInError = "";
  String _signUpError = "";

  AuthService(this._firebaseAuth);

  Stream<User> get authState => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;
  String get signInErrorMsg => _signInError;
  String get signUpErrorMsg => _signUpError;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signIn({String email, String password}) async {
    var isSignIn = false;
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null && _firebaseAuth.currentUser.emailVerified) {
        isSignIn = true;
      }
    } on FirebaseAuthException catch (e) {
      isSignIn = false;
      _signInError = e.message;
      print("Error occurred while signing in " + e.message);
    }

    return isSignIn;
  }

  Future<bool> signUp({UserModel userModel}) async {
    var isSignUp = false;
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      if (user != null) {
        userRef.child(_firebaseAuth.currentUser.uid).set(userModel.toJson());
        isSignUp = true;
      }
    } on FirebaseAuthException catch (e) {
      isSignUp = false;
      _signUpError = e.message;
      print("Error occurred while signing up " + e.message);
    }
    return isSignUp;
  }

  Future<bool> sendEmailVerification() async {
    bool isVerify = false;
    // if user is registered but not verify
    if (_firebaseAuth.currentUser != null) {
      _firebaseAuth.currentUser.reload();
      if (!_firebaseAuth.currentUser.emailVerified) {
        _firebaseAuth.currentUser.sendEmailVerification();
        isVerify = false;
      } else {
        isVerify = true;
      }
    }
    // otherwise user is not verify, send verification email
    else {
      isVerify = false;
      _firebaseAuth.currentUser.sendEmailVerification();
    }
    return isVerify;
  }
}