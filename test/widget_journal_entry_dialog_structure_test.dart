
import 'package:flutter_test/flutter_test.dart';
import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';
/**
 * This test class will focus on the the journal entry dialog structure widgets
 */
void main() async
{
  final mockUser = MockUser(isAnonymous: false, uid: 'mockid', email: 'mock@mock.com', displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp  = FirestoreProvider( FakeFirebaseFirestore(), auth );

  

  testWidgets("Find add button" , (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets("Find the journal entry dialog structure by checking the title" , (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text("Add A Journal Entry"), findsOneWidget);

  });


  testWidgets("Find the journal entry dialog structure fields" , (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text("Add A Journal Entry"), findsOneWidget);
    expect(find.byKey(Key("Display the image in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Camera in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Gallery in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form title")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form description")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form exit")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form save")), findsOneWidget);
  });

  testWidgets("Find the journal entry dialog exit button and exit" , (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // find the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // expect the dialog
    expect(find.text("Add A Journal Entry"), findsOneWidget);
    expect(find.byKey(Key("Display the image in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Camera in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Gallery in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form title")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form description")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form geolocation")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form exit")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form save")), findsOneWidget);

    await tester.tap(find.byKey(Key("Journalentry form exit")));
    await tester.pump();

    // expect the home page
    expect(find.byIcon(Icons.add), findsOneWidget);

  });

  testWidgets("Find the journal entry dialog save button and save" , (WidgetTester tester) async {
    // pump
    await tester.pumpWidget((MyApp(fsp)));

    // expect
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // find the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // expect the dialog
    expect(find.text("Add A Journal Entry"), findsOneWidget);
    expect(find.byKey(Key("Display the image in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Camera in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Gallery in the journalentry dialog structure")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form title")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form description")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form geolocation")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form exit")), findsOneWidget);
    expect(find.byKey(Key("Journalentry form save")), findsOneWidget);

    await tester.tap(find.byKey(Key("Journalentry form save")));
    await tester.pump();

    // expect the home page
    expect(find.byIcon(Icons.add), findsOneWidget);

  });


}

