import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Model
import 'package:app_balances_bakapp/src/models/features_model.dart';

class DBFeatures {
  static Database? _dataBase;
  static final DBFeatures db = DBFeatures._();
  DBFeatures._();

  Future<Database> get dataBase async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await iniDB();
    return _dataBase!;
  }

  iniDB() async {
    var dataBasePath = await getDatabasesPath();
    //FeatureDB.db es la ruta en donde se va a guardar mi BBDD
    String path = join(dataBasePath, 'FeatureDB.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Features (
            id INTEGER PRIMARY KEY, 
            category TEXT, 
            color TEXT, 
            icon TEXT
            )''');
    });
  }

  //Agreagar/Guardar a mi BBDD
  addNewFeature(FeaturesModel features) async {
    final db = await dataBase;
    final response = db.insert('Features', features.toJson());
    return response;
  }

  //Leer el contenido de mi BBDD
  Future<List<FeaturesModel>> getAllFeatures() async {
    final db = await dataBase;
    final response = await db.query('Features');
    List<FeaturesModel> fList = response.isNotEmpty
        ? response.map((e) => FeaturesModel.fromJson(e)).toList()
        : [];
    return fList;
  }

  //Editar el contenido de mi BBDD
  uddateFeatutes(FeaturesModel features) async {
    final db = await dataBase;
    final response = db.update('Features', features.toJson(),
        where: 'id = ?', whereArgs: [features.id]);
    return response;
  }
}
