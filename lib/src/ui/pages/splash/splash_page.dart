import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teste_cars/src/constants/images.dart';
import 'package:teste_cars/src/routes/app_router.dart';
import 'package:teste_cars/src/constants/colors.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;
  AnimationController? _textAnimationController;
  Animation<double>? _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeOut),
    );

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController!,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationController!
        .forward()
        .whenComplete(() => _textAnimationController!.forward().then((value) {
              Future.delayed(const Duration(milliseconds: 500), () {
                _navigateToHome();
              });
            }));
  }

  void _navigateToHome() {
    AutoRouter.of(context).push(const HomeRoute());
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _textAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation!,
              child: SlideTransition(
                position: _positionAnimation!,
                child: Hero(
                  tag: 'logoHero',
                  child: Image.asset(Images.logoDefault),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: FadeTransition(
              opacity: _textOpacityAnimation!,
              child: const Center(
                child: Text(
                  'Desenvolvido por:\nRick Herson Batista Ramos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
