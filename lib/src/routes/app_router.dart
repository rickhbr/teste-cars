// app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/ui/pages/car_details_page.dart';
import 'package:teste_cars/src/ui/pages/home/home_page.dart';
import 'package:teste_cars/src/ui/pages/splash/splash_page.dart';
// Importe suas outras páginas aqui

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CarDetailsRoute.page),
      ];
}
