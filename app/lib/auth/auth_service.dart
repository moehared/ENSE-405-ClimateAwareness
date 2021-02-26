import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authState => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signIn({String email, String password}) async {
    var isSignIn = false;
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if(user != null) {
        isSignIn = true;
      }
    } on FirebaseAuthException catch (e) {
      isSignIn = false;
      print("Error occurred while signing in " + e.message);
    }

    return isSignIn;
  }

  Future<bool> signUp({String email, String password}) async {
    var isSignUp = false;
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: email);
      if(user != null) {
        isSignUp = true;
      }
    } on FirebaseAuthException catch (e) {
      isSignUp = false;
      print("Error occurred while signing up " + e.message);
    }
    return isSignUp;
  }
}
