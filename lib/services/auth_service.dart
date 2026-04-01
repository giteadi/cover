import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  AuthService() {
    // Initialize with web client ID for web platform
    if (kIsWeb) {
      _googleSignIn = GoogleSignIn(
        clientId: '144932328528-pt437uppkbiqdp7blb898gk7en2lsppn.apps.googleusercontent.com',
        scopes: ['email', 'profile'],
      );
    } else {
      _googleSignIn = GoogleSignIn();
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      return userCredential.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }

  // Get user details
  Map<String, dynamic>? getUserDetails() {
    final user = currentUser;
    if (user != null) {
      return {
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'phoneNumber': user.phoneNumber,
      };
    }
    return null;
  }
}
