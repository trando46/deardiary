import 'package:flutter/material.dart';
import 'package:deardiary/models/journalentry.dart';

class JournalEntryProvider with ChangeNotifier {
  JournalEntryModel? _journalEntry;

  JournalEntryModel? get journalEntry => _journalEntry;

  void setJournalEntry(JournalEntryModel journalEntry) {
    _journalEntry = journalEntry;
    notifyListeners();
  }
}
