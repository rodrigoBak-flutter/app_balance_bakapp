import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:flutter/material.dart';

class CreateCategoryWiget extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategoryWiget({super.key, required this.fModel});

  @override
  State<CreateCategoryWiget> createState() => _CreateCategoryWigetState();
}

class _CreateCategoryWigetState extends State<CreateCategoryWiget> {
  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
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
        ],
      ),
    );
  }
}
