import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authenticatorx/screens/Auth/signup_screens/confirmation_screen.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Part 1: Sending Email Verification
  Future<String> sendEmailVerification({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      // Check if the email is already in use
      dynamic userCredential;
      try {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (signInError) {
        // If sign-in fails, the user does not exist, proceed with creating a new user
      }

      if (userCredential == null) {
        // Create a new user with the provided email and password
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Send a confirmation email to the user for verification
        await _auth.currentUser!.sendEmailVerification();
      } else {
        // User exists but hasn't verified the email, resend verification
        await _auth.currentUser!.sendEmailVerification();
      }

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ConfirmationScreen(
                email: email,
                username: username,
                password: password,
              );
            },
          ),
        );
      }

      return 'success';
    } catch (e) {
      // Handle specific error cases or provide a generic message
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            return 'An account with this email already exists. Please log in.';
          // Add more cases as needed
          default:
            return 'Error: ${e.message}';
        }
      } else if (e is SocketException) {
        // Handle no internet connection
        return 'No internet connection. Please check your network.';
      } else {
        return 'Oops! Something went wrong. Please try again later.';
      }
    }
  }

  // Resend email verification method
  Future<String> resendVerificationEmail({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      // Send a confirmation email to the user for verification
      await _auth.currentUser!.sendEmailVerification();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email resent')),
        );
      }

      return 'Verification email resent.';
    } catch (e) {
      // Handle specific error cases or provide a generic message
      if (e is FirebaseAuthException) {
        return 'Error: ${e.message}';
      } else {
        return 'Oops! Something went wrong. Please try again later.';
      }
    }
  }

  // Part 2: Complete Registration Process
  Future<String> completeRegistration({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Retrieve the current user
      final user = _auth.currentUser;

      // Check if the user is not null
      if (user != null) {
        // Checking if the email is verified
        await user.reload();

        if (user.emailVerified) {
          // Now, saving user data to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'username': username,
            'uid': user.uid,
            'email': user.email,
          });

          return 'success';
        } else {
          // User's email is not verified. You can handle this case.
          return 'Email not verified. Please check your email for the verification link. If you have already verified your email, please wait for a few seconds and then press "Continue". If you haven\'t received the email, you can click "Resend" to receive the verification email again.';
        }
      } else {
        return 'User not found. Please try again later.';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        return 'Error: ${e.message}';
      } else if (e is SocketException) {
        return 'No internet connection. Please check your network.';
      } else {
        return 'Oops! Something went wrong. Please try again later.';
      }
    }
  }
}
