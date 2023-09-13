// for sqlite services

import 'package:noteapp/model/mynote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class noteDatabase {
  static final noteDatabase instance = noteDatabase._init();
  static Database?
      _database; // if there is any database then it will return it otherwise will create it;
  noteDatabase._init();

// This getter method is used to retrieve the SQLite database instance. If _database is not null, it returns the existing database. Otherwise, it calls _initializeDB to create and open a new database and stores it in _database.
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB(
        'Notes.db'); //Notes.db is name of database for this app
    return _database;
  }

// This private method is responsible for initializing the SQLite database.
// It constructs the database path and opens the database.
// The database schema (table structure) is defined in the CREATE TABLE SQL statement.
  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

// This method is called during database initialization to create the Notes table with specific columns: id, pin, title, content, and createdTime.
  Future _createDB(Database db, int version) async {
    final idType ='INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType='BOOLEAN NOT NULL';
    final textType='TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
      ${NotesImpnames.id} $idType,
      ${NotesImpnames.pin} $boolType,
      ${NotesImpnames.title} $textType,
      ${NotesImpnames.content} $textType,
      ${NotesImpnames.createdTime} $textType

    )
    ''');
  }


  Future<note?> InsertEntry(note noteEX) async {
    final db = await instance.database;
    final id=await db!.insert(NotesImpnames.tableaName,noteEX.toJson());
    return noteEX.copy(id: id);
  }


  Future<note?> readOneNote(int id) async {
    // id is used as PRIMARY key
    final db = await instance.database;
    final map = await db!.query(NotesImpnames.tableaName,
        columns: NotesImpnames.value, // columns only that particular columns get printed
        where: '${NotesImpnames.id} = ?', // condition set
        whereArgs: [id]); // condition value set ? = id

    if(map.isNotEmpty){
      return note.fromJson(map.first);
    }else{
      return null;
    }
  }

  // Future<note> readNotes() async {
  //   final db = await instance.database;
  //   final orderList =
  //       '${NotesImpnames.createdTime} ASC'; // sorting the data from the table in ascending order of time
  //   final query_result = await db!
  //       .query(NotesImpnames.tableaName, orderBy: orderList); //Notes is the name of the database
  //   print(query_result);
  //    return query_result.map((json) => note.fromJson(json)).toList();
  // }

  Future<int> updateNote(int id) async {
    final db = await instance.database;
    return await db!.update("Notes", {"title": "this is updated title "},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    final db=await instance.database;
    return await db!.delete("Notes",where: 'id = ? ',whereArgs: [id]);
  }
}
