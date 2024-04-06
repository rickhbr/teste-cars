import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teste_cars/src/constants/colors.dart';
import 'package:teste_cars/src/constants/icons.dart';
import 'package:teste_cars/src/constants/images.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/ui/widgets/box/box_color.dart';
import 'package:teste_cars/src/ui/widgets/text/custom_text.dart';

class CardCard extends StatelessWidget with ScreenUtilityMixin {
  final Car carData;
  final void Function()? onTap;
  const CardCard({super.key, required this.carData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: setHeight(12.0)),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: setHeight(180),
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: setHeight(16.0), horizontal: setWidth(14.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopCards(),
                    _buildBottomCards(),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Image.asset(
                Images.car,
                width: setWidth(220),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '#${carData.id}',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: setFontSize(18.0),
              ),
              CustomText(
                text: carData.nomeModelo,
                color: Colors.black,
                fontSize: setFontSize(18.0),
              ),
              CustomBoxColor(
                color: carData.cor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: setWidth(80),
          height: setHeight(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade300,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.icYear,
                  width: setWidth(15),
                  height: setHeight(15),
                ),
                SizedBox(
                  width: setWidth(4),
                ),
                CustomText(
                  text: carData.ano.toString(),
                  fontSize: setFontSize(12),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
        Container(
          width: setWidth(80),
          height: setHeight(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade300,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.icFuel,
                  width: setWidth(15),
                  height: setHeight(15),
                ),
                SizedBox(
                  width: setWidth(4),
                ),
                CustomText(
                  text: carData.combustivel,
                  fontSize: setFontSize(12),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
        Container(
          width: setWidth(130),
          height: setHeight(35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.orange.withOpacity(0.2),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.icMoney,
                  width: setWidth(15),
                  height: setHeight(15),
                ),
                SizedBox(
                  width: setWidth(4),
                ),
                CustomText(
                  text: 'R\$ ${carData.valor}00,00',
                  fontSize: setFontSize(12),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
