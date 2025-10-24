import 'package:flutter/material.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;
  final List<User> _likedUsers = [];
  final List<User> _matches = [];

  User? get currentUser => _currentUser;
  List<User> get likedUsers => _likedUsers;
  List<User> get matches => _matches;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void addLikedUser(User user) {
    _likedUsers.add(user);
    notifyListeners();
  }

  void addMatch(User user) {
    _matches.add(user);
    notifyListeners();
  }
}