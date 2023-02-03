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
    entry.ownerID = ownerID.toString();
    notifyListeners();
  }

  void updateJournalEntryTitle(
      JournalEntryModel entry, String journalEntryTitle) {
    entry.journalEntryTitle = journalEntryTitle;
    notifyListeners();
  }

  void updateJournalEntryContent(
      JournalEntryModel entry, String journalEntryContent) {
    entry.journalEntryContent = journalEntryContent;
    notifyListeners();
  }

  void updateJournalEntryTags(
      JournalEntryModel entry, List<String> journalEntryTags) {
    entry.journalEntryTags = journalEntryTags;
    notifyListeners();
  }

  void updateJournalEntryImage(
      JournalEntryModel entry, String journalEntryImage) {
    entry.journalEntryImage = journalEntryImage;
    notifyListeners();
  }

  void updateJournalEntryGeo(JournalEntryModel entry, String journalEntryGeo) {
    entry.journalEntryGeo = journalEntryGeo;
    notifyListeners();
  }

  void updateJournalEntryLastUpdate(
      JournalEntryModel entry, DateTime journalEntryLastUpdate) {
    entry.journalEntryLastUpdate = journalEntryLastUpdate;
    notifyListeners();
  }

  void deleteJournalEntry(JournalEntryModel entry) {
    _journalEntry.remove(entry);
    notifyListeners();
  }
}
