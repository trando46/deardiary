import 'package:deardiary/models/journalentry.dart';

final String tableCollection = 'collection';

class CollectionModelFields{
  static final String collectionID = '_id';
  static final String ownerID = "_oid";
  static final String collectionTitle = "collectionTitle";
  static final String collectionEntries = "fk_collectionEntries";
  //static final List collectionEntries = "fk_collectionEntries"; //maybe another table?

}


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