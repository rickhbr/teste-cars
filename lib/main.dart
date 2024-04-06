import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loggy/loggy.dart';
import 'package:teste_cars/src/bloc/car_bloc.dart';
import 'package:teste_cars/src/routes/app_router.dart';
import 'package:teste_cars/src/utils/background_service.dart';
import 'package:teste_cars/src/utils/inject/injector.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "sendLeadsTask",
    "sendLeadsToServer",
    frequency: const Duration(seconds: 15),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider<CarBloc>(
        create: (context) =>
            CarBloc(carRepository: Injector.provideCarRepository()),
        child: MaterialApp.router(
          title: 'Teste Carros',
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
