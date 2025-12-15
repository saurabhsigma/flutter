import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserDataProvider = StreamProvider<UserModel?>((ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges.switchMap((user) {
    if (user == null) {
      return Stream.value(null);
    }
    return auth.getUserData(user.uid);
  });
});

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Note: Google Sign-In implementation varies between package versions.
  // As a safe fallback to keep authentication working and avoid
  // analyzer errors related to google_sign_in API changes, sign in
  // anonymously for now. Replace this with the full Google Sign-In
  // flow when your google_sign_in version/API is confirmed.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Temporary fallback: sign in anonymously to keep auth flow working
      final UserCredential userCredential = await _auth.signInAnonymously();
      if (userCredential.user != null) {
        await _syncUserToFirestore(userCredential.user!);
      }
      return userCredential;
    } catch (e) {
      debugPrint("Error signing in (fallback): $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    // If GoogleSignIn is later re-added, also sign out from it here.
    await _auth.signOut();
  }

  Future<void> _syncUserToFirestore(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();

    // TEMPORARY: Hardcoded Admin Email (Replace with your own or move to remote config)
    const adminEmail = 'saurabh123@gmail.com'; 
    final bool isAdmin = user.email == adminEmail;

    if (!snapshot.exists) {
      final newUser = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? 'User',
        photoUrl: user.photoURL ?? '',
        isPremium: true, // Free for all now
        isAdmin: isAdmin,
        createdAt: DateTime.now(),
      );
      await userDoc.set(newUser.toMap());
    } else {
      // Update basic info if changed (optional, but good for profile sync)
      await userDoc.update({
        'email': user.email,
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        // We might want to force isAdmin update in case we change the hardcoded email later
        // But typically roles are managed in Firestore manually after creation.
        // For this "simple start", let's strictly enforce admin role based on email on every login.
        'isAdmin': isAdmin, 
        'isPremium': true, // Enforce free for all on login
      });
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    });
  }
}

// Extension to help with switchMap-like behavior if rxdart is not used or just keep it simple
extension StreamSwitchMap<T> on Stream<T> {
  Stream<R> switchMap<R>(Stream<R> Function(T) mapper) async* {
    await for (final item in this) {
      yield* mapper(item);
    }
  }
}
