import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/login/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => controller.loginWithEmailLink(),
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loginWithGoogle(),
              child: Text('Sign in with Google'),
            ),
            TextButton(
              onPressed: () => controller.loginWithGuest(),
              child: Text('Login with Guest'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => controller.readDataFromFirestore(),
              child: Text('Read Data from Firestore'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.writeDataToFirestore(),
              child: Text('Write Data to Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}
