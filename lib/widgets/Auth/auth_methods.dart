import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authenticatorx/providers/auth_data_provider.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> signUp() async {
    String res = 'Some error occurred';
    try {
      // Getting User Data from auth_data_provider
      String email = UserData().email;
      String username = UserData().username;
      String password = UserData().password;

      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (cred.user != null) {
          // Send a confirmation email to the user for validation
          await cred.user!.sendEmailVerification();

          // Checking if the email is verified
          if (cred.user!.emailVerified) {
            // User registration successful
            // Now, saving user data to Firestore
            await _firestore.collection('users').doc(cred.user!.uid).set({
              'username': username,
              'uid': cred.user!.uid,
              'email': email,
            });
            res = 'success';
          } else {
            // User's email is not verified. You can handle this case.
            res = 'Email not verified';
          }
        }
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
