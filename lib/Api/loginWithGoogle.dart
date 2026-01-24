import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;


class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    try {

      // Google Sign-In 7.x uses a singleton instance
      final googleSignIn = gsi.GoogleSignIn.instance;
      
      final googleUser = await googleSignIn.authenticate();
      if (googleUser == null) {
        print("User cancelled Google Sign-In");
        return;
      }

      // Obtain auth details
      final googleAuth = googleUser.authentication;


      // In 7.x, accessToken is removed from GoogleSignInAuthentication on some platforms.
      // It must be obtained via authorizationClient.
      await googleSignIn.authorizationClient.authorizeScopes(['email', 'profile']);
      final accessToken = (await googleSignIn.authorizationClient.authorizationForScopes(['email', 'profile']))?.accessToken;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: accessToken,
      );

      // Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        print("✅ Google Sign-In successful: ${user.displayName}");
      }
    } catch (e) {
      print("❌ Google Sign-In error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: signInWithGoogle,
      child: const Text("Login with Google"),
    );
  }
}
