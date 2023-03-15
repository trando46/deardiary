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
/**
 * This test class will focus on the edit component
 */
void main() async
{
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);

  testWidgets("Find the edit button on the journal entry and click on it to navigate to the edit page ", (WidgetTester tester) async {
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
    await tester.drag(find.byType(Slidable), const Offset(50.0, 0.0));
    await tester.pump();

    expect(find.byIcon(Icons.edit),findsOneWidget);
    expect(find.text('Edit'),findsWidgets);

    // Route to the edit page when the edit button is presssed.
    await tester.tap(find.byIcon(Icons.edit),warnIfMissed: false);
    nav.currentState!.push(router);
    await tester.pumpAndSettle();

    // Confirming that this is the edit page.
    expect(find.text(entryModel.journalEntryTitle), findsOneWidget);
    expect(find.text(entryModel.journalEntryContent),findsOneWidget);
    expect(find.text('Save'),findsOneWidget);
    expect(find.text('Cancel'),findsOneWidget);
  });

}