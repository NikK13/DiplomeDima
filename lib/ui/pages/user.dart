import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/app.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/pages/about.dart';
import 'package:diplome_dima/ui/pages/catalog.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    //appBloc.callStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  InkWell(
                    onTap: () => setState(() {
                      _selectedIndex = 0;
                    }),
                    child: Image.asset(
                      "assets/skoda.jpg",
                      fit: BoxFit.cover,
                      //width: 100, height: 90,
                    ),
                  ),
                  Row(
                    children: [
                      mainButton(0, "Главная"),
                      const SizedBox(width: 20),
                      mainButton(1, "Каталог"),
                      const SizedBox(width: 20),
                      mainButton(2, "О нас"),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(
                          Icons.logout,
                          //size: 32,
                        ),
                        color: appColor,
                        onPressed: () async{
                          await firebaseBloc.signOutUser();
                          loadingFuture = Future.value(true);
                          context.router.replaceAll([const LoginPageRoute()]);
                        },
                        tooltip: "Выйти из профиля",
                      ),
                      const SizedBox(width: 8),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/login_bg.jpg",
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.45),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      Positioned(
                        left: 28,
                        top: 36,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Специальная серия Skoda",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Hockey Edition",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const CatalogPage(),
                  const AboutUsPage()
                ],
              )
            )
          ],
        ),
      )
    );
  }

  Widget mainButton(int index, String text) => InkWell(
    onTap: (){
      setState(() => _selectedIndex = index);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: appColor,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 3),
        Container(
          width: 30, height: 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: _selectedIndex == index ?
            appColor : Colors.white
          ),
        )
      ],
    ),
  );
}