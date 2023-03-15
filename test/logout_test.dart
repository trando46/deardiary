//import 'package:flutter/material.dart';
import 'package:deardiary/pages/authentication_page.dart';
import 'package:deardiary/widgets/journalentry_display_entry_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// https://pub.dev/packages/firebase_auth_mocks

import 'package:deardiary/pages/home_page.dart';


import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}



void main() async
{
  final mockObserver = MockNavigatorObserver();

  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);


  testWidgets(
      "Find the dropdown button and go to logout button and press cancel will return user to home page", (WidgetTester tester) async {
    // Create a model
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    // expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    var menuOption = find.byKey(const Key("HomePage popupMenu button"));
    expect(menuOption, findsOneWidget);

    await tester.tap(menuOption);
    await tester.pumpAndSettle();
    expect(find.text("Logout"), findsOneWidget);

    await tester.tap(find.text("Logout"));
    await tester.pumpAndSettle();

    expect(find.text("Cancel"), findsOneWidget);

    await tester.tap(find.text("Cancel"));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);

  }
  );

  testWidgets(
      "Find the dropdown button and go to logout button and press sign out will return user to auth page", (WidgetTester tester) async {
    // Create a model
    //await tester.pumpWidget((MyApp(fsp)));

/*    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });*/

    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(fsp),
        navigatorObservers: [mockObserver],
      ),
    );

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    // expect(find.byType(PopupMenuButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    var menuOption = find.byKey(const Key("HomePage popupMenu button"));
    expect(menuOption, findsOneWidget);

    await tester.tap(menuOption);
    await tester.pumpAndSettle();
    expect(find.text("Logout"), findsOneWidget);

    await tester.tap(find.text("Logout"));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text("Sign Out"), findsAtLeastNWidgets(2));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text("Sign Out").last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    //expect(find.byType(HomePage), findsNothing);
    //expect(find.byType(AuthenticationPage), findsOneWidget);

  }
  );


}