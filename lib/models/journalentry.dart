import 'dart:convert';

final String tableJournalEntry = 'journalentry';

class JournalEntryModelFields {
  static const String journalEntryID = 'journalEntryID';
  static const String ownerID = 'ownerID';
  static const String journalEntryTitle = 'journalEntryTitle';
  static const String journalEntryContent = 'journalEntryContent';
  static const String journalEntryTags =
      "journalEntryTags"; // will parse a lsit of entry tags later.
  static const String journalEntryImage = "journalEntryImage";
  static const String journalEntryGeo = "journalEntryGeo";
  static const String journalEntryCreationDate =
      "creationTime"; //DateTime.now();
  static const String journalEntryLastUpdate = "updateTime";

  static final List<String> values = [
    journalEntryID,
    ownerID,
    journalEntryTitle,
    journalEntryContent,
    journalEntryTags,
    journalEntryImage,
    journalEntryGeo,
    journalEntryCreationDate,
    journalEntryLastUpdate
  ];
}

class JournalEntryModel {
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

  JournalEntryModel({
    //required this.journalEntryID,
    this.journalEntryID,
    required this.ownerID,
    required this.journalEntryTitle,
    required this.journalEntryCreationDate,
    required this.journalEntryLastUpdate,
    this.journalEntryContent = '',
    this.journalEntryImage = '',
    this.journalEntryGeo = '',
  });

  //Needed for the database create as it couldn't see ownerID.
  String returnOwnerID() {
    return ownerID;
  }

  /**
   * Must turn the object into map, so use JSON.
   */
  Map<String, Object?> toJson() => {
        JournalEntryModelFields.journalEntryID: journalEntryID,
        JournalEntryModelFields.ownerID: ownerID,
        JournalEntryModelFields.journalEntryTitle: journalEntryTitle,
        JournalEntryModelFields.journalEntryContent: journalEntryContent,
        JournalEntryModelFields.journalEntryGeo: journalEntryGeo,
        JournalEntryModelFields.journalEntryImage: journalEntryImage,
        JournalEntryModelFields.journalEntryTags:
            jsonEncode(journalEntryTags), //turns list to json strings
        JournalEntryModelFields.journalEntryCreationDate:
            journalEntryCreationDate.toIso8601String(), // converting
        JournalEntryModelFields.journalEntryLastUpdate:
            journalEntryLastUpdate.toIso8601String() // converting
      };

  static JournalEntryModel fromJson(Map<String, Object?> json) =>
      JournalEntryModel(
        journalEntryID: json[JournalEntryModelFields.journalEntryID] as int,
        ownerID: json[JournalEntryModelFields.ownerID] as String,
        journalEntryTitle:
            json[JournalEntryModelFields.journalEntryTitle] as String,
        journalEntryContent:
            json[JournalEntryModelFields.journalEntryContent] as String,
        journalEntryImage:
            json[JournalEntryModelFields.journalEntryImage] as String,
        journalEntryCreationDate: DateTime.parse(
            json[JournalEntryModelFields.journalEntryCreationDate] as String),
        journalEntryLastUpdate: DateTime.parse(
            json[JournalEntryModelFields.journalEntryLastUpdate] as String),
        journalEntryGeo:
            json[JournalEntryModelFields.journalEntryGeo] as String,
      );
}
