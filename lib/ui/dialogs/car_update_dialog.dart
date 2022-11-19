import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/dropdown.dart';
import 'package:diplome_dima/ui/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarUpdateDialog extends StatefulWidget {
  final Car? car;

  const CarUpdateDialog({
    Key? key,
    this.car,
  }) : super(key: key);

  @override
  State<CarUpdateDialog> createState() => _CarUpdateDialogState();
}

class _CarUpdateDialogState extends State<CarUpdateDialog> {
  late ListItem _model;
  late ListItem _carType;

  final _imageController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    if(widget.car != null){
      _model = models.firstWhere((element) => element.title == widget.car!.model);
      _imageController.text = widget.car!.image!;
      _priceController.text = widget.car!.price!.toString();
      _carType = carTypes.firstWhere((element) => element.value == widget.car!.type);
    }
    else{
      _model = models.first;
      _carType = carTypes.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: DropdownPicker(
                    title: "Модель",
                    myValue: _model.value,
                    items: models,
                    darkColor: const Color(0xFF242424),
                    onChange: (newVal){
                      setState(() => _model = models.firstWhere((element) => element.value == newVal));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownPicker(
                    title: "Вид авто",
                    myValue: _carType.value,
                    items: carTypes,
                    darkColor: const Color(0xFF242424),
                    onChange: (newVal){
                      setState(() => _carType = carTypes.firstWhere((element) => element.value == newVal));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InputField(
                    hint: "Ссылка на изображение",
                    controller: _imageController,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputField(
                    hint: "Цена в USD",
                    controller: _priceController,
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            AppButton(
                text: "Сохранить",
                onPressed: () async{
                  final image = _imageController.text.trim();
                  final price = _priceController.text.trim();
                  if(price.isNotEmpty){
                    Navigator.pop(context);
                    if(widget.car != null){
                      Car car = Car(
                        type: _carType.value,
                        model: _model.title,
                        price: double.parse(price),
                        image: image,
                        isEnabled: widget.car!.isEnabled
                      );
                      await appBloc.updateCar(widget.car!.key!, car.toJson());
                    }
                    else{
                      Car car = Car(
                        type: _carType.value,
                        model: _model.title,
                        price: double.parse(price),
                        image: image,
                        isEnabled: true
                      );
                      await appBloc.createNewCar(car);
                    }
                    await appBloc.callCarsStreams();
                  }
                  else{
                    Fluttertoast.showToast(msg: "Поле цены обязательное");
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
