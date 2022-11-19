// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diplome_dima/data/utils/constants.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/main.dart';
import 'package:diplome_dima/ui/bloc/bloc.dart';
import 'package:diplome_dima/ui/widgets/bottom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseBloc implements BaseBloc{
  late FirebaseAuth fbAuth;

  User? fbUser;

  String? username;
  String? image;

  bool emailValidated(email) => email.contains("@") && email.length >= 4;

  bool passwordValidated(password) => password.length >= 6;
  bool nameValidated(name) => name.length >= 2;

  FirebaseBloc() {
    load();
  }

  load() async {
    fbAuth = FirebaseAuth.instance;
    fbAuth.authStateChanges().listen((User? user) {
      fbUser = fbAuth.currentUser;
      if(fbUser != null){
        isAsAdministrator = fbUser!.email!.contains(adminEmail);
      }
    });
  }

  Future<void> signOutUser() async{
    await fbAuth.signOut();
  }

  Future<void> createAccount(context, name, email, password, onSuccess) async {
    if(emailValidated(email) && passwordValidated(password) && nameValidated(name)){
      isToRedirectHome = false;
      try {
        final UserCredential user = await fbAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if(user.user != null){
          await user.user!.sendEmailVerification();
          await createUserProfile(user.user!, name, email);
          await fbAuth.signOut();
          Fluttertoast.showToast(
            msg: "Пользователь успешно создан. Для входа вам будет отправлено подтверждение на эл.почту"
          );
          onSuccess();
        }
      } on FirebaseAuthException catch (e) {
        showInfoDialog(context, e.message.toString());
      }
    }
    else{
      if(!emailValidated(email)){
        Fluttertoast.showToast(msg: "Эл.адрес должен содержать символ @ и состоять из 4 символов или более");
      }
      if(!nameValidated(name)){
        Fluttertoast.showToast(msg: "Имя должно содержать более одного символа");
      }
      if(!passwordValidated(email)){
        Fluttertoast.showToast(msg: "Пароль должен содержать более 5 символов");
      }
    }
  }

  Future<void> signIn(BuildContext context, email, password) async {
    try {
      isToRedirectHome = false;
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
      if(fbAuth.currentUser != null){
        if(fbAuth.currentUser!.email!.contains(adminEmail)){
          context.router.replaceAll([const HomePageRoute()]);
          isAsAdministrator = true;
          isToRedirectHome = true;
        }
        else{
          if(fbAuth.currentUser!.emailVerified){
            context.router.replaceAll([const HomePageRoute()]);
            isAsAdministrator = false;
            isToRedirectHome = true;
          }
          else{
            Fluttertoast.showToast(msg: "Эл.адрес не подтвержден. Подтвердите перед входом в аккаунт");
            await fbAuth.signOut();
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showInfoDialog(context, e.message.toString());
    }
  }

  updateUserData({required Map<String, dynamic> data}) async {
    final db = FirebaseDatabase.instance.ref().child('users/${fbAuth.currentUser!.uid}');
    await db.once().then((child) {
      db.child(fbAuth.currentUser!.uid).parent!.update(data);
    });
  }

  createUserProfile(user, name, email) async {
    final db = FirebaseDatabase.instance.ref().child('users/${user.uid}');
    await db.once().then((child) {
      if (!child.snapshot.exists) {
        db.child(user.uid).parent!.set(<String, dynamic>{
          "username": name,
          "email": email,
          "image": "default",
        });
      }
    });
  }

  @override
  dispose() {}
}