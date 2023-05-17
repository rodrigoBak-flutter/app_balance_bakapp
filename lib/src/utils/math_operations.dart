import 'package:intl/intl.dart';
//Utils
export 'package:app_balances_bakapp/src/utils/math_operations.dart';
//Model
import 'package:app_balances_bakapp/src/models/models.dart';

getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency(locale: 'es').format(amount);
}

/*

-------- Funcion sumatoria  de Gastos e Ingregos y Balance Global -----------

*/

//Suma de Gastos
getSumExp(List<ExpensesModel> eList) {
  double _eList;

  _eList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _eList;
}

//Suma de Ingresos
getSumEnt(List<EntriesModel> etList) {
  double _etList;

  _etList = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return _etList;
}

//Suma global, Balance
getBalance(List<ExpensesModel> eList, List<EntriesModel> etList) {
  double _balance;

  _balance = getSumEnt(etList) - getSumExp(eList);
  return getAmountFormat(_balance);
}
