import 'package:flutter_test/flutter_test.dart';
import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';
/**
 * This test class will focus on the the nav bar widgets
 */
void main() async
{
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);


  testWidgets("Find all of the icons of the side bar nav", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.list_alt), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
    expect(find.byIcon(Icons.stacked_bar_chart), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets("Ensure that when tap on the list of entries take you to the list of entries on the home page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.list_alt), findsOneWidget);

    await tester.tap(find.byIcon(Icons.list_alt));
    await tester.pump();

    expect(find.byKey(Key("Homepage")), findsOneWidget);

  });

  testWidgets("Ensure that when tap on the calendar will take you to the calendar page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);

    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pump();

    expect(find.byKey(Key("CalendarPage")), findsOneWidget);
  });

  testWidgets("Ensure that when tap on the status will take you to the status page", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.stacked_bar_chart), findsOneWidget);

    await tester.tap(find.byIcon(Icons.stacked_bar_chart));
    await tester.pump();

    expect(find.byKey(Key("StatusPage")), findsOneWidget);
  });

  testWidgets("Ensure that when tap on the setting will take you to the settingpage", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();

    expect(find.byKey(Key("SettingPage")), findsOneWidget);
  });

  testWidgets("Ensure that there is a pop up menu button to log out", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(Key("HomePage popupMenu button")), findsOneWidget);

  });

  //Todo: need to finish this test case
  testWidgets("Ensure that when tap on the logout button takes you to logout", (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(Key("HomePage popupMenu button")), findsOneWidget);


    await tester.tap(find.byKey(Key("HomePage popupMenu button")));
    await tester.pump();

    //expect(find.byKey(Key("HomePage dialog to sign out")), findsOneWidget);
  });
}