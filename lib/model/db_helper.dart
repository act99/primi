import 'dart:io';

import 'package:primi/model/classify_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String TableName = 'classifymodel';

class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ClassifyModel.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $TableName(id INTEGER PRIMARY KEY, confidence DOUBLE, image TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  //create
  createData(ClassifyModel classifyModel) async {
    final db = await database;
    var res = await db.rawInsert(
        'INSERT INTO $TableName(confidence, image) VALUES(?, ?)',
        [classifyModel.confidence, classifyModel.image]);
    return res;
  }

  //read
  readData(int id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE id = ?', [id]);
    return res.isNotEmpty
        ? ClassifyModel(
            id: res.first['id'],
            confidence: res.first['confidence'],
            image: res.first['image'])
        : Null;
  }

  //readAll
  Future<List<ClassifyModel>> readAllData() async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM $TableName ORDER BY confidence DESC');
    List<ClassifyModel> list = res.isNotEmpty
        ? res
            .map((e) => ClassifyModel(
                id: e['id'], confidence: e['confidence'], image: e['image']))
            .toList()
        : [];
    return list;
  }

  //delete
  deleteData(int id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
    return res;
  }

  //delete All
  deleteAllData() async {
    final db = await database;
    db.rawDelete('DELETE FROM $TableName');
  }

  updateData(ClassifyModel classifyModel) async {
    final db = await database;
    var res = db.rawUpdate(
        'UPDATE $TableName SET image = ? SET confidence = ? WHERE = ?',
        [classifyModel.image, classifyModel.confidence, classifyModel.id]);
    return res;
  }
}
