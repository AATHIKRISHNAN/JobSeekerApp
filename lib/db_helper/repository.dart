import 'package:job_seeker/db_helper/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  late DbConnection _dbConnection;
  Repository(){
    _dbConnection = DbConnection();
  }

  static Database? _database;
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await _dbConnection.setDatabase();
      return _database;
    }
  }


  insertData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async{
    var connection = await database;
    return await connection?.query(table, where: 'unique_Id=?',whereArgs: [itemId]);
  }

  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table,data, where: 'Unique_Id=?',whereArgs: [data['itemId']]);
  }

  deleteDataById(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete('delete from $table where unique_Id= $itemId');
  }
}