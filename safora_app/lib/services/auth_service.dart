import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await _createUserDocument(credential.user!.uid, name, email);

      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw 'Google sign in aborted';

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _auth.signInWithCredential(credential);

      // Create user document if it doesn't exist
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await _createUserDocument(
          userCredential.user!.uid,
          userCredential.user!.displayName ?? 'User',
          userCredential.user!.email!,
        );
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(String uid, String name, String email) async {
    final userDoc = _firestore.collection(AppConstants.usersCollection).doc(uid);
    
    final userData = UserModel(
      id: uid,
      name: name,
      email: email,
      diets: [],
      allergies: [],
      healthGoals: [],
    );

    await userDoc.set(userData.toMap());
  }

  // Get user data from Firestore
  Future<UserModel?> getUserData() async {
    try {
      if (currentUser == null) return null;

      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(currentUser!.uid)
          .get();

      if (!doc.exists) return null;

      return UserModel.fromFirestore(doc);
    } catch (e) {
      rethrow;
    }
  }

  // Update user preferences
  Future<void> updateUserPreferences({
    List<String>? diets,
    List<String>? allergies,
    List<String>? healthGoals,
  }) async {
    try {
      if (currentUser == null) throw 'No user logged in';

      final updates = <String, dynamic>{};
      if (diets != null) updates['diets'] = diets;
      if (allergies != null) updates['allergies'] = allergies;
      if (healthGoals != null) updates['health_goals'] = healthGoals;

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(currentUser!.uid)
          .update(updates);
    } catch (e) {
      rethrow;
    }
  }
} 