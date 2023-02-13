import 'package:sqflite/sqflite.dart';
import 'package:deardiary/models/journalentry.dart';
//import 'package:deardiary/models/collection.dart';
//import 'package:deardiary/models/user.dart';


class DiaryDatabase{

  static final DiaryDatabase instance = DiaryDatabase.init();

  static Database? _database; //creating db.

  DiaryDatabase.init(); //initializing db.


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
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const integerType = "INTEGER NOT NULL";
    const textType = "TEXT NOT NULL";


    await db.execute('''
        CREATE TABLE $tableJournalEntry (
        ${JournalEntryModelFields.id} $idType,
        ${JournalEntryModelFields.ownerID} $integerType,
        ${JournalEntryModelFields.journalEntryTitle} $textType,
        ${JournalEntryModelFields.journalEntryContent} $textType,
        ${JournalEntryModelFields.journalEntryTags} $textType,
        ${JournalEntryModelFields.journalEntryImage} $textType,
        ${JournalEntryModelFields.journalEntryGeo} $textType, //Switch to better? geo location later
        ${JournalEntryModelFields.journalEntryCreationDate} $textType, //Convert out on parse
        ${JournalEntryModelFields.journalEntryLastUpdate} $textType, //Convert back out on parse
    )
    ''');
  }

  Future<JournalEntryModel> create(JournalEntryModel journal) async {
    final db = await instance.database;

    final id = await db.insert(tableJournalEntry, journal.toJson());

    return journal.copy(journalEntryID: id.toString());

  }

  Future close() async{
    final db = await instance.database;
    db.close(); //closes connection to database.
  }




}