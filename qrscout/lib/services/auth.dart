import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final rtDatabase = FirebaseDatabase.instance;
  // get login method
  String getLoginMethod() {
    if (user != null && user!.isAnonymous) {
      return 'Anonymous';
    } else {
      return '';
    }
  }

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // handle error
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> updateUserRecievingState(bool state) async {
    final ref = rtDatabase.ref().child('users/${user?.uid}');
    await ref.update({'recieving': state});
  }
}
