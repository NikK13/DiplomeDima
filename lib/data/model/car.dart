import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/dialogs/car_update_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Car{
  String? key;
  String? type;
  String? desc;
  String? model;
  String? image;
  double? price;
  String? comp;
  bool? isEnabled;

  Car({
    this.key,
    this.type,
    this.desc,
    this.model,
    this.price,
    this.image,
    this.comp,
    this.isEnabled
  });

  factory Car.fromJson(String key, Map<String, dynamic> json){
    return Car(
      key: key,
      type: json['type'],
      image: json['image'],
      model: json['model'],
      price: json['price'],
      desc: json['desc'],
      comp: json['comp'],
      isEnabled: json['is_enabled']
    );
  }

  Map<String, Object?> toJson() => {
    'type': type,
    'model': model,
    'image': image,
    'price': price,
    'comp': comp,
    'desc': desc,
    'is_enabled': isEnabled,
  };
}

class CarItem extends StatefulWidget {
  final Car? car;

  const CarItem({Key? key, this.car}) : super(key: key);

  @override
  State<CarItem> createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  late bool isEnabled;

  @override
  void initState() {
    isEnabled = widget.car!.isEnabled!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: widget.car!.image!.isNotEmpty ?
                    Image.network(widget.car!.image!) :
                    emptyImage,
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoSwitch(
                        value: isEnabled,
                        onChanged: (val) async{
                          setState(() => isEnabled = !isEnabled);
                          appBloc.updateCar(widget.car!.key!, {
                            "is_enabled": isEnabled
                          });
                        }
                      ),
                      PopupMenuButton<int>(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                        itemBuilder: (context) => [
                          // PopupMenuItem 1
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: const [
                                Icon(Icons.edit, color: Colors.black),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("Изменить")
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: const [
                                Icon(Icons.delete_outline, color: Colors.black),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("Удалить")
                              ],
                            ),
                          ),
                        ],
                        elevation: 2,
                        onSelected: (value) async {
                          if (value == 1) {
                            context.router.push(CarsEditPageRoute(
                              car: widget.car
                            ));
                          }
                          if (value == 2) {
                            await appBloc.deleteCar(widget.car!);
                            await appBloc.callCarsStreams();
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "Skoda ${widget.car!.model!}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              comps.firstWhere((element) => element.value == widget.car!.comp!).title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal
              ),
            ),
            Text(
              "${widget.car!.price!} \$",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}

