import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/models.dart';

class SqliteRepository {
  static const _databaseName = "doggie.db";
  static const _tableName = "dogs";
  static const _dogId = "id";
  static const _databaseVersion = 1;

  SqliteRepository._privateConstructor();

  static final SqliteRepository instance =
      SqliteRepository._privateConstructor();

  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $_tableName (
        $_dogId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    """);
  }

  Future<Database> _initDatabase() async {
    final documentDirectory = await getDatabasesPath();
    final databasePath = join(documentDirectory, _databaseName);
    // TODO: REMEMBER TO TURN OF DEBUG MODE
    Sqflite.setDebugModeOn(true);
    return openDatabase(
      databasePath,
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database as Database;
  }

  Future<void> insertDog(Dog dog) async {
    final db = await database;
    await db.insert(
      _tableName,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Dog?> getDog(int id) async {
    final db = await database;
    final results = await db.query(_tableName, where: "id = $id");
    return results.isNotEmpty ? Dog.fromMap(results.first) : null;
  }

  Future<void> deleteDog(Dog dog) async {
    final db = await database;
    await db.delete(_tableName, where: "id = ${dog.id}");
  }

  Future<void> updateDog(int id, Dog newDog) async {
    final db = await database;
    await db.update(
      _tableName,
      newDog.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<Dog>> getAllDogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i][_dogId],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }
}
