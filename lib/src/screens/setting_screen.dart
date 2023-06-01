import 'package:flutter/material.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: const [
          DarkModeSwichWidget(),
          Divider(
            thickness: 2,
          ),
          TimePickerWitget(),
          Divider(
            thickness: 2,
          ),
          SharedFriendsWidget(),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
