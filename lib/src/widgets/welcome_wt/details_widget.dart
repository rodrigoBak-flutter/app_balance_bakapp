import 'package:flutter/material.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';

class DetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final resizeNotifier = ValueNotifier(false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!resizeNotifier.value) resizeNotifier.value = true;
    });
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 10) {
            resizeNotifier.value = false;
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -size.height * .5,
                  left: 0,
                  right: 0,
                  child: child!,
                );
              },
              child: SizedBox(
                height: size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * .1),
                    const Spacer(),
                    Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: _DragDownIndication(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ClipPath(
                            clipper:
                                InvertedTopBorderWidget(circularRadius: 40),
                            child: Container(
                              height: size.height * 0.55,
                              width: double.infinity,
                              color: Theme.of(context).primaryColorDark,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  const SizedBox(height: 60),
                                  const Text(
                                    'La aplicación Cash Flow Plus te brinda el control completo sobre tus gastos e ingresos de manera sencilla y eficiente.\n\nCon esta aplicación, puedes realizar un seguimiento detallado de tus transacciones financieras, registrar tus ingresos y gastos de forma organizada y visualizar fácilmente tu flujo de efectivo.\n\nCash Flow Plus te permite crear presupuestos personalizados para controlar tus gastos y establecer metas de ahorro. Además, puedes recibir notificaciones y recordatorios para ayudarte a mantener tus finanzas en orden.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: size.width * .65,
                                    child: SnakeButtonWidget(
                                      onPressed: () {
                                        resizeNotifier.value = false;
                                        _openHomePage(context);
                                      },
                                      child: Text(
                                        'Comenzar',
                                        style: TextStyle(
                                          color: Theme.of(context).dividerColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 30,
              child: SizedBox(
                width: size.width * .9,
                child: Image.asset('assets/BakApp_logo_letras.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openHomePage(BuildContext context) {
    final newRoute = PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: const HomeScreen(),
        );
      },
    );
    Navigator.pushAndRemoveUntil(context, newRoute, ModalRoute.withName(''));
  }
}

class _DragDownIndication extends StatelessWidget {
  const _DragDownIndication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bienvenido',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).dividerColor,
          ),
        ),
        Text(
          'Desliza hacia abajo para ir hacia atras',
          style: TextStyle(
            height: 2,
            fontSize: 14,
            color: Theme.of(context).dividerColor,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).dividerColor,
          size: 35,
        ),
      ],
    );
  }
}
