
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:deardiary/pages/home_page.dart';
import 'package:deardiary/main.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'widget_home_page_test.mocks.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

class JournalEntryDialogModel {
  int? journalEntryID = 1;
  String ownerID = "1001";
  String onlineID = "2002";
  String journalEntryTitle  = "Sleep early";
  String journalEntryContent = "I did it!";
  DateTime journalEntryCreationDate = DateTime.now();
  DateTime journalEntryLastUpdate = DateTime.now();
}
@GenerateMocks([JournalEntryDialogModel])
void main() async {

  late  JournalEntryDialogModel entryMock;

  setUp((){
    entryMock= MockJournalEntryDialogModel();
  });

  /*testWidgets("Verify that the entry is displayed", (tester ) async{

    final entry = JournalEntryModel(
        ownerID: 1,
        journalEntryTitle: "Sleep",
        journalEntryCreationDate: DateTime.now(),
        journalEntryLastUpdate: DateTime.now(),
    );
  }*/

  /**
   * has an add button
   */
 /*testWidgets("HomePage tap on the add button should find the journalentry dialog structure widget", (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget( HomePage());

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // expect to find the widget for TodoCardStructureWidget
    expect(find.byType(JournalEntryDialogStructureWidget),findsWidgets);

  });*/

  test('Mock_Verify_Title',() {
    when(entryMock.journalEntryTitle).thenReturn('Sleep early');

    entryMock.journalEntryTitle;

    verify(entryMock.journalEntryTitle);
  });

  test('Mock_Verify_Content',() {
    when(entryMock.journalEntryContent).thenReturn('I did it!');

    entryMock.journalEntryContent;

    verify(entryMock.journalEntryContent);
  });


}


