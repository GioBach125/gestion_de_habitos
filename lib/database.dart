import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/habit.dart';
import 'models/profile.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'habit_database.db');
    return openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE profiles(id INTEGER PRIMARY KEY, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE habits(id INTEGER PRIMARY KEY, name TEXT, daysCompleted TEXT, profileId INTEGER)',
    );
  }

  Future<void> insertProfile(Profile profile) async {
    final db = await database;
    await db.insert('profiles', profile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertHabit(Habit habit) async {
    final db = await database;
    await db.insert('habits', habit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Profile>> getProfiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('profiles');
    return List.generate(maps.length, (i) {
      return Profile.fromMap(maps[i]);
    });
  }

  Future<List<Habit>> getHabits(int profileId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('habits', where: 'profileId = ?', whereArgs: [profileId]);
    return List.generate(maps.length, (i) {
      return Habit.fromMap(maps[i]);
    });
  }

  Future<void> updateHabit(Habit habit) async {
    final db = await database;
    await db.update(
      'habits',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  Future<void> deleteProfile(int id) async {
    final db = await database;
    await db.delete(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteHabit(int id) async {
    final db = await database;
    await db.delete(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
