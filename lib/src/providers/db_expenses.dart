import 'package:app_balances_bakapp/src/models/expenses_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:app_balances_bakapp/src/models/models.dart';

/*
  Aca se encuentras las Base de Datos para llamar a los Gastos y a los ingresos, y sus respectivo CRUD

*/

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
    //ExpensesDB.db es la ruta en donde se va a guardar mi BBDD
    String path = join(dataBasePath, 'ExpensesDB.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //TABLA de Gastos, BBDD
      await db.execute('''CREATE TABLE Expenses (
            id INTEGER PRIMARY KEY, 
            link INTEGER, 
            day INTEGER,
            month INTEGER,
            year INTEGER,       
            comment TEXT, 
            expense DOUBLE        
            )''');
      //TABLA de Entradas, BBDD
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

  /*
  
    --------- Funciones de Gastos ------------------

  */

  //Funcion que agrega Gastos
  addExpenses(ExpensesModel exp) async {
    final db = await dataBase;
    final response = await db.insert('Expenses', exp.toJson());
    return response;
  }

  //Funcion que lee Gastos
  Future<List<ExpensesModel>> getExpenseByDate(int month, int year) async {
    final db = await dataBase;
    final response = await db.query('Expenses',
        where: "month = ? and year = ?", whereArgs: [month, year]);
    List<ExpensesModel> eList = response.isNotEmpty
        ? response.map((e) => ExpensesModel.fromJson(e)).toList()
        : [];
    return eList;
  }

  //Funcion que actualizar Gastos
  Future<int> updateExpenses(ExpensesModel exp) async {
    final db = await dataBase;
    final response = db
        .update('Expenses', exp.toJson(), where: 'id = ?', whereArgs: [exp.id]);
    return response;
  }

  //Funcion que eliminar Gastos
  Future<int> deleteExpenses(int id) async {
    final db = await dataBase;
    final response = db.delete('Expenses', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  /*
  
    --------- Funciones de Ingresos ------------------

  */

  //Funcion que agregar Ingresos
  addEntries(EntriesModel ent) async {
    final db = await dataBase;
    final response = await db.insert('Entries', ent.toJson());
    return response;
  }

  //Funcion que lee Ingresos
  Future<List<EntriesModel>> getEntriesByDate(int month, int year) async {
    final db = await dataBase;
    final response = await db.query('Entries',
        where: "month = ? and year = ?", whereArgs: [month, year]);
    List<EntriesModel> eList = response.isNotEmpty
        ? response.map((e) => EntriesModel.fromJson(e)).toList()
        : [];
    return eList;
  }

  //Funcion que actualizar Ingresos
  Future<int> updateEntries(EntriesModel ent) async {
    final db = await dataBase;
    final response = db
        .update('Expenses', ent.toJson(), where: 'id = ?', whereArgs: [ent.id]);
    return response;
  }

  //Funcion que eliminar Ingresos
  Future<int> deleteEntries(int id) async {
    final db = await dataBase;
    final response = db.delete('Entries', where: 'id = ?', whereArgs: [id]);
    return response;
  }
}
