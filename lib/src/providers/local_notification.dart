import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

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
    AndroidInitializationSettings _androidInit =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings _initSetting =
        InitializationSettings(android: _androidInit);

    await _notifiation.initialize(_initSetting);
  }

  dailyNotification(int hour, int minute) async {
    tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      utcTime.year,
      utcTime.month,
      utcTime.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(utcTime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    var _androidDetails = AndroidNotificationDetails(
      '1',
      'name',
    );

    var _notificationDetails =  NotificationDetails(
      android: _androidDetails
    );

    await _notifiation.zonedSchedule(
      1,
      'Llego el momento',
      'No olvides agregar tus gastos',
      scheduledDate,
      _notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  cancelNotification() async {
    await _notifiation.cancelAll();
  }
}
