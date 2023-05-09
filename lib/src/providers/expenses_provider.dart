import 'package:app_balances_bakapp/src/models/features_model.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];

  addNewFeature(
    String categoty,
    String color,
    String icon,
  ) async {
    final newFeatures =
        FeaturesModel(category: categoty, color: color, icon: icon);
    final id = await DBFeatures.db.addNewFeature(newFeatures);
    newFeatures.id = id;
    fList.add(newFeatures);
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }
}
