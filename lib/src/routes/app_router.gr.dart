// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CarDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CarDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CarDetailsPage(
          key: args.key,
          carData: args.carData,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
  };
}

/// generated route for
/// [CarDetailsPage]
class CarDetailsRoute extends PageRouteInfo<CarDetailsRouteArgs> {
  CarDetailsRoute({
    Key? key,
    required Car carData,
    List<PageRouteInfo>? children,
  }) : super(
          CarDetailsRoute.name,
          args: CarDetailsRouteArgs(
            key: key,
            carData: carData,
          ),
          initialChildren: children,
        );

  static const String name = 'CarDetailsRoute';

  static const PageInfo<CarDetailsRouteArgs> page =
      PageInfo<CarDetailsRouteArgs>(name);
}

class CarDetailsRouteArgs {
  const CarDetailsRouteArgs({
    this.key,
    required this.carData,
  });

  final Key? key;

  final Car carData;

  @override
  String toString() {
    return 'CarDetailsRouteArgs{key: $key, carData: $carData}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
