import 'package:flutter_test/flutter_test.dart';
import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';
/**
 * This test class will focus on the setting page
 */
void main() async
{
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);

  testWidgets("Ensure that there is a privacy button", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.byKey(Key("SettingPage")), findsOneWidget);
    expect(find.byKey(Key("Privacy button")), findsOneWidget);

  });

  testWidgets("Ensure that there is a privacy button in the setting page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.byKey(Key("SettingPage")), findsOneWidget);
    expect(find.byKey(Key("Setting logout button")), findsOneWidget);

  });

  testWidgets("Ensure that there is a logout button in the setting page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.byKey(Key("SettingPage")), findsOneWidget);
    expect(find.byKey(Key("Setting logout button")), findsOneWidget);

  });

  // Todo: finish this later
  testWidgets("Ensure that the privacy button navigate to the privacy page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);


    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.byKey(Key("SettingPage")), findsOneWidget);
    expect(find.byKey(Key("Privacy button")), findsOneWidget);


    /*await tester.press(find.byKey(Key("Privacy button")));
    await tester.pump();

    expect(find.byKey(Key("PrivacyPage")), findsOneWidget);*/


  });


}