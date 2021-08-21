import 'dart:async';
import 'package:utils_libs/utils_libs.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_quiz/api_resfull/api.dart';
import 'package:english_quiz/bloc/blocs.dart';

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);
  AnimatedLogo({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: Image.asset(IMAGES.LOGO_APP)
        ),
      ),
    );
  }
}
class SplashPage extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}
class _LogoAppState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }
  @override
  Widget build(BuildContext context){
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              _timer = new Timer(const Duration(seconds: 1), () => AppNavigator.navigateMain());
              break;
            case AuthenticationStatus.unauthenticated:
              _timer = new Timer(const Duration(seconds: 1), () => AppNavigator.navigateLogout());
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          body: AnimatedLogo(animation: animation),
        )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}

