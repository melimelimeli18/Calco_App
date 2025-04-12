import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Sign Up
  Future<UserModel?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          username: username,
          email: email,
          createdAt: DateTime.now(),
        );

        await _firestoreService.saveUserData(newUser);

        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Email sudah digunakan');
      } else if (e.code == 'weak-password') {
        throw Exception('Password terlalu lemah (minimal 6 karakter)');
      } else if (e.code == 'invalid-email') {
        throw Exception('Format email tidak valid');
      } else {
        throw Exception('Terjadi kesalahan saat pendaftaran');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga');
    }

    return null;
  }

  // Sign In
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        UserModel? userModel = await _firestoreService.getUserData(user.uid);
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('Email tidak ditemukan');
      } else if (e.code == 'wrong-password') {
        throw Exception('Password salah');
      } else if (e.code == 'invalid-email') {
        throw Exception('Format email tidak valid');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Email salah atau tidak terdaftar');
      } else {
        throw Exception('Terjadi kesalahan saat masuk');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga');
    }

    return null;
  }

  // Get Current User
  Future<UserModel?> getCurrentUser() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        UserModel? userModel =
            await _firestoreService.getUserData(currentUser.uid);
        return userModel;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getFirebaseUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
