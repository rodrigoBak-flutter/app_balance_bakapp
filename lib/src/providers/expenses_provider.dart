import 'dart:convert';

import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:flutter/material.dart';

/*
  Aca se encuentras las Funciones para llamar a los Gastos y a los ingresos, mediente mi provider

  A los ingresos le falta actualizar y eliminar( Hacer funciones)

*/

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<EntriesModel> etList = [];
  List<CombinedModel> cList = [];

  /*
    
  ------ FUNCIONES DE AGREGAR ------------

  */

  //Agregar/Guardar Gastos en BBDD
  addNewExpenes(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      link: cModel.link,
      day: cModel.day,
      month: cModel.month,
      year: cModel.year,
      comment: cModel.comment,
      expense: cModel.amount,
    );
    final id = await DBExpenses.db.addExpenses(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }

  //Agregar Ingresos en la BBDD
  addNewEntries(CombinedModel cModel) async {
    var entries = EntriesModel(
      day: cModel.day,
      month: cModel.month,
      year: cModel.year,
      comment: cModel.comment,
      entries: cModel.amount,
    );
    final id = await DBExpenses.db.addEntries(entries);
    entries.id = id;
    etList.add(entries);
    notifyListeners();
  }

  //Agregar/Guardar Categorias en BBDD
  addNewFeature(FeaturesModel newFeatures) async {
    final id = await DBFeatures.db.addNewFeature(newFeatures);
    newFeatures.id = id;
    fList.add(newFeatures);
    notifyListeners();
  }

  /*
    
  ------ FUNCIONES DE LEER ------------

  */

  //Leer Gastos en BBDD
  getExpensesByDate(int month, int year) async {
    final response = await DBExpenses.db.getExpenseByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  //Leer Ingresos en BBDD
  getEntriesByDate(int month, int year) async {
    final response = await DBExpenses.db.getEntriesByDate(month, year);
    etList = [...response];
    notifyListeners();
  }

  //Leer Categorias en BBDD
  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  /*
    
  ------ FUNCIONES DE EDITAR ------------

  */

  //Editar Gastos en BBDD

  updateExpenses(CombinedModel cModel) async {
    var expenses = ExpensesModel(
      id: cModel.id,
      link: cModel.link,
      day: cModel.day,
      month: cModel.month,
      year: cModel.year,
      comment: cModel.comment,
      expense: cModel.amount,
    );
    await DBExpenses.db.updateExpenses(expenses);
    notifyListeners();
  }

  //Editar Categorias en BBDD
  updateFeatutes(FeaturesModel features) async {
    await DBFeatures.db.uddateFeatutes(features);
    getAllFeatures();
  }

  /*
    
  ------ FUNCIONES DE ELIMIINAR ------------

  */

  deleteExpenses(int id) async {
    await DBExpenses.db.deleteExpenses(id);
  }

  /*
    
  ------ GETERS para combinar Listas ------------

  */

  List<CombinedModel> get allItemsList {
    List<CombinedModel> _cModel = [];
    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            id: x.id,
            link: x.link,
            amount: x.expense,
            comment: x.comment,
            day: x.day,
            month: x.month,
            year: x.year,
          ));
        }
      }
    }
    return cList = [..._cModel];
  }

  List<CombinedModel> get groupItemsList {
    List<CombinedModel> _cModel = [];
    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          double _amount = eList
              .where((e) => e.link == y.id)
              .fold(0.0, (a, b) => a + b.expense);
          _cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            amount: _amount,
          ));
        }
      }
    }

    /*
     -------Funcion para agrupar los elementos identicos, transformando todo en String -------------------
           Ejemplo: categoria con categoria, color con color, icono con icono,etc
     */
    var encode = _cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    _cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [..._cModel];
  }
}
