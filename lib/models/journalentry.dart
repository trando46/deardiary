

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