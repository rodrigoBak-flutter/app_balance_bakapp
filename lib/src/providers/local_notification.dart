import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

/*

------- Funcion para inicializar las notificaciones en Android --------------


pd: para que las notificaciones locales funcionen hay que configurar mi Android Manifest

<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
<intent-filter>
<action android:name="android.intent.action.BOOT_COMPLETED"></action>
</intent-filter>
</receiver>
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        

*/

class LocalNotification {
  final FlutterLocalNotificationsPlugin _notifiation =
      FlutterLocalNotificationsPlugin();
  initialize() async {
    //De esta manera en mi notificacion llega una pequeña imagen, en este caso un grafico de PIE
    AndroidInitializationSettings _androidInit =
        const AndroidInitializationSettings('@mipmap/pie');

    InitializationSettings _initSetting =
        InitializationSettings(android: _androidInit);

    await _notifiation.initialize(_initSetting);
  }

  dailyNotification(int hour, int minute) async {
    //Este currentTimeZone me esta devolviendo la hora local, me evita la difencia horaria
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      utcTime.year,
      utcTime.month,
      utcTime.day,
      hour,
      minute,
    );

    /*

      Con este print lo que hago es ver la diferencia horaria que existe con respecto al UTCTIME,
      en este caso que estoy en España, es de 6HS

    print(utcTime.hour);
    print(utcTime.minute);
      
    */

    if (scheduledDate.isBefore(utcTime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    //Con esta linea de codigo, pongo una imagen grande en mi Local Notification
    var bigImage = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('@mipmap/big'),
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/pie'),
        contentTitle: 'Es hora de registrar gasto',
        summaryText: 'No olvides registrar los gastos de tu dia',
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var _androidDetails =
        AndroidNotificationDetails('1', 'name', styleInformation: bigImage);

    var _notificationDetails = NotificationDetails(android: _androidDetails);

    await _notifiation.zonedSchedule(
      1,
      'Llego el momento',
      'No olvides agregar tus gastos',
      scheduledDate,
      _notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  cancelNotification() async {
    await _notifiation.cancelAll();
  }
}
