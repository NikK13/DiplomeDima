import 'package:diplome_dima/main.dart';
import 'package:flutter/material.dart';

class Order{
  String? key;
  String? carKey;
  String? name;
  String? phone;
  String? email;
  String? date;

  Order({
    this.key,
    this.date,
    this.carKey,
    this.email,
    this.name,
    this.phone
  });

  factory Order.fromJson(String key, Map<String, dynamic> json) => Order(
    key: key,
    date: json['date'],
    carKey: json['carKey'],
    phone: json['phone'],
    email: json['email'],
    name: json['name']
  );

  Map<String, Object?> toJson() => {
    'carKey': carKey,
    'date': date,
    'name': name,
    'phone': phone,
    'email': email
  };
}

class OrderItem extends StatelessWidget {
  final Order? order;
  final bool? isTestDrive;

  const OrderItem({Key? key, this.order, this.isTestDrive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4, horizontal: 12
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isTestDrive! ? "Тест-драйв" : "Заказ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          )),
          const SizedBox(height: 4),
          Text("Skoda ${appBloc.carsList.firstWhere((element) => element.key == order!.carKey!).model}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          )),
          const SizedBox(height: 4),
          Text("Пользователь ${order!.name}"),
          const SizedBox(height: 4),
          Text("Телефон: ${order!.phone}"),
          const SizedBox(height: 4),
          Text("Эл.почта: ${order!.email}"),
          const SizedBox(height: 4),
          Text(order!.date!, style: const TextStyle(
            fontSize: 11,
          )),
        ],
      ),
    );
  }
}
