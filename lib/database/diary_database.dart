import 'package:sqflite/sqflite.dart';
import 'package:deardiary/models/journalentry.dart';
//import 'package:deardiary/models/collection.dart';
//import 'package:deardiary/models/user.dart';


/**
 * DiaryDatabase is the local Sqlite.
 */
class DiaryDatabase{

  static final DiaryDatabase instance = DiaryDatabase._init();

  static Database? _database; //creating db.

  DiaryDatabase._init(); //initializing db.


  Future<Database> get database async{
    if(_database != null) return _database!; //return database if it does not exist.

    //otherwise create new db.
    _database = await _initDB('deardiary.db');
    return _database!; //null safety for database.
  }

  //manage path
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath(); //gets database path location only for android or ios.
    //final path = join(dbPath, filePath);
    final path = dbPath+filePath;

    //return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _upgradeDB);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }


/*  Future _upgradeDB(Database db, int oldversion, int newversion) async{
    return _createDB(db, newversion);
  }*/

  Future _createDB(Database db, int version) async{
    //placeholder for schema
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const integerType = "INTEGER NOT NULL";
    const textType = "TEXT NOT NULL";

    //table matching our journal entry model.
    await db.execute('''
        CREATE TABLE $tableJournalEntry (
        ${JournalEntryModelFields.journalEntryID} $idType,
        ${JournalEntryModelFields.ownerID} $integerType,
        ${JournalEntryModelFields.journalEntryTitle} $textType,
        ${JournalEntryModelFields.journalEntryContent} $textType,
        ${JournalEntryModelFields.journalEntryTags} $textType,
        ${JournalEntryModelFields.journalEntryImage} $textType,
        ${JournalEntryModelFields.journalEntryGeo} $textType,
        ${JournalEntryModelFields.journalEntryCreationDate} $textType,
        ${JournalEntryModelFields.journalEntryLastUpdate} $textType
    )
    ''');
  }

  Future<JournalEntryModel> read(int id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Query the table for all The Dogs.
    final maps = await db.query(
        tableJournalEntry,
        columns: JournalEntryModelFields.values,
        where: '${JournalEntryModelFields.journalEntryID} = ?',
        whereArgs: [id],
    );

    if (maps.isEmpty)
    {
      throw Exception("Journal Entry Missing ID:  $id");
    }

    return JournalEntryModel.fromJson(maps.first);

  }

  Future<List<JournalEntryModel>> getAll() async {
    final db = await instance.database;

    final allEntries = await db.query(tableJournalEntry);

    return allEntries.map((j) => JournalEntryModel.fromJson(j)).toList();


  }


  Future create(JournalEntryModel journal) async {
    final db = await instance.database;

    await db.insert(tableJournalEntry, journal.toJson());

  }



  Future close() async{
    final db = await instance.database;
    db.close(); //closes connection to database.
  }




}