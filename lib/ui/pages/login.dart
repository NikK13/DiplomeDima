import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diplome_dima/data/utils/app.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/input.dart';
import 'package:diplome_dima/ui/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isForSignUp = false;
  bool _isInProgress = false;

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      firebaseBloc.fbAuth.authStateChanges().listen((User? user) async{
        loadingFuture = Future.value(true);
        if(user != null && isToRedirectHome){
          context.router.replaceAll([const HomePageRoute()]);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: FutureBuilder(
          future: loadingFuture,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done ? Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/main_bg.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 32,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width > 380 ?
                    380 : MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),
                            Image.asset(
                              "assets/skoda.jpg",
                              fit: BoxFit.cover,
                              height: 70,
                              //width: 50, height: 90,
                            ),
                            const SizedBox(height: 12),
                            if(_isForSignUp)
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: InputField(
                                      controller: _nameController,
                                      inputType: TextInputType.text,
                                      hint: "Имя пользователя",
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: InputField(
                                controller: _emailController,
                                inputType: TextInputType.emailAddress,
                                hint: "Электр.почта",
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: InputField(
                                controller: _passwordController,
                                isPassword: true,
                                hint: "Пароль",
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                                height: 70,
                                child: !_isInProgress ? Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: AppButton(
                                      fontSize: 18,
                                      text: !_isForSignUp ?
                                      "Войти в профиль":
                                      "Создать",
                                      onPressed: () async{
                                        final email = _emailController.text.trim();
                                        final pass = _passwordController.text.trim();
                                        final name = _nameController.text.trim();
                                        if(email.isNotEmpty && pass.isNotEmpty &&
                                          (_isForSignUp ? name.isNotEmpty : true)){
                                          setState(() => _isInProgress = true);
                                          if(_isForSignUp){
                                            await firebaseBloc.createAccount(
                                              context,
                                              _nameController.text,
                                              _emailController.text,
                                              _passwordController.text,
                                                  (){
                                                _emailController.clear();
                                                _nameController.clear();
                                                _passwordController.clear();
                                                setState(() => _isForSignUp = false);
                                              }
                                            );
                                          }
                                          else{
                                            await firebaseBloc.signIn(
                                              context,
                                              _emailController.text,
                                              _passwordController.text
                                            );
                                          }
                                          setState(() => _isInProgress = false);
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: "Заполните все поля");
                                        }
                                      },
                                    ),
                                  ),
                                ) : const LoadingView()
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: (){
                                setState(() => _isForSignUp = !_isForSignUp);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: appColor,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: appFont
                                )
                              ),
                              child: Text(
                                !_isForSignUp ?
                                "До сих пор нет профиля? Тогда создайте" :
                                "Уже есть профиль. Войти"
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ) : const LoadingView();
          }
        )
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _secondNameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }
}

