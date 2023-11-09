import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authenticatorx/widgets/Auth/auth_data.dart'; 

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> signUp() async {
    String res = 'Some error occurred';
    try {
      // Get user data from the UserData class
      String username = UserData().username;
      String password = UserData().password;
      String email = UserData().email;

      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (cred.user != null) {
          // User registration successful
          // Now, save user data to Firestore
          await _firestore.collection('users').doc(cred.user!.uid).set({
            'username': username,
            'uid': cred.user!.uid,
            'email': email,
            // Add other user data fields as needed
          });
          res = 'success';
        }
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
