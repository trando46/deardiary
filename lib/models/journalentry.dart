
final String tableJournalEntry = 'journalentry';

class JournalEntryModelFields{
  static const String id = '_id';
  static const String ownerID = '_oid';
  static const String journalEntryTitle = 'journalEntryTitle';
  static const String journalEntryContent = 'journalEntryContent';
  static const String journalEntryTags = "journalEntryTags"; // will parse a lsit of entry tags later.
  static const String journalEntryImage = "journalEntryImage";
  static const String journalEntryGeo = "journalEntryGeo";
  static const String journalEntryCreationDate = "creationTime";         //DateTime.now();
  static const String journalEntryLastUpdate = "updateTime";


}

class JournalEntryModel{

  String? journalEntryID;
  String ownerID;
  String journalEntryTitle;
  String journalEntryContent;
  List<String> journalEntryTags = [];
  String journalEntryImage;
  String journalEntryGeo;
  DateTime journalEntryCreationDate;
  DateTime journalEntryLastUpdate;


  JournalEntryModel({
    required this.journalEntryID,
    required this.ownerID,
    required this.journalEntryTitle,
    required this.journalEntryCreationDate,
    required this.journalEntryLastUpdate,
    this.journalEntryContent = '',
    this.journalEntryImage = '',
    this.journalEntryGeo ='',

  });

  //Needed for the database create as it couldn't see ownerID.
  String returnOwnerID(){
    return ownerID;
  }

  Map<String, Object?> toJson() => {
    JournalEntryModelFields.id: journalEntryID,
    JournalEntryModelFields.ownerID: ownerID,
    JournalEntryModelFields.journalEntryTitle: journalEntryTitle,
    JournalEntryModelFields.journalEntryContent: journalEntryContent,
    JournalEntryModelFields.journalEntryGeo: journalEntryGeo,
    JournalEntryModelFields.journalEntryImage: journalEntryImage,
    JournalEntryModelFields.journalEntryTags: journalEntryTags,
    JournalEntryModelFields.journalEntryCreationDate: journalEntryCreationDate.toIso8601String(), // converting
    JournalEntryModelFields.journalEntryLastUpdate: journalEntryLastUpdate.toIso8601String() // converting
  };

  JournalEntryModel copy({
  String? journalEntryID,
  String? ownerID,
  String? journalEntryTitle,
  String? journalEntryContent,
  List<String>? journalEntryTags,
  String? journalEntryImage,
  String? journalEntryGeo,
  DateTime? journalEntryCreationDate,
  DateTime? journalEntryLastUpdate,

}) => JournalEntryModel(
    journalEntryID : journalEntryID ?? this.journalEntryID,
    ownerID : ownerID ?? this.ownerID,
    journalEntryTitle : journalEntryTitle ?? this.journalEntryTitle ,
    journalEntryContent : journalEntryContent ?? this.journalEntryContent ,
    //journalEntryTags : journalEntryTags ?? this.journalEntryTags, //not part of model?
    journalEntryImage : journalEntryImage ?? this.journalEntryImage,
    journalEntryGeo : journalEntryGeo ?? this.journalEntryGeo,
    journalEntryCreationDate : journalEntryCreationDate ?? this.journalEntryCreationDate,
    journalEntryLastUpdate : journalEntryLastUpdate ?? this.journalEntryLastUpdate,
  );




}