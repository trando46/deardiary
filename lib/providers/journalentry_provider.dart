import 'package:flutter/material.dart';
import 'package:deardiary/models/journalentry.dart';

class JournalEntryProvider with ChangeNotifier {
  int journalEntryCounter = 0;

  List<JournalEntryModel> _journalEntry = [];

  List<JournalEntryModel> get journalEntry => _journalEntry.toList();

  void journalEntryIDCounter(JournalEntryModel journalEntryModel) {
    journalEntryCounter++;
    journalEntryModel.journalEntryID = journalEntryCounter.toString();
  }

  void addJournalEntry(JournalEntryModel journalEntry) {
    _journalEntry.add(journalEntry);
    notifyListeners();
  }

  void updateOwnerID(JournalEntryModel entry, int ownerID) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].ownerID = ownerID.toString();
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void updateJournalEntryTitle(
      JournalEntryModel entry, String journalEntryTitle) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryTitle =
          journalEntryTitle;
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void updateJournalEntryContent(
      JournalEntryModel entry, String journalEntryContent) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryContent =
          journalEntryContent;
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void updateJournalEntryTags(
      JournalEntryModel entry, List<String> journalEntryTags) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryTags =
          journalEntryTags;
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void updateJournalEntryImage(
      JournalEntryModel entry, String journalEntryImage) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryImage =
          journalEntryImage;
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void updateJournalEntryGeo(JournalEntryModel entry, String journalEntryGeo) {
    if (_journalEntry.contains(entry)) {
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryGeo =
          journalEntryGeo;
      _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
          DateTime.now();
    }
    notifyListeners();
  }

  void deleteJournalEntry(JournalEntryModel entry) {
    _journalEntry.remove(entry);
    notifyListeners();
  }
}
