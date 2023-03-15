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
        ownerID: 'mockid',
        journalEntryTitle: "Hello",
        journalEntryContent: "Bogus",
        journalEntryCreationDate: DateTime.now(),
        journalEntryLastUpdate: DateTime.now());

    var app = MyApp(fsp);
    app.jep.addJournalEntry(entryModel);
    await tester.pumpWidget(app);
    expect(find.text(entryModel.journalEntryTitle), findsOneWidget);

    // Drag the UI entry to find the edit
    await tester.tap(find.text("Hello"));
    await tester.pump();
    await tester.pump(Duration(seconds : 1)); //needs to complete page change animation.

    // Confirming that this is the display.
    expect(find.byType(AppBar), findsOneWidget);
    //expect(find.text("Journal Entry"), findsOneWidget);
    expect(find.text("Hello"), findsOneWidget);
    //expect(find.text("Bogus"), findsOneWidget);
    expect(find.text('No Image Attached'), findsOneWidget);
    expect(find.text('No location attached'), findsOneWidget);

  });
}