import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:app_balances_bakapp/src/models/models.dart';

class DBExpenses {
  static Database? _dataBase;
  static final DBExpenses db = DBExpenses._();
  DBExpenses._();

  Future<Database> get dataBase async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await iniDB();
    return _dataBase!;
  }

  iniDB() async {
    var dataBasePath = await getDatabasesPath();
    //FeatureDB.db es la ruta en donde se va a guardar mi BBDD
    String path = join(dataBasePath, 'ExpensesDB.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //TABLA de Gastos
      await db.execute('''CREATE TABLE Expenses (
            id INTEGER PRIMARY KEY, 
            link INTEGER, 
            day INTEGER,
            month INTEGER,
            year INTEGER,       
            comment TEXT, 
            expense DOUBLE        
            )''');
      //TABLA de Entradas
      await db.execute('''CREATE TABLE Entries (
            id INTEGER PRIMARY KEY, 
            day INTEGER,
            month INTEGER,
            year INTEGER,  
            comment TEXT, 
            entries DOUBLE        
            )''');
    });
  }

  addExpenses(ExpensesModel exp) async {
    final db = await dataBase;
    final response = await db.insert('Expenses', exp.toJson());
    return response;
  }

  Future<List<ExpensesModel>> getExpenseByDate(int month, int year) async {
    final db = await dataBase;
    final response = await db.query('Expenses',
        where: "month = ? and year = ?", whereArgs: [month, year]);
    List<ExpensesModel> eList = response.isNotEmpty
        ? response.map((e) => ExpensesModel.fromJson(e)).toList()
        : [];
    return eList;
  }

  Future<int> updateExpenses(ExpensesModel exp) async {
    final db = await dataBase;
    final response = await db
        .update('Expenses', exp.toJson(), where: 'id = ?', whereArgs: []);
    return response;
  }

  Future<int> deleteExpenses(int id) async {
    final db = await dataBase;
    final response = db.delete('Expenses', where: 'id = ?', whereArgs: [id]);
    return response;
  }
}
