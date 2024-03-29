import 'package:auto_route/auto_route.dart';
import 'package:diplome_dima/data/utils/guards.dart';
import 'package:diplome_dima/ui/fragments/cars.dart';
import 'package:diplome_dima/ui/fragments/orders.dart';
import 'package:diplome_dima/ui/fragments/test_drives.dart';
import 'package:diplome_dima/ui/pages/cars_edit.dart';
import 'package:diplome_dima/ui/pages/catalog.dart';
import 'package:diplome_dima/ui/pages/details_car.dart';
import 'package:diplome_dima/ui/pages/home.dart';
import 'package:diplome_dima/ui/pages/login.dart';

const String loginPath = "/login";
const String catalogPath = "/catalog";
const String detailsPath = "/details";
const String carInfoPath = "/carInfo";
const String settingsPagePath = "/settings";
const String homePath = "";

const String carsPath = "cars";
const String testDrPath = "testDrives";
const String ordersPath = "orders";

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: LoginPage,
      path: loginPath,
      guards: [CheckIfUserLoggedIn]
    ),
    AutoRoute(
      page: HomePage,
      path: homePath,
      guards: [CheckIfUserLoggedIn],
      children: [
        AutoRoute(
          initial: true,
          page: CarsFragment,
          path: carsPath,
          guards: [CheckIfUserLoggedIn]
        ),
        AutoRoute(
          page: TestDrivesFragment,
          path: testDrPath,
          guards: [CheckIfUserLoggedIn]
        ),
        AutoRoute(
          page: OrdersFragment,
          path: ordersPath,
          guards: [CheckIfUserLoggedIn]
        ),
      ]
    ),
    AutoRoute(
      page: CarsEditPage,
      path: carInfoPath,
      guards: [CheckIfUserLoggedIn]
    ),
    AutoRoute(
      page: CarDetailsPage,
      path: detailsPath,
      guards: [CheckIfUserLoggedIn]
    ),
    AutoRoute(
      page: CatalogPage,
      path: catalogPath,
      guards: [CheckIfUserLoggedIn]
    ),
    RedirectRoute(path: '*', redirectTo: "/")
  ],
)

class $AppRouter {}