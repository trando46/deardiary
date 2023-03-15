import 'package:flutter_test/flutter_test.dart';
import 'package:deardiary/main.dart';
import 'package:deardiary/providers/firestore_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/journalentry_individual_ui_widget.dart';
import 'package:provider/provider.dart';
import 'package:deardiary/pages/edit_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:deardiary/models/journalentry.dart';

void main() {
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);

  testWidgets("Tapping on entry list element will display entry details to user", (WidgetTester tester) async {
    // Create a model
    JournalEntryModel entryModel = JournalEntryModel(
        ownerID: '10001',
        journalEntryTitle: "Hello",
        journalEntryContent: "Bogus",
        journalEntryCreationDate: DateTime.now(),
        journalEntryLastUpdate: DateTime.now());

    // Add the model to the provieder
    var storage = JournalEntryProvider(firestore: fsp);
    storage.addJournalEntry(entryModel);

    final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

    // pump the UI of the entry
    await tester.pumpWidget(
        MaterialApp(
            navigatorKey: nav,
            home: ChangeNotifierProvider<JournalEntryProvider>(
              create: (context) => storage,
              child: JournalEntryIndividualUIWidget(journalEntryModel: entryModel),
            )
        )
    );

    // expect
    expect(find.text(entryModel.journalEntryTitle), findsOneWidget);

    // routing to the journal entry edit page
    final router = MaterialPageRoute(builder: (context) => ChangeNotifierProvider<JournalEntryProvider>(
      create: (context) => storage,
      child:  EditJournalEntry(entry: entryModel),
    ));

    // Drag the UI entry to find the edit
    await tester.tap(find.text("Hello"));
    await tester.pump();


    // Confirming that this is the display.
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Journal Entry"), findsOneWidget);
    expect(find.text("Hello"), findsOneWidget);
    expect(find.text("Bogus"), findsOneWidget);
    expect(find.text('No Image Attached'), findsOneWidget);
    expect(find.text('No location attached'), findsOneWidget);

  });
}