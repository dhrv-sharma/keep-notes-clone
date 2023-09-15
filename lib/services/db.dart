// for sqlite services

import 'package:flutter/material.dart';
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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
      ${NotesImpnames.id} $idType,
      ${NotesImpnames.pin} $boolType,
      ${NotesImpnames.isArchived} $boolType,
      ${NotesImpnames.title} $textType,
      ${NotesImpnames.content} $textType,
      ${NotesImpnames.createdTime} $textType

    )
    ''');
  }

// entering the data in the database as here we get note object as in argument
  Future<note?> InsertEntry(note noteEX) async {
    final db = await instance.database;
    final id = await db!.insert(NotesImpnames.tableaName,
        noteEX.toJson()); // objet data converted in to json file

    return noteEX.copy(id: id); // return copy of object
  }

  Future<note?> readOneNote(int id) async {
    // id is used as PRIMARY key
    final db = await instance.database;
    // while query we get the data in the form map
    final map = await db!.query(NotesImpnames.tableaName,
        // columns only that particular columns get printed
        where: '${NotesImpnames.id} = ?', // condition set
        whereArgs: [id]);
    // condition value set ? = id

    print(map);

    if (map.isNotEmpty) {
      // map.first return the first entry of the map
      return note.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future<List<note>> readNotes() async {
    final db = await instance.database;
    final orderList =
        '${NotesImpnames.createdTime} ASC'; // sorting the data from the table in ascending order of time
    final query_result = await db!.query(NotesImpnames.tableaName, where: '${NotesImpnames.pin} = 0 AND ${NotesImpnames.isArchived} = 0',
        orderBy: orderList); //Notes is the name of the database

    return query_result.map((json) => note.fromJson(json)).toList();
  }

  Future<int> updateNote(note noteEx) async {
    final db = await instance.database;
    return await db!.update(NotesImpnames.tableaName, noteEx.toJson(),
        where: '${NotesImpnames.id} = ?', whereArgs: [noteEx.id]);
  }

  Future<int> deleteNote(note? noteEx) async {
    final db = await instance.database;
    return await db!.delete(NotesImpnames.tableaName,
        where: '${NotesImpnames.id} = ? ', whereArgs: [noteEx!.id]);
  }

  Future<List<int>> getNoteString(String query) async {
    String noteText = "";
    final db = await instance.database;
    final result = await db!.query(NotesImpnames.tableaName);
    List<int> resultids = [];

    result.forEach((element) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultids.add(element["id"] as int);
      }
    });

    print(resultids);

    return resultids;
  }

  Future pinNote(note? noteEx) async {
    final db = await instance.database;
    
    
    bool check=(noteEx!.pin);

    await db!.update(
        NotesImpnames.tableaName, {NotesImpnames.pin: check ? 0 : 1},
        where: '${NotesImpnames.id} = ?', whereArgs: [noteEx.id]);

  }

  Future archiveNote(note? noteEx) async {
    final db = await instance.database;
    
    
    bool check=(noteEx!.isArchived);

    await db!.update(
        NotesImpnames.tableaName, {NotesImpnames.isArchived: check ? 0 : 1},
        where: '${NotesImpnames.id} = ?', whereArgs: [noteEx.id]);

  }
  Future<List<note>> pinedNotes() async {
    final db = await instance.database;
    final orderList =
        '${NotesImpnames.createdTime} ASC'; // sorting the data from the table in ascending order of time
    final query_result = await db!.query(NotesImpnames.tableaName,
        orderBy: orderList,where: '${NotesImpnames.pin} = 1 AND ${NotesImpnames.isArchived} = 0' ); //Notes is the name of the database

    return query_result.map((json) => note.fromJson(json)).toList();
  }

  Future<List<note>> pinedArchivedNotes() async {
    final db = await instance.database;
    final orderList =
        '${NotesImpnames.createdTime} ASC'; // sorting the data from the table in ascending order of time
    final query_result = await db!.query(NotesImpnames.tableaName,
        orderBy: orderList,where: '${NotesImpnames.pin} = 1 AND ${NotesImpnames.isArchived} = 1' ); //Notes is the name of the database

    return query_result.map((json) => note.fromJson(json)).toList();
  }

   Future<List<note>> readArchivedNotes() async {
    final db = await instance.database;
    final orderList =
        '${NotesImpnames.createdTime} ASC'; // sorting the data from the table in ascending order of time
    final query_result = await db!.query(NotesImpnames.tableaName, where: '${NotesImpnames.pin} = 0 AND ${NotesImpnames.isArchived} = 1',
        orderBy: orderList); //Notes is the name of the database

    return query_result.map((json) => note.fromJson(json)).toList();
  }

  Future closeDb() async {
    final db = await instance.database;
    db!.close();
  }
}
