// import 'package:doorcareworker/feature/auth/data/model/user_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'user_database.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//       '''
//       CREATE TABLE user(
//         id TEXT PRIMARY KEY,
//         name TEXT,
//         email TEXT,
//         mobile TEXT,
//         district TEXT,
//         service TEXT,
//         experience INTEGER,
//         profileImage TEXT,
//         idCardImage TEXT,
//         isBlocked INTEGER
//       )
//       ''',
//     );
//   }

//   Future<void> insertUser(UserModel user) async {
//     final db = await database;
//     await db.insert(
//       'user',
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<UserModel?> getUser() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('user');
//     if (maps.isNotEmpty) {
//       return UserModel.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<void> deleteUser() async {
//     final db = await database;
//     await db.delete('user');
//   }
// }
