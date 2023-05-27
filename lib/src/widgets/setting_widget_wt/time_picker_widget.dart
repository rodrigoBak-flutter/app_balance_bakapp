import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
//Provider - SharedPrefences - LocalNotification
import 'package:app_balances_bakapp/src/providers/shared_preference.dart';
import 'package:app_balances_bakapp/src/providers/local_notification.dart';

class TimePickerWitget extends StatefulWidget {
  const TimePickerWitget({super.key});

  @override
  State<TimePickerWitget> createState() => _TimePickerWitgetState();
}

class _TimePickerWitgetState extends State<TimePickerWitget> {
  final _preference = UserPrefence();
  final _notification = LocalNotification();
  bool _isEnable = false;
  String _title = 'Activar Notificaciones';
  @override
  Widget build(BuildContext context) {
    final DateTime getDate = DateTime.now();
    String currentTime;

    //Condicion por si el valor que envia el usuario es null
    if (_preference.hour != 99) {
      //El getTime me va a dar el dia, mes y año que el usuario eligio
      final DateTime getTime = DateTime(
        getDate.day,
        getDate.month,
        getDate.year,
        _preference.hour,
        _preference.minute,
      );
      currentTime = DateFormat.jm().format(getTime);
      _title = 'Desactivar Notifiaciones';
      _isEnable = true;
    } else {
      currentTime = 'Desactivado';
      _title = 'Activar Notifiaciones';
      _isEnable = false;
    }

    /*
    
    -------- Funcion para por desactivar las notificaciones ------------

    */
    _cancelNotification(bool value) {
      if (value == true) {
        //Le doy por defecto que cuando la active por primera vez le llegue la Notificacion a las 08:30 AM
        _preference.hour = 08;
        _preference.minute = 30;
        _notification.dailyNotification(08, 30);
      } else {
        _preference.deleteTime();
        _notification.cancelNotification();
      }
    }

    return Column(
      children: [
        SwitchListTile(
          title: Text(_title),
          value: _isEnable,
          onChanged: (value) => setState(() {
            _isEnable = value;
            _cancelNotification(value);
          }),
        ),
        ListTile(
          enabled: _isEnable,
          leading: (_isEnable)
              ? const Icon(
                  Icons.notifications_active_outlined,
                  size: 35,
                )
              : const Icon(
                  Icons.notifications_off_outlined,
                  size: 35,
                ),
          title: const Text('Recordatorio diario'),
          subtitle: Text(currentTime),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => _selectedTime(),
        ),
      ],
    );
  }

  _selectedTime() {
    final size = MediaQuery.of(context).size;
    int? _hour;
    int? _minute;
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        context: context,
        builder: (_) {
          return SizedBox(
            height: size.height * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimePickerSpinner(
                  //time, indica a que hora va a iniciar cuando se abra
                  time: DateTime.now(),
                  //is24HourMode, false = formato PM/AM, true = formato 24HS
                  is24HourMode: false,
                  //isForce2Digits, forzar para que te muestre dos digitos
                  isForce2Digits: true,
                  //Espacio entre cada numero
                  spacing: 60,
                  itemWidth: 60,
                  itemHeight: 60,
                  //normalTextStyle, son los textos que estan por encima y por debajo de lo que no esta seleccionado
                  normalTextStyle: const TextStyle(fontSize: 30),
                  //highlightedTextStyle, texto central
                  highlightedTextStyle: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.green),
                  onTimeChange: (time) => setState(() {
                    _hour = time.hour;
                    _minute = time.minute;
                  }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Constants.CustomButton(
                          Colors.transparent,
                          Colors.red,
                          'CANCELAR',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Constants.CustomButton(
                          Colors.green,
                          Colors.transparent,
                          'ACEPTAR',
                        ),
                        onTap: () {
                          setState(() {
                            _notification.dailyNotification(_hour!, _minute!);
                            _preference.hour = _hour!;
                            _preference.minute = _minute!;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
