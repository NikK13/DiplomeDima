import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  @override
  void initState() {
    //appBloc.callStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width > 145
                ? 145 : MediaQuery.of(context).size.width,
                child: Drawer(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      drawerTile(
                        context,
                        "Машины",
                        CupertinoIcons.car_detailed,
                        (){
                          setState(() => _currentIndex = 0);
                          context.router.navigate(const CarsFragmentRoute());
                        }
                      ),
                      drawerTile(
                        context,
                        "Тест-драйвы",
                        Icons.car_rental,
                        (){
                          setState(() => _currentIndex = 1);
                          context.router.navigate(const TestDrivesFragmentRoute());
                        }
                      ),
                      drawerTile(
                        context,
                        "Предзаказы",
                        Icons.add_chart_rounded,
                        (){
                          setState(() => _currentIndex = 2);
                          context.router.navigate(const OrdersFragmentRoute());
                        }
                      ),
                      Divider(
                        thickness: 0.75,
                        color: Colors.grey.shade300,
                      ),
                      drawerTile(
                        context,
                        "Выйти",
                        Icons.logout,
                        () async{
                          loadingFuture = Future.value(true);
                          await firebaseBloc.signOutUser();
                          context.router.replaceAll([const LoginPageRoute()]);
                        }
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: AutoTabsScaffold(
                  routes: [
                    CarsFragmentRoute(),
                    TestDrivesFragmentRoute(),
                    OrdersFragmentRoute()
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }

  Widget drawerTile(context, title, icon, onTap) => ListTile(
    iconColor: appColor,
    leading: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Icon(icon),
    ),
    contentPadding: EdgeInsets.zero,
    onTap: () => onTap!(),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold
      ),
      maxLines: 1,
    ),
  );
}
