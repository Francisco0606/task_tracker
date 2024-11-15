import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/models/users.dart';

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
    String path = join(await getDatabasesPath(), 'task.db');

    // Open the database and create the table if it doesn't exist
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE users(
            user_id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT,
            username TEXT, 
            password TEXT, 
            email TEXT
          )''',
        );
      },
      version: 1,
    );
  }

  // Insert a user into the database and return the user_id
  Future<int> insertUser(User user) async {
    Database db = await database;
    // Insert the user and get the user_id of the inserted row
    int userId = await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userId; // Return the inserted user's ID
  }

  // Method to check if a username already exists in the database
  Future<bool> doesUsernameExist(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty; // If maps are not empty, the username exists
  }

  // Method to check if an email already exists in the database
  Future<bool> doesEmailExist(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty; // If maps are not empty, the email exists
  }

  // Method to check if the provided username/email and password are correct
  Future<int?> validateUserLogin(
      String usernameOrEmail, String password) async {
    Database db = await database;

    // Query by username or email
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: '(username = ? OR email = ?) AND password = ?',
      whereArgs: [usernameOrEmail, usernameOrEmail, password],
    );

    if (maps.isNotEmpty) {
      return maps.first['user_id']; // Return the user_id if a match is found
    }

    return null; // Return null if no match is found
  }

  // Get all users from the database
  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }
}
