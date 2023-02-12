import 'package:sqflite/sqflite.dart';
import 'package:deardiary/models/collection.dart';
import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/models/user.dart';


class DiaryDatabase{

  static final DiaryDatabase instance = DiaryDatabase.init();

  static Database? _database; //creating db.

  DiaryDatabase.init(); //initalizing db.


  Future<Database> get database async{
    if(_database != null) return database; //return database if it does not exist.

    //otherwise create new db.
    _database = await _initDB('deardiary.db');
    return _database!; //! is
  }

  //manage path
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath(); //gets database path location only for android or ios.
    //final path = join(dbPath, filePath);
    final path = dbPath+filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    //placeholder for schema


  }

  Future close() async{
    final db = await instance.database;
    db.close(); //closes connection to database.
  }




}