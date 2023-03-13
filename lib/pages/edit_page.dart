import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/edit_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journalentry.dart';

class EditJournalEntry extends StatefulWidget {
  final JournalEntryModel entry;

  const EditJournalEntry({Key? key, required this.entry}) : super(key: key);

  @override
  EditJournalEntryState createState() => EditJournalEntryState();
}

class EditJournalEntryState extends State<EditJournalEntry> {
  final _formKey = GlobalKey<FormState>();
  late JournalEntryModel entry;
  String title = '';
  String content = '';
  String imagePath = '';
  String geoLocation = '';

  @override
  void initState() {
    super.initState();
    entry = widget.entry;
    title = entry.journalEntryTitle;
    content = entry.journalEntryContent;
    imagePath = entry.journalEntryImage;
    geoLocation = entry.journalEntryGeo;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Journal Entry',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              EditJournalEntryWidget(
                entry: entry,
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedContent: (content) =>
                    setState(() => this.content = content),
                onChangedImage: (value) => setState(() => imagePath = value),
                onChangedGeo: (value) => setState(() => geoLocation = value),
                onSave: saveTask,
              ),
            ],
          ),
        ),
      );

  void saveTask() {
    if (_formKey.currentState!.validate()) {
      final provider =
          Provider.of<JournalEntryProvider>(context, listen: false);

      provider.updateJournalEntry(
          entry, title, content, geoLocation, imagePath);

      Navigator.of(context).pop();
    }
  }

  void updateTaskRelationship() {}
}
