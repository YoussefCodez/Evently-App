import 'package:evently_c17/core/models/user_model.dart';
import 'package:evently_c17/core/remote/firebase/firebase_manager.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  getUser() async {
    user = await FirebaseManager.getUser();
    notifyListeners();
  }

  void addFavorite(event) {
    if (user == null) return;
    if (user!.favorites == null) {
      user!.favorites = [];
    }
    user!.favorites!.add(event.id);
    notifyListeners();
    FirebaseManager.addToFavorite(event);
  }

  void removeFavorite(event) {
    if (user == null) return;
    user!.favorites?.remove(event.id);
    notifyListeners();
    FirebaseManager.removeFromFavorite(event);
  }
}
