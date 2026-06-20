import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/main.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginWithGoogle() {
    print('Google Sign-In logic goes here');
  }

  void loginWithGuest() {
    auth
        .signInAnonymously()
        .then((result) {
          print('Logged in as Guest: ${result.user?.uid}');
        })
        .catchError((error) {
          print('Guest Login Failed: $error');
        });
  }

  void loginWithEmail() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      print('Email and Password cannot be empty');
      return;
    } else {
      auth
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((result) {
            print('Logged in with Email: ${result.user?.email}');
          })
          .catchError((error) {
            print('Email Login Failed: $error');
          });
    }
  }

  void registerWithEmail() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      print('Email and Password cannot be empty');
      return;
    } else {
      auth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((result) {
            print('Registered with Email: ${result.user?.email}');
          })
          .catchError((error) {
            print('Email Registration Failed: $error');
          });
    }
  }

  void loginWithEmailLink() {
    if (emailController.text.isEmpty) {
      print('Email cannot be empty');
      return;
    } else {
      auth
          .sendSignInLinkToEmail(
            email: emailController.text,
            actionCodeSettings: ActionCodeSettings(
              url: 'https://my-firebase-1234.firebaseapp.com',
              handleCodeInApp: true,
              iOSBundleId: 'com.memo.app.memo_app',
              androidPackageName: 'com.memo.app.memo_app',
              androidInstallApp: true,
              androidMinimumVersion: '12',
            ),
          )
          .then((_) {
            print('Email Link Sent to ${emailController.text}');
          })
          .catchError((error) {
            print('Email Link Login Failed: $error');
          });
    }
  }

  void readDataFromFirestore() {
    // firestore
    //     .collection('Users')
    //     .get()
    //     .then((querySnapshot) {
    //       for (var doc in querySnapshot.docs) {
    //         print('Document ID: ${doc.id}, Data: ${doc.data()}');
    //       }
    //     })
    //     .catchError((error) {
    //       print('Failed to read data from Firestore: $error');
    //     });

    firestore
        .collection('Users')
        .doc('account')
        .get()
        .then((doc) {
          if (doc.exists) {
            print('Document Data: ${doc.data()}');
          } else {
            print('No such document!');
          }
        })
        .catchError((error) {
          print('Failed to read data from Firestore: $error');
        });
  }

  void writeDataToFirestore() {
    print('Write Data to Firestore logic goes here');
  }
}
