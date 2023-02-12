
final String tableJournalEntry = 'journalentry';

class JournalEntryModelFields{
  static final String journalEntryId = '_id';
  static final String ownerId = '_oid';
  static final String journalEntryTitle = 'journalEntryTitle';
  static final String journalEntryContent = 'journalEntryContent';
  static final String journalEntryTags = "pending";//TODO: check this, maybe another table.
  static final String journalEntryImage = "journalEntryImage";
  static const String journalEntryGeo = "journalEntryImage";
  static final DateTime journalEntryCreationDate = DateTime.now();
  static final DateTime journalEntryLastUpdate = DateTime.now();


}

class JournalEntryModel{

  String journalEntryID;
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
}