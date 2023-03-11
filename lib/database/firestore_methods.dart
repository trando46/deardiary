import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/user.dart';

import '../models/journalentry.dart';


class FireStoreMethods {

  var onlineDB = FirebaseFirestore.instance;


  //TODO: Add method to add journal entry to user collection of journalentries.
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
      var doc2 = doc.collection("journals").doc(journal.journalEntryID!.toString());
      doc2.set(outgoingJournal)
          //.then((value) => _getAllEntriesAsync(),
          .then((value) => null,
          onError: (e) => print("Error writing document: $e"));

  }

  //TODO: Retrieve one journal entry for a user.


  //TODO: Retrieve all journal entries for a user.


  //TODO: Add Retrieved list of journal entries to journalentry_provider


  //TODO: Update a particular journal entry by document ID.


  //TODO: Delete a particular journal entry


  //TODO: Delete a user and all associated information.

}

