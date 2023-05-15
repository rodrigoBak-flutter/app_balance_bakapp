import 'package:intl/intl.dart';
export 'package:app_balances_bakapp/src/utils/math_operations.dart';


getAmountFormat(double amount){
  return NumberFormat.simpleCurrency(locale: 'es').format(amount);
}