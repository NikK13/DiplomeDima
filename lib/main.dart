import 'package:diplome_dima/data/utils/app.dart';
import 'package:diplome_dima/data/utils/guards.dart';
import 'package:diplome_dima/data/utils/router.gr.dart';
import 'package:diplome_dima/data/utils/styles.dart';
import 'package:diplome_dima/ui/bloc/app_bloc.dart';
import 'package:diplome_dima/ui/bloc/fb_bloc.dart';
import 'package:diplome_dima/ui/provider/prefsprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

late AppBloc appBloc;
late FirebaseBloc firebaseBloc;
late PreferenceProvider prefsProvider;

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

Future loadingFuture = Future.delayed(const Duration(milliseconds: 1500));

bool isToRedirectHome = true;
bool isAsAdministrator = false;
bool? isUserEnabled;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      databaseURL: "https://diplomedima-default-rtdb.firebaseio.com",
      apiKey: "AIzaSyCEhsD5z0PuH_QmVEodZcGMTotYhbLr6Tk",
      appId: "1:347979231210:web:81d10483c6cadba34e8c93",
      messagingSenderId: "347979231210",
      projectId: "diplomedima",
      storageBucket: "diplomedima.appspot.com",
    )
  );
  firebaseBloc = FirebaseBloc();
  appBloc = AppBloc();
  if(kIsWeb) setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  final _appRouter = AppRouter(
    checkIfUserLoggedIn: CheckIfUserLoggedIn()
  );

  Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (ctx, provider, child) {
        prefsProvider = provider;
        return provider.currentTheme != null ? MaterialApp.router(
          key: globalKey,
          title: App.appName,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          themeMode: getThemeMode("light"),
          theme: themeLight,
          darkTheme: themeDark,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          routeInformationProvider: _appRouter.routeInfoProvider(),
        ) : const SizedBox();
      },
    );
  }
}

