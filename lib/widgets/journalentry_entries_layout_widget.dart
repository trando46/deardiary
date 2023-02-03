import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/journalentry_individual_ui_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalEntryEntriesLayoutWidget extends StatelessWidget {
  const JournalEntryEntriesLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<JournalEntryModel> entries =
        Provider.of<JournalEntryProvider>(context).allJournalEntries;

    // Need to take care of no todos and todos
    return ListView.separated(
      // Special effect of scrolling and display the task cards
      itemCount: entries.length,
      scrollDirection: Axis.vertical,
      dragStartBehavior: DragStartBehavior.start,
      // Adding the spacing between each task using the container
      separatorBuilder: (context, index) => Container(
        height: 18,
        color: Colors.black12,
      ),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return JournalEntryIndividualUIWidget(journalEntryModel: entry);
      },
    );
  }
}
