import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'movie_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
        id INTEGER PRIMARY KEY,
        title TEXT,
        originalTitle TEXT,
        overview TEXT,
        posterPath TEXT,
        backDropPath TEXT,
        realseDate TEXT,
        voteAverage REAL
      )
    ''');
  }

  Future<int> insertMovie(Movie movie) async {
    Database db = await database;
    return await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getMovies() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('movies');
    var x = List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        backDropPath: maps[i]['title'],
        originalTitle: maps[i]['title'],
        overview: maps[i]['title'],
        posterPath: maps[i]['title'],
        realseDate: maps[i]['title'],
        voteAverage: maps[i]['voteAverage'],
      );
    });

    return x;
  }
}
