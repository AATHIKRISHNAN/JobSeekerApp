import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbConnection{
  Future<Database> setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'job_seeker');
    var database = await openDatabase(path, version: 1, onCreate: _createTable);
    return database;
  }

  Future<void> _createTable(Database database,int version) async{
    String sql = "CREATE TABLE favourite_jobs (unique_Id TEXT PRIMARY KEY,company_Name TEXT,";
    sql += "job_Role TEXT,link TEXT,salary TEXT,qualification TEXT,batch TEXT,Experience TEXT, location TEXT,lastDate TEXT)";

    await database.execute(sql);
  }
}