
import 'package:flutter_sqflite/models/urun.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

int? id;
String? urunAdi;
String? urunMarkasi;
int? urunFiyati;
int? urunStok;
String? olusturulmaTarihi;

class DatabaseHelper {
  static const _databaseName = "shop.db";
  static const _databaseVersion = 1;
  static const table = 'urun_table';
  static const columnId = 'id';
  static const columnurunAdi = 'urunAdi';
  static const columnurunMarkasi = 'urunMarkasi';
  static const columnurunFiyati = 'urunFiyati';
  static const columnurunStok = 'urunStok';
  static const columnolusturulmaTarihi = 'olusturulmaTarihi';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    var db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''CREATE TABLE $table (
      '$columnId' INTEGER PRIMARY KEY AUTOINCREMENT , 
      '$columnurunAdi' TEXT NOT NULL , 
      '$columnurunMarkasi' TEXT NOT NULL,
      '$columnurunFiyati' INTEGER NOT NULL , 
      '$columnurunStok' INTEGER NOT NULL,
      '$columnolusturulmaTarihi' TEXT 
    )  ''');
  }

  Future<int> insert(Urun urun) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'urunAdi': urun.urunAdi,
      'urunMarkasi': urun.urunMarkasi,
      'urunFiyati': urun.urunFiyati,
      'urunStok': urun.urunStok,
      'olusturulmaTarihi': urun.olusturulmaTarihi,
    });
  }

  Future<int> update(Urun urun) async {
    Database db = await instance.database;
    int id = urun.toMap()['id'];
    return await db
        .update(table, urun.toMap(), where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
