import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/material.dart';
import 'package:deardiary/models/collection.dart';

class CollectionProvider with ChangeNotifier {
  CollectionModel? _collection;

  CollectionModel? get collection => _collection;

  void setCollection(CollectionModel collection) {
    _collection = collection;
    notifyListeners();
  }

  void updateCollectionID(int collectionID) {
    _collection!.collectionID = collectionID;
    notifyListeners();
  }

  void updateOwnerID(int ownerID) {
    _collection!.ownerID = ownerID;
    notifyListeners();
  }

  void updateCollectionTitle(String collectionTitle) {
    _collection!.collectionTitle = collectionTitle;
    notifyListeners();
  }

  void updateCollectionEntries(List<JournalEntryModel> collectionEntries) {
    _collection!.collectionEntries = collectionEntries;
    notifyListeners();
  }

  void deleteCollection() {
    _collection = null;
    notifyListeners();
  }
}
