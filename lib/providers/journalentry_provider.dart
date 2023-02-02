import 'package:flutter/material.dart';
import 'package:deardiary/models/journalentry.dart';

class JournalEntryProvider with ChangeNotifier {

  int journalEntryCounter = 0;

  JournalEntryModel? _journalEntry;

  JournalEntryModel? get journalEntry => _journalEntry;

  void journalEntryIDCounter(JournalEntryModel journalEntryModel){
    journalEntryCounter++;
    journalEntryModel.journalEntryID= journalEntryCounter.toString();
  }

  void setJournalEntry(JournalEntryModel journalEntry) {
    _journalEntry = journalEntry;
    notifyListeners();
  }

  /*
  void updateJournalEntryID(int journalEntryID) {
    _journalEntry!.journalEntryID = journalEntryID;
    notifyListeners();
  }*/

  void updateOwnerID(int ownerID) {
    _journalEntry!.ownerID = ownerID.toString();
    notifyListeners();
  }

  void updateJournalEntryTitle(String journalEntryTitle) {
    _journalEntry!.journalEntryTitle = journalEntryTitle;
    notifyListeners();
  }

  void updateJournalEntryContent(String journalEntryContent) {
    _journalEntry!.journalEntryContent = journalEntryContent;
    notifyListeners();
  }

  void updateJournalEntryTags(List<String> journalEntryTags) {
    _journalEntry!.journalEntryTags = journalEntryTags;
    notifyListeners();
  }

  void updateJournalEntryImage(String journalEntryImage) {
    _journalEntry!.journalEntryImage = journalEntryImage;
    notifyListeners();
  }

  void updateJournalEntryGeo(String journalEntryGeo) {
    _journalEntry!.journalEntryGeo = journalEntryGeo;
    notifyListeners();
  }

  void updateJournalEntryCreationDate(DateTime journalEntryCreationDate) {
    _journalEntry!.journalEntryCreationDate = journalEntryCreationDate;
    notifyListeners();
  }

  void updateJournalEntryLastUpdate(DateTime journalEntryLastUpdate) {
    _journalEntry!.journalEntryLastUpdate = journalEntryLastUpdate;
    notifyListeners();
  }

  void deleteJournalEntry() {
    _journalEntry = null;
    notifyListeners();
  }
}
