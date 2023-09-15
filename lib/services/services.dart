// for sqlite services

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Notedata {
  static final Notedata instance = Notedata._init();
  static Database?
      _database; // if there is any database then it will return it otherwise will create it;
  Notedata._init();

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
    //  writing sql query with parameters and their constraints
    // variblename TYPE CONSTRAINT
    // varibale name should be same as using insert command
    await db.execute('''
    CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pin BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdTime TEXT NOT NULL
    )
    ''');
  }

// This method is used to insert a new record (row) into the Notes table.
// It takes default values for pin, title, content, and createdTime.
// It returns true once the insertion is successful.
  Future<bool?> InsertEntry() async {
    final db = await instance.database;
    //Notes is the name of database
    // given as MAP
    //Notes here database name
    // no need to give id as it is auto incremneted
    // bool is given as 0
    await db!.insert("Notes", {
      "pin": 0,
      "title": "THIS IS MY TITLE",
      "content": "THIS IS MY NOTE CONTENT",
      "createdTime": "26 Jan 2018"
    });
    return true;
  }

// readNotes Method:
// This method is intended for reading data from the Notes table.
// It fetches all records from the table using a simple query and prints the result.
// The query result is a list of maps, where each map represents a row in the table.
// It returns a hardcoded string "Succesffull" (typo: "Successful").
  Future<String> readNotes() async {
    final db = await instance.database;
    final orderList =
        'createdTime ASC'; // sorting the data from the table in ascending order of time
    final query_result = await db!
        .query("Notes", orderBy: orderList); //Notes is the name of the database
    print(query_result);
    return "Succesffull";
  }

  Future<String?> readOneNote(int id) async {
    // id is used as PRIMARY key
    final db = await instance.database;
    final map = await db!.query("Notes",
        columns: ["title"], // columns only that particular columns get printed
        where: 'id = ?', // condition set
        whereArgs: [id]); // condition value set ? = id

    print(map);
    return "Success";
  }

  Future<int> updateNote(int id) async {
    final db = await instance.database;
    return await db!.update("Notes", {"title": "this is updated title "},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    final db=await instance.database;
    return await db!.delete("Notes",where: 'id = ?',whereArgs: [id]);
  }
}
