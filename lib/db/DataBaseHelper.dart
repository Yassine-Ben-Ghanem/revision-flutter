import 'dart:async';
import 'dart:io';

import 'package:projet2/Model/Article.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  DataBaseHelper.privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper.privateConstructor();
  DataBaseHelper();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MonstockTest.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      //onUpgrade;
      //onDowngrade:
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Article(id INTEGER PRIMARY KEY, codearticle INTEGER, libelle TEXT, qte Double );");
  }

  Future<int> add(Article article) async {
    Database db = await instance.database;
    return await db.insert('Article', article.toMap());
  }

  Future<List<Article>> getArticles() async {
    Database db = await instance.database;
    var listesarticles_tmp =
        await db.query('Article', where: 'codearticle=102', orderBy: 'libelle');
    print(listesarticles_tmp);
    print("ok");
    List<Article> listarticles = listesarticles_tmp.isNotEmpty
        ? listesarticles_tmp.map((c) => Article.fromMap(c)).toList()
        : [];
    return listarticles;
  }
}
