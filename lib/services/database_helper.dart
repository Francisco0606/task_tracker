import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/models/users.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Get the database (if it's already open, return it; if not, open it)
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is not open, open it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'taskDtb.db');

    // Open the database and create the table if it doesn't exist
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE users(
            user_id INTEGER PRIMARY KEY AUTOINCREMENT, 
            username TEXT, 
            password TEXT, 
            email TEXT
          )''',
        );
      },
      version: 1,
    );
  }

  // Insert a new user into the database
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  // Get all users from the database
  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Get a user by username
  Future<User?> getUserByUsername(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // Update an existing user
  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'user_id = ?',
      whereArgs: [user.user_id],
    );
  }

  // Delete a user
  Future<int> deleteUser(int userId) async {
    Database db = await database;
    return await db.delete(
      'users',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}
