import 'package:app_balances_bakapp/src/models/features_model.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];


  //Agregar/Guardas en BBDD
  addNewFeature(
    FeaturesModel newFeatures
  ) async {
    
    final id = await DBFeatures.db.addNewFeature(newFeatures);
    newFeatures.id = id;
    fList.add(newFeatures);
    notifyListeners();
  }

  
  //Leer en BBDD
  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  
  //Editar en BBDD
  updateFeatutes(FeaturesModel features)async{
    await DBFeatures.db.uddateFeatutes(features);
    getAllFeatures();
  }
}
