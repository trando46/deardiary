import 'package:deardiary/models/user.dart';
import 'package:deardiary/providers/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/user.dart';

void main() {
  //setup
  UserProvider up = UserProvider();

  UserModel bob = UserModel(userID: "testmanID", userName: "bob",
      userDob: "2021-01-23 19:26:00" , email: "testemail@email.com");

  up.setUser(bob);

  testWidgets("Setting a UserModel in provider and returning it", (WidgetTester tester) async {


  var returnedUser = up.getUser("testmanID");

  expect(returnedUser?.email, "testemail@email.com");
  expect(returnedUser?.userID, "testmanID");
  expect(returnedUser?.userName, "bob");
  expect(returnedUser?.userDob, "2021-01-23 19:26:00");
  }
  );

  testWidgets("Changing name, dob, and id fields in User and returning modified user", (WidgetTester tester) async {
    up.updateUserName("name2");
    up.updateUserDob("1982-01-23 19:26:00");

    var returnedUser = up.getUser("testmanID");
    expect(returnedUser?.userName, "name2");
    expect(returnedUser?.userDob, "1982-01-23 19:26:00");

    up.updateUserID("Tim");
    var returnedUser2 = up.getUser("Tim");
    expect(returnedUser2?.userName, "name2");

  }
  );

  testWidgets("Delete user, return null", (WidgetTester tester) async {

    up.deleteUser();
    var returnedUser = up.getUser("Tim");
    expect(returnedUser, null);

  }
  );

  }
