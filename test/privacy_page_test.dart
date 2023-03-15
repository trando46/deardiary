//import 'package:flutter/material.dart';
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

void main() async
{
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);


  testWidgets(
      "Find the settings and go to privacy page", (WidgetTester tester) async {
    // Create a model
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.text("Privacy"), findsOneWidget);

    await tester.tap(find.text("Privacy"));
    await tester.pumpAndSettle();

    expect(find.text("We shall not share your data. We will not abuse your information. We are not legally liable if the data is leak to the public. Agreeing to use our app, you shall not sue us for any reasons. You are liable with signing in and out of the app."), findsOneWidget);

  }
  );




}