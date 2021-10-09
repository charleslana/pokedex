import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBService {
  String table = 'favorites';

  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, '$table.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $table (id INTEGER PRIMARY KEY, pokemon_id INTEGER)');
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database();
    return db.query(table);
  }

  Future<void> insert(Map<String, Object> data) async {
    final db = await database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(int pokemonId) async {
    final db = await database();
    await db.delete(table, where: 'pokemon_id = ?', whereArgs: [pokemonId]);
  }
}
