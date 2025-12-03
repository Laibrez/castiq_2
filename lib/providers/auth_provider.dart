import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password, UserType userType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock login - replace with actual API call
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: email.split('@')[0],
        userType: userType,
        isVerified: false,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String email, String password, String name, UserType userType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock signup - replace with actual API call
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        userType: userType,
        isVerified: false,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }

  void updateUserVerification(bool isVerified) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        name: _currentUser!.name,
        userType: _currentUser!.userType,
        isVerified: isVerified,
        profileImage: _currentUser!.profileImage,
        phone: _currentUser!.phone,
      );
      notifyListeners();
    }
  }
}
