import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/model/order.dart';
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

  Future<void> callCarsStreams([bool? isNew]) async{
    if(carsList.isNotEmpty){
      carsList.clear();
    }
    carsList.addAll((await loadAvailableCars(isNew))!.toList());
    await loadAllCars(carsList);
  }

  Future<List<Order>?> loadAllOrders([bool isTestDrive = true]) async{
    final query = await FirebaseDatabase.instance.ref(
        isTestDrive ? "test_drive" : "orders").once();
    if(query.snapshot.exists){
      final List<Order> allOrders = [];
      final usersInOrders = query.snapshot.children;
      for(var item in usersInOrders){
        final userOrders = item.children;
        for(var item in userOrders){
          final singleItem = Order.fromJson(item.key!, item.value as Map<String, dynamic>);
          allOrders.add(singleItem);
        }
      }
      print(allOrders.toString());
      return allOrders;
    }
    else{
      return [];
    }
  }

  Future<List<Car>?> loadAvailableCars([bool? isNew]) async{
    final query = await FirebaseDatabase.instance.ref("cars").once();
    if(query.snapshot.exists){
      final List<Car> list = [];
      final data = query.snapshot.children;
      for(var item in data){
        final singleItem = Car.fromJson(item.key!, item.value as Map<String, dynamic>);
        list.add(singleItem);
      }
      if(isAsAdministrator){
        if(isNew == null){
          return list;
        }
        else if(isNew){
          return list.where((element) => element.isNew == true).toList();
        }
        else{
          return list.where((element) => element.isNew == false).toList();
        }
      }
      else{
        if(isNew == null){
          return list.where((element) => element.isEnabled == true).toList();
        }
        else if(isNew){
          return list.where((element) => element.isEnabled == true
              && element.isNew == true).toList();
        }
        else{
          return list.where((element) => element.isNew == false
              && element.isEnabled == true).toList();
        }
      }
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

  Future<void> requestTestDrive(String userId, Order order) async{
    final ref = FirebaseDatabase.instance.ref("test_drive/$userId").push();
    await ref.set(order.toJson());
  }

  Future<void> requestToBuy(String userId, Order order) async{
    final ref = FirebaseDatabase.instance.ref("orders/$userId").push();
    await ref.set(order.toJson());
  }

  Future<bool> checkCarAlreadyTestDrive(String carId, String userId) async{
    final ref = await FirebaseDatabase.instance.ref("test_drive/$userId").once();
    if(ref.snapshot.exists){
      bool isOrdered = false;
      final data = ref.snapshot.children;
      for(var item in data){
        final singleItem = Order.fromJson(item.key!, item.value as Map<String, dynamic>);
        if(singleItem.carKey == carId){
          isOrdered = true;
        }
      }
      return isOrdered;
    }
    else{
      return false;
    }
  }

  Future<bool> checkCarAlreadyOrdered(String carId, String userId) async{
    final ref = await FirebaseDatabase.instance.ref("orders/$userId").once();
    if(ref.snapshot.exists){
      bool isOrdered = false;
      final data = ref.snapshot.children;
      for(var item in data){
        final singleItem = Order.fromJson(item.key!, item.value as Map<String, dynamic>);
        if(singleItem.carKey == carId){
          isOrdered = true;
        }
      }
      return isOrdered;
    }
    else{
      return false;
    }
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
    _cars.close();
  }
}
