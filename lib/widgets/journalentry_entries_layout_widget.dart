import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/journalentry_individual_ui_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/diary_database.dart';

class JournalEntryEntriesLayoutWidget extends StatefulWidget {
  const JournalEntryEntriesLayoutWidget({super.key});

  _JournalEntryEntriesLayoutWidgetState createState() =>
      _JournalEntryEntriesLayoutWidgetState();
}

class _JournalEntryEntriesLayoutWidgetState
    extends State<JournalEntryEntriesLayoutWidget> {
  String user = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<JournalEntryModel> entriesAll = //allEntries;
        Provider.of<JournalEntryProvider>(context).allJournalEntries;

    final entries =
        entriesAll.where((element) => element.ownerID == user).toList();

    // Need to take care of no todos and todos
    return ListView.separated(
      // Special effect of scrolling and display the task cards
      itemCount: entries.length,
      scrollDirection: Axis.vertical,
      dragStartBehavior: DragStartBehavior.start,
      // Adding the spacing between each task using the container
      separatorBuilder: (context, index) => Container(
        height: 5,
        //color: Colors.black12,
      ),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return JournalEntryIndividualUIWidget(journalEntryModel: entry);
      },
    );
  }
}
