import 'package:app_balances_bakapp/src/models/combined_model.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDetailScreen extends StatefulWidget {
  const CategoriesDetailScreen({super.key});

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var cList = Provider.of<ExpensesProvider>(context).allItemsList;
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

   cList = cList.where((e) => e.category == cModel!.category).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(cModel!.category),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                var item = cList[i];
                return ListTile(
                  title: Text(item.category),
                );
              },
              childCount: cList.length
            ),
          )
        ],
      ),
    );
  }
}
