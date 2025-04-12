import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _token;
  String? get token => _token;

  // Sign Up
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      _user = await _authService.signUp(
        username: username,
        email: email,
        password: password,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Error: ', '');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Sign In
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      _user = await _authService.signIn(
        email: email,
        password: password,
      );
      _errorMessage = null;

      _token = await _getToken();
      print("TOKEN USER NOW: $_token");
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Error: ', '');
      rethrow; // <--- Tambahkan ini bro!
    } finally {
      _setLoading(false);
    }
  }

  // Get Current User
  Future<void> getCurrentUser() async {
    _setLoading(true);
    try {
      _user = await _authService.getCurrentUser();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _setLoading(false);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _setLoading(false);
    }
  }

  // Utility untuk set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> _getToken() async {
    final firebaseUser = _authService.getFirebaseUser();
    return await firebaseUser?.getIdToken();
  }
}
