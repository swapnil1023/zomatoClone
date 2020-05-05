import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/functionalities/local_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  LocalData localData = new LocalData();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Firestore _db = Firestore.instance;

  Future<bool> signInWithEmail({email: '', password: ''}) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        localData.saveData(
            userEmail: email, password: password, loggedIn: "yes");
        return true;
      }
      return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("loggedIn", "no");
      prefs.setString("userEmail", null);
      prefs.setString("password", null);
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> googleSignIn() async {
    try {
      
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      localData.saveData(userEmail: user.email, password: '', loggedIn: "yes");
      print("user name: ${user.displayName}");
      //updateUserData(user);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  /* void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    ref.setData({
//      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  } */

}

//final AuthService authService = AuthService();