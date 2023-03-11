import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deardiary/database/diary_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/database/firestore_methods.dart';

class JournalEntryProvider with ChangeNotifier {
  List<JournalEntryModel> _journalEntry = [];

  List<JournalEntryModel> get allJournalEntries => _journalEntry.toList();

  JournalEntryProvider() {
    _journalEntry.clear();
    _getAllEntriesAsync();
  }

  Future _getAllEntriesAsync() async {
    final entries = await DiaryDatabase.instance.getAll();
    _journalEntry = entries;

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
    updateOrAddJournal(journalEntry);

    //TODO: Also add entry to users collection of journals.


    _getAllEntriesAsync();
    //notifyListeners();
  }
  Future<void> updateOrAddJournal(JournalEntryModel journal)
  async {

    var defaultDateTime = DateTime.now();
    String defaultDateTimeString = defaultDateTime.toIso8601String();
    // var defaultRelationship = new TaskRelationship(dstTaskID: "1", relation: TaskRelationshipEnum.subtaskOf);
    // var jsonRelationship = defaultRelationship.toJson();
    var db = FirebaseFirestore.instance;

    /*
      int? journalEntryID;
      String ownerID;
      String journalEntryTitle;
      String journalEntryContent;
      List<String> journalEntryTags = [];
      //String journalEntryTags; //will now be a string with " " separating tags.
      String journalEntryImage;
      String journalEntryGeo;
      DateTime journalEntryCreationDate;
      DateTime journalEntryLastUpdate;
      */

    final outgoingJournal = <String, String>{
      "ownerID": journal.ownerID,
      "journalEntryTitle": journal.journalEntryTitle,
      "journalEntryContent": journal.journalEntryContent,
      "journalEntryImage": journal.journalEntryImage,
      "journalEntryGeo": journal.journalEntryGeo, //TODO: Parse this maybe?
      "journalEntryCreationDate" : journal.journalEntryCreationDate.toIso8601String(),
      "journalEntryLastUpdate" : journal.journalEntryLastUpdate.toIso8601String(),
    };

    //var doc = db.collection("users").doc(journal.journalEntryID!.toString()); //use doc id to update. Not sure if this is the right one to use.
    var doc = db.collection("users").doc(journal.ownerID); //use doc id to update. Not sure if this is the right one to use.
    var doc2 = doc.collection("journals").doc();
    doc2.set(outgoingJournal)
    //.then((value) => _getAllEntriesAsync(),
        .then((value) => null,
        onError: (e) => print("Error writing document: $e"));

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
    DiaryDatabase.instance.delete(entry);
    _getAllEntriesAsync();

    notifyListeners();
  }
}
