import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc{

  final List<Car> carsList = [];

  final _cars = BehaviorSubject<List<Car>?>();

  final storageRef = FirebaseStorage.instance
      .refFromURL("gs://diplomedima.appspot.com");

  Stream<List<Car>?> get carsStream => _cars.stream;

  Function(List<Car>?) get loadAllCars => _cars.sink.add;

  Future<void> callCarsStreams() async{
    if(carsList.isNotEmpty){
      carsList.clear();
    }
    carsList.addAll((await loadAvailableCars())!.toList());
    await loadAllCars(carsList);
  }

  Future<List<Car>?> loadAvailableCars() async{
    final query = await FirebaseDatabase.instance.ref("cars").once();
    if(query.snapshot.exists){
      final List<Car> list = [];
      final data = query.snapshot.children;
      for(var item in data){
        final singleItem = Car.fromJson(item.key!, item.value as Map<String, dynamic>);
        list.add(singleItem);
      }
      return isAsAdministrator ? list :
      list.where((element) => element.isEnabled! == true).toList();
    }
    else{
      return [];
    }
  }

  Future<String> createNewCar(Car car) async{
    final ref = FirebaseDatabase.instance.ref("cars").push();
    await ref.set(car.toJson());
    return ref.key!;
  }

  Future<void> updateCar(String key, Map<String, Object?> item) async{
    final ref = FirebaseDatabase.instance.ref("cars/$key");
    await ref.update(item);
  }

  Future<void> deleteCar(Car car) async{
    final ref = FirebaseDatabase.instance.ref("cars/${car.key}");
    await ref.remove();
    await FirebaseStorage.instance.refFromURL(car.image!).delete();
  }

  Future<String> uploadNewPhoto(String carKey, image) async {
    final ref = FirebaseStorage.instance
      .refFromURL("gs://diplomedima.appspot.com")
      .child('cars/$carKey.jpg');
    final task = await ref.putData(
      image, SettableMetadata(
        contentType: "image/jpeg"
      )
    );
    debugPrint("UPLOADED");
    final link = await task.ref.getDownloadURL();
    debugPrint("LINK: $link");
    return link;
  }

  @override
  void dispose() {

  }
}
