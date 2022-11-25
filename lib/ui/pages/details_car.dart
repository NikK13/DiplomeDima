import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/ui/widgets/apppage.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatefulWidget {
  final Car? car;

  const CarDetailsPage({Key? key, this.car}) : super(key: key);

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late String _fuelType;
  late String _gearBox;
  late String _engineVal;
  late String _transmission;

  @override
  void initState() {
    _fuelType = fuelTypes.firstWhere((element) => element.value == widget.car!.fuelType!).title;
    _transmission = transmissions.firstWhere((element) => element.value == widget.car!.transmission!).title;
    _engineVal = engineValues.firstWhere((element) => element.value == widget.car!.engineValue!).title;
    _gearBox = gearBoxes.firstWhere((element) => element.value == widget.car!.gearBox!).title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Skoda ${widget.car!.model}",
      child: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: widget.car!.image!.isNotEmpty ?
              Image.network(widget.car!.image!) :
              emptyImage,
            ),
            const SizedBox(height: 24),
            Text(
              "$_transmission привод, $_fuelType\n$_engineVal л.с, $_gearBox коробка передач",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: "Тест-драйв",
                      onPressed: (){

                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: "Оформить",
                      onPressed: (){

                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
