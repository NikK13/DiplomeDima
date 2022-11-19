// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/apppage.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/dropdown.dart';
import 'package:diplome_dima/ui/widgets/input.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CarsEditPage extends StatefulWidget {
  final Car? car;

  const CarsEditPage({Key? key, this.car}) : super(key: key);

  @override
  State<CarsEditPage> createState() => _CarsEditPageState();
}

class _CarsEditPageState extends State<CarsEditPage> {
  Car? get car => widget.car;

  bool get isForEdit => car != null;

  Uint8List? _imageBytes;

  bool _isLoading = false;

  final _picker = ImagePicker();

  late ListItem _model;
  late ListItem _carType;
  late ListItem _carComp;

  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState(){
    if(isForEdit){
      _model = models.firstWhere((element) => element.title == widget.car!.model);
      _priceController.text = widget.car!.price!.toString();
      _descController.text = widget.car!.desc!;
      _carType = carTypes.firstWhere((element) => element.value == widget.car!.type);
      _carComp = comps.firstWhere((element) => element.value == widget.car!.comp);
    }
    else{
      _model = models.first;
      _carType = carTypes.first;
      _carComp = comps.first;
    }
    super.initState();
  }

  _pickImage() async {
    var uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) async{
      final file = uploadInput.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      setState(() {
        _imageBytes = reader.result as Uint8List;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: car != null ?
      "Редактирование" :
      "Добавление авто",
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 380 ?
                  380 : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: isForEdit ?
                          (_imageBytes != null ?
                          Image.memory(_imageBytes!) :
                          car!.image!.isNotEmpty ?
                          Image.network(car!.image!) : emptyImage) :
                          (_imageBytes != null ?
                          Image.memory(_imageBytes!) :
                          emptyImage)
                        ),
                      ),
                      const SizedBox(height: 12),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownPicker(
                              title: "Комплектация",
                              myValue: _carComp.value,
                              items: comps,
                              darkColor: const Color(0xFF242424),
                              onChange: (newVal){
                                setState(() => _carComp = comps.firstWhere((element) => element.value == newVal));
                              },
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
                      const SizedBox(height: 16),
                      InputField(
                        hint: "Описание",
                        controller: _descController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 380 ?
              380 : MediaQuery.of(context).size.width,
              child: AppButton(
                text: "Сохранить",
                onPressed: () async{
                  final desc = _descController.text.trim();
                  final price = _priceController.text.trim();
                  if(price.isNotEmpty){
                    if(isForEdit){
                      String? image;
                      if(_imageBytes != null){
                        image = await appBloc.uploadNewPhoto(car!.key!, _imageBytes);
                      }
                      else{
                        image = car!.image;
                      }
                      Car exCar = Car(
                        type: _carType.value,
                        model: _model.title,
                        price: double.parse(price),
                        image: image,
                        desc: desc,
                        comp: _carComp.value,
                        isEnabled: widget.car!.isEnabled
                      );
                      await appBloc.updateCar(car!.key!, exCar.toJson());
                    }
                    else{
                      Car exCar = Car(
                        type: _carType.value,
                        model: _model.title,
                        price: double.parse(price),
                        image: "",
                        desc: desc,
                        comp: _carComp.value,
                        isEnabled: true
                      );
                      final key = await appBloc.createNewCar(exCar);
                      if(_imageBytes != null){
                        String image = await appBloc.uploadNewPhoto(key, _imageBytes);
                        await appBloc.updateCar(key, {
                          "image": image
                        });
                      }
                    }
                    await appBloc.callCarsStreams();
                    if(!mounted) return;
                    context.router.pop();
                  }
                  else{
                    Fluttertoast.showToast(msg: "Поле цены обязательное");
                  }
                }
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
