import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp
  Future<User?> signUpUser({required String email, required password}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  //SignIn
  Future<User?> signIn({required String email, required password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // SignOut
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signInUser() async {
    return _auth.currentUser;
  }
}
