import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Provider
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:provider/provider.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
//Models
import 'package:app_balances_bakapp/src/models/models.dart';

class CreateCategoryWidget extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategoryWidget({super.key, required this.fModel});

  @override
  State<CreateCategoryWidget> createState() => _CreateCategoryWidgetState();
}

class _CreateCategoryWidgetState extends State<CreateCategoryWidget> {
  bool hasData = false;
  String stcCategory = '';
  @override
  void initState() {
    if (widget.fModel.id != null) {
      stcCategory = widget.fModel.category; //cacho el valor y no lo redibujo
      hasData = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fList = Provider.of<ExpensesProvider>(context).fList;
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    /*
      Esta funcion transforma todo lo que el usurio escriba en minusculas,
      esto permite que todas las categorias sean homogeneas y no se repitan, ejemplo
      deporte == DePOrte, va a saber que son iguales y no dejara repetir
     */
    Iterable<FeaturesModel> contain;
    contain = fList.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());
    //Condicion para agregar catgoria
    _addCategory() {
      if (contain.isNotEmpty) {
        /*
        Para poner emojis es: Windows + .
         */
        Fluttertoast.showToast(
          msg: 'Ya existe esa categoria 🤷🏼‍♂️',
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          fontSize: 20,
        );
        print('Ya existe esa categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.addNewFeature(widget.fModel);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Categoria guardada con exito 😀');
        print('Categoria guardada con exito ');
      } else {
        Fluttertoast.showToast(msg: 'No olvides nombrar una categoria 😒');
        print('No olvides nombrar una categoria ');
      }
    }

    //Condicion para editar catgoria
    _editCategory() {
      if (widget.fModel.category.toLowerCase() == stcCategory.toLowerCase()) {
        exProvider.updateFeatutes(widget.fModel);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Categoria editada con exito 😀');
        print('Categoria editada con exito');
      } else if (contain.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Ya existe esa categoria 🤷🏼‍♂️');
        print('Ya existe esa categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.updateFeatutes(widget.fModel);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Categoria editada con exito 😀');
        print('Categoria editada con exito');
      } else {
        Fluttertoast.showToast(msg: 'No olvides nombrar una categoria 😒');
        print('No olvides nombrar una categoria');
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: viewInsets / 3),
              child: ListTile(
                trailing: Icon(
                  Icons.text_fields_outlined,
                  color: widget.fModel.color.toColor(),
                  size: 35,
                ),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.fModel.category,
                  decoration: InputDecoration(
                      hintText: 'Nombre una categoria',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (txt) => widget.fModel.category = txt,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () => _selectedColor(),
              trailing: CircleColor(
                color: widget.fModel.color.toColor(),
                circleSize: 35,
              ),
              title: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.fModel.color.toColor(),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('Color'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () => _selectedIcon(),
              trailing: Icon(
                widget.fModel.icon.toIcon(),
                color: widget.fModel.color.toColor(),
                size: 35,
              ),
              title: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.fModel.color.toColor(),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('Icono'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.CustomButton(
                      Colors.transparent,
                      Colors.red,
                      'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => (hasData) ? _editCategory() : _addCategory(),
                    child: Constants.CustomButton(
                      Colors.green,
                      Colors.transparent,
                      'ACEPTAR',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectedColor() {
    showModalBottomSheet(
        isDismissible: false,
        shape: Constants.bottomSheet(),
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialColorPicker(
                physics: const NeverScrollableScrollPhysics(),
                selectedColor: widget.fModel.color.toColor(),
                circleSize: 50,
                onColorChange: (Color color) {
                  var hexColor =
                      '#${color.value.toRadixString(16).substring(2, 8)}';
                  // print(hexColor);
                  setState(() {
                    widget.fModel.color = hexColor;
                  });
                },
                //allowShades: false, si esta en false, no va a
                //la otra pagina de colores
                //allowShades: false,
                // iconSelected: Icons.cabin, para cambiar el incono del selector
                // iconSelected: Icons.cabin,

                /*
                muestra todos los colores en una sola hoja
                // colors: fullMaterialColors,



                  Personalizar los colores que quiero mostrar en mi lista
                  colors: const [
                    Colors.red,
                    Colors.blue,
                    Colors.yellow
                  ]
                 */
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Constants.CustomButton(
                    Colors.green, Colors.transparent, 'Seleccionar'),
              ),
            ],
          );
        });
  }

  _selectedIcon() {
    final iconList = IconList().iconMap;
    showModalBottomSheet(
        isDismissible: false,
        shape: Constants.bottomSheet(),
        context: context,
        builder: (context) {
          return SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: iconList.length,
              itemBuilder: (context, i) {
                var key = iconList.keys.elementAt(i);
                return GestureDetector(
                  child: Icon(
                    key.toIcon(),
                    size: 30,
                    color: widget.fModel.color.toColor(),
                  ),
                  onTap: () => setState(() {
                    widget.fModel.icon = key;
                    Navigator.pop(context);
                  }),
                );
              },
            ),
          );
        });
  }
}
