import 'package:flutter/material.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';

/*

--- Este es un mapa de rutas me permite centralizar todas mis pantallas en un solo archivo 

y tener mas control sobre las mismas, manteniendo mi arquitectura mucho mas limpia ------

*/

final Map<String, Widget Function(BuildContext)> appRoutes = {
  //Se puede enrutar de las dos maneras, poniendo el context o en su lugar un " _ "
  'home': (_) => const HomeScreen(),
  'add_expenses': (_) => const AddExpensesScreen(),
  'categories_details': (_) => const CategoriesDetailScreen(),
  'expenses_details': (_) => const ExpensesDetailsScreen(),
};
