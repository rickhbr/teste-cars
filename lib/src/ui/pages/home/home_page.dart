import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:teste_cars/src/bloc/car_bloc.dart';
import 'package:teste_cars/src/bloc/car_event.dart';
import 'package:teste_cars/src/bloc/car_state.dart';
import 'package:teste_cars/src/constants/animations.dart';
import 'package:teste_cars/src/constants/colors.dart';
import 'package:teste_cars/src/constants/images.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/routes/app_router.dart';
import 'package:teste_cars/src/ui/widgets/card_car.dart';
import 'package:teste_cars/src/ui/widgets/text/custom_text.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ScreenUtilityMixin {
  @override
  void initState() {
    super.initState();

    if (context.read<CarBloc>().state is! CarLoadSuccess) {
      context.read<CarBloc>().add(FetchCars());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      appBar: _appBar(),
      body: PopScope(
        canPop: false,
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoadInProgress) {
              return Center(child: Lottie.asset(AppAnimations.loading));
            } else if (state is CarLoadSuccess) {
              return ListView.builder(
                itemCount: state.cars.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: CardCard(
                    carData: state.cars[index],
                    onTap: () {
                      context.router
                          .push(CarDetailsRoute(carData: state.cars[index]));
                    },
                  ));
                },
              );
            } else if (state is CarLoadFailure) {
              return const Center(child: Text('Erro ao carregar carros.'));
            }
            return Center(child: Lottie.asset(AppAnimations.loading));
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: CustomColors.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logoHero',
            child: Image.asset(
              Images.logoDefault,
              width: setWidth(40),
            ),
          ),
          SizedBox(
            width: setWidth(12.0),
          ),
          CustomText(
            text: 'WS Work Carros',
            fontSize: setFontSize(22.0),
          ),
        ],
      ),
    );
  }
}
