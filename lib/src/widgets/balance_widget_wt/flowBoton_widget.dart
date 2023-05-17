import 'package:flutter/material.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';

class FlowButtonWidget extends StatefulWidget {
  @override
  State<FlowButtonWidget> createState() => _FlowButtonWidgetState();
}

class _FlowButtonWidgetState extends State<FlowButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  toggleMenu() {
    menuIsOpen.value ? animation.reverse() : animation.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FabVerticalDelegate(animation: animation),
      clipBehavior: Clip.none,
      children: [
        FloatingActionButton(
          heroTag: '1',
          elevation: 0,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
          onPressed: () => toggleMenu(),
        ),
        FloatingActionButton(
          heroTag: '2',
          elevation: 0,
          backgroundColor: Colors.red,
          child: const Icon(Icons.remove),
          onPressed: () => Navigator.push(
            context,
            PageAnimationRoutes(
                widget: const AddExpensesScreen(), ejex: 0.8, ejey: 0.8),
          ),
        ),
        FloatingActionButton(
          heroTag: '3',
          elevation: 0,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            PageAnimationRoutes(
                widget: const AddEntriesScreen(), ejex: 0.8, ejey: 0.8),
          ),
        ),
      ],
    );
  }
}
