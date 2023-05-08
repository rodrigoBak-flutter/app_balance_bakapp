import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:app_balances_bakapp/src/widgets/add_expenses_wt/category_list.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    bool hasData = false;

    if (widget.cModel.category != 'Selecciona Categoria') {
      hasData = true;
    }
    bool hasDataIcon = false;
    if (widget.cModel.icon != '') {
      hasDataIcon = true;
    }

    return GestureDetector(
      onTap: () => _categorySelected(),
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

  _categorySelected() {
    var catList = CategoryList().catList;
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
        itemCount: catList.length,
        itemBuilder: (_, i) {
          var item = catList[i];
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
}
