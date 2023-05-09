import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BsCategoryWidget extends StatefulWidget {
  final CombinedModel cModel;
  const BsCategoryWidget({
    super.key,
    required this.cModel,
  });

  @override
  State<BsCategoryWidget> createState() => _BsCategoryWidgetState();
}

class _BsCategoryWidgetState extends State<BsCategoryWidget> {
  var catList = CategoryList().catList;
  final FeaturesModel fModel = FeaturesModel();
  @override
  /*
    Este codigo solo se ejecuta la primera vez que inicio mi App
    despues ya queda todo guardado en mi BBDD, lo que me ahorra memoria
   */
  void initState() {
    var exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    if (exProvider.fList.isEmpty) {
      for (FeaturesModel e in catList) {
        exProvider.addNewFeature(
          e.category,
          e.color,
          e.icon,
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featureList = Provider.of<ExpensesProvider>(context).fList;

    bool hasData = false;

    if (widget.cModel.category != 'Selecciona Categoria') {
      hasData = true;
    }
    bool hasDataIcon = false;
    if (widget.cModel.icon != '') {
      hasDataIcon = true;
    }

    return GestureDetector(
      onTap: () => _categorySelected(featureList),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              (hasDataIcon)
                  ? widget.cModel.icon.toIcon()
                  : Icons.category_outlined,
              size: 35,
              color: (hasData) ? widget.cModel.color.toColor() : Colors.white,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.7,
                    color: (hasData)
                        ? widget.cModel.color.toColor()
                        : Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _categorySelected(List<FeaturesModel> fList) {
    _itemSelected(String category, String color) {
      setState(() {
        widget.cModel.category = category;
        widget.cModel.color = color;
        Navigator.pop(context);
      });
    }

    var _widgets = [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fList.length,
        itemBuilder: (_, i) {
          var item = fList[i];
          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              color: item.color.toColor(),
              size: 35,
            ),
            title: Text(item.category),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _itemSelected(
              item.category,
              item.color,
            ),
          );
        },
      ),
      const Divider(
        thickness: 2,
      ),
      ListTile(
        leading: const Icon(
          Icons.create_new_folder,
          size: 35,
        ),
        title: const Text('Crear una nueva categoria'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {
          Navigator.pop(context);
          _createNewCategory();
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.edit_outlined,
          size: 35,
        ),
        title: const Text('Administrar categoria'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ];
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: size.height * 0.45,
        child: ListView(
          children: _widgets,
        ),
      ),
    );
  }

  _createNewCategory() {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => CreateCategoryWiget(fModel: fModel,),
    );
  }
}
