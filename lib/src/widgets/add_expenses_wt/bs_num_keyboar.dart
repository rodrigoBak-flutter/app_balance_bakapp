import 'package:flutter/material.dart';

//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';

//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';

class BSNumKeyboardWidget extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboardWidget({super.key, required this.cModel});

  @override
  State<BSNumKeyboardWidget> createState() => _BSNumKeyboardWidgetState();
}

class _BSNumKeyboardWidgetState extends State<BSNumKeyboardWidget> {
  String import = '0.00';

  @override
  void initState() {
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Código para dar formato de moneda

    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () => _numPad(),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad ingresada'),
            Text(
              '${import.replaceAllMapped(reg, mathFunc)}  €',
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  _numPad() {
    if (import == '0.00') import = '';
    _expenseChange(String amount) {
      if (amount == '') amount = '0.00';
      widget.cModel.amount = double.parse(amount);
    }

    _num(String _text, double _height) {
      return GestureDetector(
        /*
        behavior: HitTestBehavior.opaque,
        Propiedad que detecta todo el Container que usas, al momento de hacer OnTap
         */
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() {
          import += _text;
          widget.cModel.amount = double.parse(import);
        }),
        child: SizedBox(
          height: _height,
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(fontSize: 35),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      //isDismissible hace que el usuario no pueda salir si
      //toca por fuera del ModalSheet, solo si toca flecha hacia atras
      isDismissible: false,
      //Si el enableDrag esta en true, el usuario puede arrastras el showModalBottomSheet,
      // hacia abajo y cerrarlo.
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (_) {
        final size = MediaQuery.of(context).size;
        return WillPopScope(
          /*
           WillPopScope(
          onWillPop: ()async => false,
          Con esta funcion cancelo el boton de telefo "ATRAS", lo desactivo
           
           */
          onWillPop: () async => false,
          child: SizedBox(
            height: size.height * 0.45,
            child: LayoutBuilder(builder: (context, constraints) {
              var _height = constraints.biggest.height / 5;
              return Column(
                children: [
                  Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      TableRow(
                        children: [
                          _num('1', _height),
                          _num('2', _height),
                          _num('3', _height),
                        ],
                      ),
                      TableRow(
                        children: [
                          _num('4', _height),
                          _num('5', _height),
                          _num('6', _height),
                        ],
                      ),
                      TableRow(
                        children: [
                          _num('7', _height),
                          _num('8', _height),
                          _num('9', _height),
                        ],
                      ),
                      TableRow(
                        children: [
                          _num('.', _height),
                          _num('0', _height),
                          GestureDetector(
                            /*
          Propiedad que detecta todo el Container que usas, al momento de hacer OnTap
          behavior: HitTestBehavior.opaque,
           */
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox(
                              height: _height,
                              child: const Icon(
                                Icons.backspace_outlined,
                                size: 35,
                              ),
                            ),
                            onTap: () => setState(() {
                              if (import.length > 0.00) {
                                import = import.substring(0, import.length - 1);
                                _expenseChange(import);
                              }
                            }),
                            onLongPress: () => setState(() {
                              import = '';
                              _expenseChange(import);
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            import = '0.00';
                            _expenseChange(import);
                            Navigator.pop(context);
                          }),
                          behavior: HitTestBehavior.opaque,
                          child: Constants.CustomButton(
                            Colors.transparent,
                            Colors.red,
                            'Camcelar',
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            if (import.length == 0.00) import = '0.00';
                            _expenseChange(import);
                            Navigator.pop(context);
                          }),
                          behavior: HitTestBehavior.opaque,
                          child: Constants.CustomButton(
                            Colors.green,
                            Colors.transparent,
                            'Aceptar',
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
