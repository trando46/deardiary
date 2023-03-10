import 'package:flutter/material.dart';
import 'package:deardiary/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void updateUserID(String userID) {
    _user!.userID = userID;
    notifyListeners();
  }

  void updateUserName(String userName) {
    _user!.userName = userName;
    notifyListeners();
  }

  void updateUserDob(String userDob) {
    _user!.userDob = userDob;
    notifyListeners();
  }

  // void updateUserDescription(String userDescription) {
  //   _user!.userDescription = userDescription;
  //   notifyListeners();
  // }

  // void updateUserPicture(String userPicture) {
  //   _user!.userPicture = userPicture;
  //   notifyListeners();
  // }

  void deleteUser() {
    _user = null;
    notifyListeners();
  }
}
