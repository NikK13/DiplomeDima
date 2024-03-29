import 'package:diplome_dima/data/model/order.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class OrdersFragment extends StatelessWidget {
  const OrdersFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: appBloc.loadAllOrders(false),
          builder: (context, AsyncSnapshot<List<Order>?> snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.isNotEmpty){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return OrderItem(
                      isTestDrive: false,
                      order: snapshot.data![index],
                    );
                  },
                );
              }
              return const Center(
                child: Text("Здесь пока ничего нет"),
              );
            }
            return const Center(child: LoadingView());
          },
        )
      ),
    );
  }
}