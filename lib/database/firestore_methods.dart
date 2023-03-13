/*
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/user.dart';

import '../models/journalentry.dart';

class FireStoreMethods {
  //TODO: Add method to add journal entry to user collection of journalentries.
  Future<void> addJournal(JournalEntryModel journal) async {
    var defaultDateTime = DateTime.now();
    String defaultDateTimeString = defaultDateTime.toIso8601String();
    var db = FirebaseFirestore.instance;

    final outgoingJournal = <String, String>{
      "ownerID": journal.ownerID,
      "journalEntryTitle": journal.journalEntryTitle,
      "journalEntryContent": journal.journalEntryContent,
      "journalEntryImage": journal.journalEntryImage,
      "journalEntryGeo": journal.journalEntryGeo, //TODO: Parse this maybe?
      "journalEntryCreationDate":
          journal.journalEntryCreationDate.toIso8601String(),
      "journalEntryLastUpdate":
          journal.journalEntryLastUpdate.toIso8601String(),
    };

    //var doc = db.collection("users").doc(journal.journalEntryID!.toString()); //use doc id to update. Not sure if this is the right one to use.
    var doc = db.collection("users").doc(journal
        .ownerID); //use doc id to update. Not sure if this is the right one to use.
    var doc2 = doc.collection("journals").doc();
    doc2
        .set(outgoingJournal)
        //.then((value) => _getAllEntriesAsync(),
        .then((value) => null,
            onError: (e) => print("Error writing document: $e"));
  }

  ///Retrieves all online journal entries for a particular user.
  Future<List<JournalEntryModel>> getAllOnlineEntries() async {
    var db = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    List<JournalEntryModel> returnList =
        <JournalEntryModel>[]; //required literal <>[] assignment

    var snapshot = await db.collection("users").doc(user!.uid);
    //var snapshot2 = snapshot.collection(user!.uid).get();
    var snapshot2 = await snapshot.collection("journals").get();

    JournalEntryModel newJournalEntry;

    for (var doc in snapshot2.docs) {
      print(doc.id);
      var data = doc.data;
      newJournalEntry = convertJournalEntry(doc, user!.uid);
      returnList.add(newJournalEntry);
    }
    //var x = 2;

    return returnList;
  }

  ///Conversion method for journal entries retrieved from firestore.
  JournalEntryModel convertJournalEntry(
      QueryDocumentSnapshot doc, String userID) {
    return JournalEntryModel(
      ownerID: userID,
      onlineID: doc.id,
      journalEntryTitle: doc['journalEntryTitle'],
      journalEntryContent: doc['journalEntryContent'],
      journalEntryImage: doc['journalEntryImage'],
      journalEntryGeo: doc['journalEntryGeo'],
      journalEntryCreationDate: DateTime.parse(doc['journalEntryCreationDate']),
      journalEntryLastUpdate: DateTime.parse(doc['journalEntryLastUpdate']),
      //journalEntryID: ,
    );
  }

  //TODO: Update a particular journal entry by document ID.
  Future<void> updateJournal(JournalEntryModel journal) async {
    var db = FirebaseFirestore.instance;
    var doc = db
        .collection("users")
        .doc(journal.ownerID)
        .collection("journals")
        .doc(journal.onlineID);

    doc.update({
      "journalEntryTitle": journal.journalEntryTitle,
      "journalEntryContent": journal.journalEntryContent,
      "journalEntryImage": journal.journalEntryImage,
      "journalEntryGeo": journal.journalEntryGeo,
      "journalEntryLastUpdate":
          journal.journalEntryLastUpdate.toIso8601String(),
    });
  }

  Future<void> updateGeolocation(JournalEntryModel journal) async {
    var db = FirebaseFirestore.instance;
    var doc = db
        .collection("users")
        .doc(journal.ownerID)
        .collection("journals")
        .doc(journal.onlineID);

    doc.update({
      "journalEntryGeo": journal.journalEntryGeo,
      "journalEntryLastUpdate":
          journal.journalEntryLastUpdate.toIso8601String(),
    });
  }

  //TODO: Delete a particular journal entry
  Future<void> deleteJournal(JournalEntryModel journal) async {
    var db = FirebaseFirestore.instance;
    var doc = db
        .collection("users")
        .doc(journal.ownerID)
        .collection("journals")
        .doc(journal.onlineID);

    doc.delete();
  }

  //TODO: Delete a user and all associated information.
}
*/
