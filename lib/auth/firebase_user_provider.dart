import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CypheeFirebaseUser {
  CypheeFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CypheeFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CypheeFirebaseUser> cypheeFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CypheeFirebaseUser>((user) => currentUser = CypheeFirebaseUser(user));
