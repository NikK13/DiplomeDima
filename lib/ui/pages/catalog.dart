import 'package:diplome_dima/data/model/car.dart';
import 'package:diplome_dima/data/utils/extensions.dart';
import 'package:diplome_dima/data/utils/lists.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/apppage.dart';
import 'package:diplome_dima/ui/widgets/dropdown.dart';
import 'package:diplome_dima/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late ListItem _selectedSort;


  @override
  void initState() {
    _selectedSort = carsTypes.first;
    appBloc.callCarsStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
      child: Column(
        children: [
          DropdownPicker(
            title: "Автомобили",
            myValue: _selectedSort.value,
            items: carsTypes,
            darkColor: const Color(0xFF242424),
            onChange: (newVal) async{
              if(newVal == "all"){
                await appBloc.callCarsStreams();
              }
              else if(newVal == "new"){
                await appBloc.callCarsStreams(true);
              }
              else if(newVal == "old"){
                await appBloc.callCarsStreams(false);
              }
              setState(() => _selectedSort = carsTypes.firstWhere((element) => element.value == newVal));
            },
          ),
          const SizedBox(height: 12),
          Expanded(
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
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}