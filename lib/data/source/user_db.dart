import 'package:path/path.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:sqflite/sqflite.dart';

class UserDb {
  static UserDb? _userDb;
  static late Database _database;

  UserDb._internal() {
    _userDb = this;
  }

  factory UserDb() => _userDb ?? UserDb._internal();

  Future<Database> get database async {
    _database = await _initUserDb();
    return _database;
  }

  final String _tableName = 'user';

  Future<Database> _initUserDb() async {
    var db = openDatabase(join(await getDatabasesPath(), 'user_db.db'),
        onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT, eksponensialScore REAL, spltvScore REAL, fungsiScore REAL, totalScore REAL, aljabarStrength TEXT)''',
      );
    }, version: 3);
    return db;
  }

  Future<List<UserDataEntity>> getAllUser() async {
    try {
      final db = await database;
      final userList = await db.query(_tableName);
      return userList.map((e) => UserDataEntity.fromMap(e)).toList();
    } catch (e) {
      throw Exception('Failed to get all user: $e');
    }
  }

  Future<void> postUser(UserDataEntity userData) async {
    try {
      final db = await database;
      await db.insert(_tableName, userData.toMap());
    } catch (e) {
      throw Exception('Failed to Insert User ${userData.name}: $e');
    }
  }

  Future<void> removeUser(int id) async {
    try {
      final db = await database;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to Delete User $id: $e');
    }
  }

  Future<void> updateUser(UserDataEntity userData) async {
    final db = await database;
    await db.update(
      _tableName,
      userData.toMap(),
      where: 'id = ?',
      whereArgs: [userData.id],
    );
  }
}
