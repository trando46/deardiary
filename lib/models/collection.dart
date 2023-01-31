import 'package:deardiary/models/journalentry.dart';

class CollectionModel{

  int collectionID;
  int ownerID;
  String collectionTitle;
  List<JournalEntryModel> collectionEntries = [];

  CollectionModel({
    required this.collectionID,
    required this.ownerID,
    required this.collectionTitle,

  });
}