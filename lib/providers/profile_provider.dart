import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // Sample user data
  String _name = "Md Abu Ubayda";
  final String _email = "ubayda@example.com";
  String _phone = "+88001712346789";
  String _avatarUrl =
      "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d";

  // Getters
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get avatarUrl => _avatarUrl;

  // Method to update name
  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  // Method to update phone
  void updatePhone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }

  // Method to update avatar
  void updateAvatar(String newAvatarUrl) {
    _avatarUrl = newAvatarUrl;
    notifyListeners();
  }
}