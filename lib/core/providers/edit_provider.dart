import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier {
  bool editMode = false;

  void toggleEdit() {
    editMode = !editMode;
    print(editMode);
    notifyListeners();
  }
}
