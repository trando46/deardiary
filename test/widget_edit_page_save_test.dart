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

void main() async
{
  final mockUser = MockUser(isAnonymous: false,
      uid: 'mockid',
      email: 'mock@mock.com',
      displayName: 'mocky');
  final auth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  final fsp = FirestoreProvider(FakeFirebaseFirestore(), auth);

  JournalEntryModel entryModel = JournalEntryModel(
      ownerID: 'mockid',
      //id must match mock user.
      journalEntryTitle: "Hello",
      journalEntryContent: "Bogus",
      journalEntryCreationDate: DateTime.now(),
      journalEntryLastUpdate: DateTime.now());
  
  testWidgets(
      "Modifying title in edit page will reflect in entry list view", (
      WidgetTester tester) async {

    // Add the model to the provieder
    var app = MyApp(fsp);
    app.jep.addJournalEntry(entryModel);
    await tester.pumpWidget(app);
    expect(find.text(entryModel.journalEntryTitle), findsOneWidget);

    await tester.drag(find.byType(Slidable), const Offset(200.0, 0.0));
    await tester.pump(); //start animation
    await tester.pump(const Duration(seconds: 2)); //jump to end of animation
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.text('Edit'), findsWidgets);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    //verify we move pages.
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(EditJournalEntry), findsOneWidget);

    //verify stuff on edit page is there.
    expect(find.text(entryModel.journalEntryTitle), findsOneWidget);
    expect(find.text(entryModel.journalEntryContent), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.enterText(find.byKey(const Key("EditTitleTFF")), "UnitTests");
    await tester.pump(); //start animation

    await tester.tap(find.text("Save"));

    await tester.pump(const Duration(seconds: 2)); //jump to end of animation
    
    expect(find.byType(JournalEntryIndividualUIWidget), findsOneWidget);
    expect(find.text("UnitTests"), findsAtLeastNWidgets(1));
    
  }
  );

}