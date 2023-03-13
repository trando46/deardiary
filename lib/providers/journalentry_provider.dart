import 'package:deardiary/database/diary_database.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/journalentry.dart';
import 'firestore_provider.dart';

class JournalEntryProvider with ChangeNotifier {
  List<JournalEntryModel> _journalEntry = [];
  FirestoreProvider _firestore;

  List<JournalEntryModel> get allJournalEntries => _journalEntry.toList();

  JournalEntryProvider({required FirestoreProvider firestore}) : _firestore = firestore
  {
    _journalEntry.clear();
    _getAllEntriesAsync();
  }

  Future _getAllEntriesAsync() async {
    //final entries = await DiaryDatabase.instance.getAll();
    //_journalEntry = entries;


    _journalEntry = await _firestore.getAllOnlineEntries();

    notifyListeners();
  }

/*  void journalEntryIDCounter(JournalEntryModel journalEntryModel) {
    //journalEntryCounter++;
    //journalEntryModel.journalEntryID = journalEntryCounter.toString();
  }*/

  void addJournalEntry(JournalEntryModel journalEntry) {
    //_journalEntry.add(journalEntry);   //moving to database not provider.

    //Adding in journal entry connection. - Greg
    DiaryDatabase.instance.create(journalEntry);
    _firestore.addJournal(journalEntry);

    //TODO: Also add entry to users collection of journals.

    _getAllEntriesAsync();
    //notifyListeners();
  }

  void updateJournalEntry(JournalEntryModel journalEntry, String title,
      String content, String geo, String image) {
    journalEntry.journalEntryTitle = title;
    journalEntry.journalEntryContent = content;
    journalEntry.journalEntryGeo = geo;
    journalEntry.journalEntryImage = image;
    journalEntry.journalEntryLastUpdate = DateTime.now();

    DiaryDatabase.instance.update(journalEntry);
    _firestore.updateJournal(journalEntry);

    _getAllEntriesAsync();
  }

  // void updateOwnerID(JournalEntryModel entry, int ownerID) {
  //   if (_journalEntry.contains(entry)) {
  //     _journalEntry[_journalEntry.indexOf(entry)].ownerID = ownerID.toString();
  //     _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
  //         DateTime.now();
  //   }
  //   notifyListeners();
  // }

  // void updateJournalEntryTitle(
  //     JournalEntryModel entry, String journalEntryTitle) {
  //   if (_journalEntry.contains(entry)) {
  //     _journalEntry[_journalEntry.indexOf(entry)].journalEntryTitle =
  //         journalEntryTitle;
  //     _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
  //         DateTime.now();
  //   }
  //   notifyListeners();
  // }

  // void updateJournalEntryContent(
  //     JournalEntryModel entry, String journalEntryContent) {
  //   if (_journalEntry.contains(entry)) {
  //     _journalEntry[_journalEntry.indexOf(entry)].journalEntryContent =
  //         journalEntryContent;
  //     _journalEntry[_journalEntry.indexOf(entry)].journalEntryLastUpdate =
  //         DateTime.now();
  //   }
  //   notifyListeners();
  // }

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
    entry.journalEntryGeo = journalEntryGeo;
    entry.journalEntryLastUpdate = DateTime.now();

    DiaryDatabase.instance.update(entry);
    _firestore.updateGeolocation(entry);

    _getAllEntriesAsync();
  }

  void deleteJournalEntry(JournalEntryModel entry) {
    _journalEntry.remove(entry);
    DiaryDatabase.instance.delete(entry);
    _firestore.deleteJournal(entry);
    _getAllEntriesAsync();

    notifyListeners();
  }
}
