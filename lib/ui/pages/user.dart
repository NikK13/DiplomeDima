import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/app.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
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
                  Image.asset(
                    "assets/skoda.jpg",
                    fit: BoxFit.cover,
                    //width: 100, height: 90,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          context.router.push(const CatalogPageRoute());
                        },
                        child: const Text(
                          "Каталог",
                          style: TextStyle(
                            color: appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: (){},
                        child: const Text(
                          "О нас",
                          style: TextStyle(
                            color: appColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/bg.jpg",
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.45),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Skoda\nэто\nвзгляд в будущее",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}