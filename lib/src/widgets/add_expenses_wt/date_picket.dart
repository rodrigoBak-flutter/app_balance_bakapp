import 'package:flutter/material.dart';
//Models
import 'package:app_balances_bakapp/src/models/models.dart';

class DatePicketWidget extends StatefulWidget {
  final CombinedModel cModel;
  const DatePicketWidget({super.key, required this.cModel});

  @override
  State<DatePicketWidget> createState() => _DatePicketWidgetState();
}

class _DatePicketWidgetState extends State<DatePicketWidget> {
  String selectedDay = 'Hoy';

  @override
  void initState() {
    if (widget.cModel.day == 0) {
      widget.cModel.day = DateTime.now().day;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.year = DateTime.now().year;
    } else {
      selectedDay = 'Otro dia';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.now();
    var _widgets = <Widget>[];

    _widgets.insert(0, const Icon(Icons.date_range_outlined, size: 35));
    _widgets.insert(1, const SizedBox(width: 4));

    //Calendario
    _calendar() {
      showDatePicker(
        
        context: context,
        //Idioma que se va a desplegar el calendario
        locale: const Locale('es', 'ES'),
        //Formato en la que aparecera el calendario
        //initialEntryMode: DatePickerEntryMode.input,
        /*
        Ejemplo para que aparezca por años
               showDatePicker(
         context: context,
         initialDate: selectedDate,
         firstDate: DateTime(2000),
         lastDate: DateTime(2025),
         initialDatePickerMode: DatePickerMode.year,
       )    
         */
        //initialDatePickerMode: DatePickerMode.year,
        initialDate: _date.subtract(
          //Cuando abro el calendario habre dos dias antes de la fecha actual
          const Duration(hours: 24 * 2),
        ),
        firstDate: _date.subtract(
          //Cuanto tiempo quiero que se pueda guardar gastos, un mes atras
          const Duration(hours: 24 * 30),
        ),
        lastDate: _date.subtract(
          //Hasta cuando pueden registrar el gasto
          const Duration(hours: 24 * 2),
        ),
        /*
        Con esta tres propiedades cambio los textos de mi caja de calendario
        helpText: 'Seleccionar fecha del gasto', 
        cancelText: 'Volver',
        confirmText: 'Guardar fecha ',
         */
        helpText: 'Seleccionar fecha del gasto',
        cancelText: 'Volver',
        confirmText: 'Guardar fecha ',
      ).then((value) => setState(() {
            if (value != null) {
              widget.cModel.day = value.day;
              widget.cModel.month = value.month;
              widget.cModel.year = value.year;
            } else {
              selectedDay = 'Hoy';
            }
          }));
    }

    Map<String, DateTime> items = {
      'Hoy': _date,
      'Ayer': _date.subtract(const Duration(hours: 24)),
      'Otro dia': _date
    };

    items.forEach(
      (name, date) => _widgets.add(
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              selectedDay = name;
              widget.cModel.day = date.day;
              widget.cModel.month = date.month;
              widget.cModel.year = date.year;
              if (name == 'Otro dia') _calendar();
            }),
            child: DateContainWidget(
              cModel: widget.cModel,
              name: name,
              isSelected: name == selectedDay,
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: _widgets,
      ),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;
  const DateContainWidget({
    super.key,
    required this.cModel,
    required this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(name),
            ),
          ),
        ),
        isSelected
            ?
            //FittedBox = el contenido se adapta a todos lo tamaños de pantalla
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(' ${cModel.day}/${cModel.month}/${cModel.year}'),
              )
            : const Text('')
      ],
    );
  }
}
