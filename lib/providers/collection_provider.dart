import 'package:flutter/material.dart';
import 'package:deardiary/models/collection.dart';

class CollectionProvider with ChangeNotifier {
  CollectionModel? _collection;

  CollectionModel? get collection => _collection;

  void setCollection(CollectionModel collection) {
    _collection = collection;
    notifyListeners();
  }
}
