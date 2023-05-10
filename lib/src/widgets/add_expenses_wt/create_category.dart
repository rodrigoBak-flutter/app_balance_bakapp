import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class CreateCategoryWiget extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategoryWiget({super.key, required this.fModel});

  @override
  State<CreateCategoryWiget> createState() => _CreateCategoryWigetState();
}

class _CreateCategoryWigetState extends State<CreateCategoryWiget> {
  @override
  Widget build(BuildContext context) {
    final fList = Provider.of<ExpensesProvider>(context).fList;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    /*
      Esta funcion transforma todo lo que el usurio escriba en minusculas,
      esto permite que todas las categorias sean homogeneas y no se repitan, ejemplo
      deporte == DePOrte, va a saber que son iguales y no dejara repetir
     */
    Iterable<FeaturesModel> contain;
    contain = fList.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());

    _addCategory() {
      if (contain.isNotEmpty) {
        print('Ya existe esa categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        print('Procede a guardar');
      } else {
        print('No olvides nombrar una categoria');
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: viewInsets),
            child: ListTile(
              trailing: const Icon(
                Icons.text_fields_outlined,
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
          SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: ()=>_selectColor(),
            trailing: CircleColor(
              //color: widget.fModel.color.toColor(),
              color: Colors.blue,
              circleSize: 35,
            ),
            title: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).cardColor),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text('Color'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _addCategory(),
            child: Container(height: 200, child: Text('Done')),
          )
        ],
      ),
    );
  }

  _selectColor(){
    showModalBottomSheet(context: context, builder: (_){
      return Column(children: [
        MaterialColorPicker()
      ],);
    });
  }
}
