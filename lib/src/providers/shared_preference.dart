import 'package:shared_preferences/shared_preferences.dart';

class UserPrefence {
  /*
  
  --------- Preferencias del usuario para manejar el tema de mi Aplicacion---------------
  
  */
//  static const darkMode = 'DarkMode';
  static final UserPrefence _instance = UserPrefence._();

  factory UserPrefence() {
    return _instance;
  }
  UserPrefence._();
  SharedPreferences? _preferences;

  initPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get darkMode {
    return _preferences!.getBool('DarkMode') ?? true;
  }

  set darkMode(bool value) {
    _preferences!.setBool('DarkMode', value);
  }

  /*
  
  --------- Preferencias del usuario para guardar el recordatorio de la notificacion local de mi usuariio en la  de mi Aplicacion---------------
  
  */
  static const notif_hour = 'notif_hour';
  static const notif_minute = 'notif_minute';

  int get hour {
    return _preferences!.getInt(notif_hour) ?? 99; //evitar poner rango entre 00 y 24
  }

  set hour(int value) {
    _preferences!.setInt(notif_hour, value);
  }

  int get minute {
    return _preferences!.getInt(notif_minute) ?? 99; //evitar poner rango entre 00 y 60
  }

  set minute(int value) {
    _preferences!.setInt(notif_minute, value);
  }

  //Funcion para que el usuario pueda BORRAR la hora guardada de su notifiacion diaria local

  deleteTime(){
    _preferences!.remove(notif_hour);
    _preferences!.remove(notif_minute);
  }
}
