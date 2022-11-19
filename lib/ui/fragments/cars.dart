import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class CarsFragment extends StatefulWidget {
  const CarsFragment({Key? key}) : super(key: key);

  @override
  State<CarsFragment> createState() => _CarsFragmentState();
}

class _CarsFragmentState extends State<CarsFragment> {
  @override
  void initState() {
    appBloc.callCarsStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        onPressed: (){
          context.router.push(CarsEditPageRoute());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12, top: 16, right: 12
        ),
        child: SafeArea(
          child: StreamBuilder(
            stream: appBloc.carsStream,
            builder: (context, AsyncSnapshot<List<Car>?> snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.isNotEmpty){
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCountOnWidth(context),
                      mainAxisSpacing: 8, crossAxisSpacing: 8,
                      childAspectRatio: 1.17
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return CarItem(car: snapshot.data![index]);
                    },
                  );
                }
                return const Center(child: Text("Здесь пока пусто"));
              }
              return const LoadingView();
            },
          ),
        ),
      ),
    );
  }
}
