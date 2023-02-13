
final String tableJournalEntry = 'journalentry';

class JournalEntryModelFields{
  static final String id = '_id';
  static final String ownerId = '_oid';
  static final String journalEntryTitle = 'journalEntryTitle';
  static final String journalEntryContent = 'journalEntryContent';
  static final String journalEntryTags = "journalEntryTags"; // will parse a lsit of entry tags later.
  static final String journalEntryImage = "journalEntryImage";
  static const String journalEntryGeo = "journalEntryGeo";
  static final String journalEntryCreationDate = "creationTime";         //DateTime.now();
  static final String journalEntryLastUpdate = "updateTime";


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

  Map<String, Object?> toJson() => {
    JournalEntryModelFields.id: journalEntryID,
    JournalEntryModelFields.ownerId: ownerID,
    JournalEntryModelFields.journalEntryTitle: journalEntryTitle,
    JournalEntryModelFields.journalEntryContent: journalEntryContent,
    JournalEntryModelFields.journalEntryGeo: journalEntryGeo,
    JournalEntryModelFields.journalEntryImage: journalEntryImage,
    JournalEntryModelFields.journalEntryTags: journalEntryTags,
    JournalEntryModelFields.journalEntryCreationDate: journalEntryCreationDate.toIso8601String(), // converting
    JournalEntryModelFields.journalEntryLastUpdate: journalEntryLastUpdate.toIso8601String() // converting
  };

}