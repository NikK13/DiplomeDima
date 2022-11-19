import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
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
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("USERS PANEL"),
              const SizedBox(height: 8),
              AppButton(
                text: "Выйти из аккаунта",
                onPressed: () async{
                  loadingFuture = Future.value(true);
                  await firebaseBloc.signOutUser();
                  context.router.replaceAll([const LoginPageRoute()]);
                }
              )
            ],
          ),
        )
      ),
    );
  }
}