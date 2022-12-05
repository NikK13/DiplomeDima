import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/model/order.dart';
import 'package:diplome_dima/data/utils/constants.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/dialogs/info_order_dialog.dart';
import 'package:diplome_dima/ui/widgets/apppage.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    child: FutureBuilder(
                      future: appBloc.checkCarAlreadyTestDrive(widget.car!.key!, firebaseBloc.fbUser!.uid),
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if(snapshot.hasData){
                          if(snapshot.data!){
                            return const Center(child: Text("Уже оформлен тест-драйв"));
                          }
                          return AppButton(
                            text: "Тест-драйв",
                            onPressed: () async{
                              showCustomDialog(context, OrderInfoDialog(
                                isTestDrive: true,
                                sendData: sendData,
                              ));
                            },
                          );
                        }
                        return const LoadingView();
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:  FutureBuilder(
                      future: appBloc.checkCarAlreadyOrdered(widget.car!.key!, firebaseBloc.fbUser!.uid),
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if(snapshot.hasData){
                          if(snapshot.data!){
                            return const Center(child: Text("Уже оформлен предзаказ"));
                          }
                          return AppButton(
                            text: "Предзаказ",
                            onPressed: () async{
                              showCustomDialog(context, OrderInfoDialog(
                                isTestDrive: false,
                                sendData: sendData,
                              ));
                            },
                          );
                        }
                        return const LoadingView();
                      }
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

  void sendData(String name, String email, String phone, [bool isTestDrive = true]) async{
    !isTestDrive ? await appBloc.requestToBuy(
      firebaseBloc.fbUser!.uid,
      Order(
        carKey: widget.car!.key,
        name: name, phone: phone, email: email,
        date: DateFormat(dateFormat24h).format(DateTime.now())
      )
    ) : await appBloc.requestTestDrive(
      firebaseBloc.fbUser!.uid,
      Order(
        carKey: widget.car!.key,
        name: name, phone: phone, email: email,
        date: DateFormat(dateFormat24h).format(DateTime.now())
      )
    );
    setState(() {
      appBloc.checkCarAlreadyOrdered(widget.car!.key!, firebaseBloc.fbUser!.uid);
    });
  }
}
