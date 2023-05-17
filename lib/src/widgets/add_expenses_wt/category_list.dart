//Models
import 'package:app_balances_bakapp/src/models/models.dart';

class CategoryList {
  var catList = [
    FeaturesModel(
        category: 'Gasolina',
        color: '#087802',
        icon: 'local_gas_station_outlined'),
    FeaturesModel(
        category: 'Supermercado',
        color: '#022a78',
        icon: 'shopping_cart_outlined'),
    FeaturesModel(
        category: 'Restaurante',
        color: '#ff8605',
        icon: 'local_dining_outlined'),
    FeaturesModel(category: 'Hogar', color: '#853afc', icon: 'home'),
  ];
}
