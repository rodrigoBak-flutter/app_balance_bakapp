import 'package:flutter/material.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final hideNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: hideNotifier,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                    top: 0,
                    bottom: value ? -100 : 0,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.fastOutSlowIn,
                      opacity: value ? 0.0 : 1.0,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.5,
                      child: Image.asset('assets/BakApp_logo.png'),
                    ),
                    
                    Center(
                      child: SizedBox(
                        width: size.width * 0.6,
                        height: size.height * 0.1,
                        child: SnakeButtonWidget(
                          //onPressed: () {},
                          onPressed: () => _openPage(
                            context,
                            DetailWidget(),
                          ),
                          child: const Text(
                            'Bienvenido',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }

  void _openPage(BuildContext context, Widget page) async {
    hideNotifier.value = true;
    await Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: page);
          },
        ));
    hideNotifier.value = false;
  }
}
