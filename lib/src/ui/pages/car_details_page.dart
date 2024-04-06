import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_cars/src/bloc/car_bloc.dart';
import 'package:teste_cars/src/constants/colors.dart';
import 'package:teste_cars/src/constants/icons.dart';
import 'package:teste_cars/src/constants/images.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/ui/widgets/box/box_color.dart';
import 'package:teste_cars/src/ui/widgets/box/box_info_car.dart';
import 'package:teste_cars/src/ui/widgets/buttons/custom_button.dart';
import 'package:teste_cars/src/ui/widgets/lead_form.dart';
import 'package:teste_cars/src/ui/widgets/text/custom_text.dart';

@RoutePage()
class CarDetailsPage extends StatefulWidget {
  final Car carData;
  const CarDetailsPage({super.key, required this.carData});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage>
    with ScreenUtilityMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.primaryColor,
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: setHeight(16.0)),
                child: Image.asset(Images.car),
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: setHeight(350),
                      decoration: BoxDecoration(
                          color: CustomColors.secundaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle(),
                          SizedBox(height: setHeight(10.0)),
                          CustomText(
                            text:
                                'Carro ${widget.carData.nomeModelo}, modelo confortável para familia, muito robusto e seguro.',
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: setFontSize(12.0),
                          ),
                          SizedBox(height: setHeight(24.0)),
                          CustomText(
                            text: 'Detalhes',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: setFontSize(15.0),
                          ),
                          SizedBox(height: setHeight(10.0)),
                          _buildOverview(),
                          SizedBox(height: setHeight(10.0)),
                        ],
                      ),
                    ),
                  ),
                  _buildBoxPrice(),
                ],
              )
            ],
          ),
        ));
  }

  Widget _buildBoxPrice() {
    return Positioned(
      bottom: 0,
      left: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: setHeight(105),
        decoration: BoxDecoration(
          color: CustomColors.terciaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: setWidth(16.0), vertical: setFontSize(12.0)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'Preço',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: setFontSize(15.0)),
                  CustomText(
                      text: 'R\$ ${widget.carData.valor.toString()}00,00',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: setFontSize(14.0)),
                ],
              ),
              SizedBox(height: setHeight(6.0)),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: widget.carData.nomeModelo,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: setFontSize(22.0),
        ),
        CustomBoxColor(
          color: widget.carData.cor,
        ),
      ],
    );
  }

  Widget _buildOverview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxInfoCar(
          icon: AppIcons.icDoors,
          title: 'Portas',
          value: widget.carData.numPortas.toString(),
        ),
        BoxInfoCar(
          icon: AppIcons.icFuel,
          title: 'Combustível',
          value: widget.carData.combustivel,
        ),
        BoxInfoCar(
          icon: AppIcons.icYear,
          title: 'Ano',
          value: widget.carData.ano.toString(),
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: CustomColors.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.logoDefault,
            width: setWidth(40),
          ),
          SizedBox(
            width: setWidth(6.0),
          ),
          CustomText(
            text: 'Detalhes do carro',
            fontSize: setFontSize(22.0),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return CustomButton(
      onTap: () {
        _showLeadFormBottomSheet(context);
      },
      text: 'EU QUERO',
    );
  }

  void _showLeadFormBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return BlocProvider.value(
            value: BlocProvider.of<CarBloc>(context),
            child: Container(
              color: CustomColors.blackColor,
              width: MediaQuery.of(context).size.width,
              height: setHeight(540),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: setHeight(100),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: CustomColors.terciaryColor),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: setHeight(16.0)),
                              child: Image.asset(
                                Images.logoDefault,
                                width: setWidth(50),
                              ),
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: setHeight(40),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: CustomColors.secundaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CustomText(
                                text:
                                    'Interessado em ${widget.carData.nomeModelo}',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text:
                          'Aabaixo preencha com seus dados para que possamos entrar em contato.',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: setFontSize(13.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LeadForm(
                    carId: widget.carData.id,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
