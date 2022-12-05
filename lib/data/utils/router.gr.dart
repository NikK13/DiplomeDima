// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:diplome_dima/data/model/car.dart' as _i12;
import 'package:diplome_dima/data/utils/guards.dart' as _i11;
import 'package:diplome_dima/ui/fragments/cars.dart' as _i6;
import 'package:diplome_dima/ui/fragments/orders.dart' as _i8;
import 'package:diplome_dima/ui/fragments/test_drives.dart' as _i7;
import 'package:diplome_dima/ui/pages/cars_edit.dart' as _i3;
import 'package:diplome_dima/ui/pages/catalog.dart' as _i5;
import 'package:diplome_dima/ui/pages/details_car.dart' as _i4;
import 'package:diplome_dima/ui/pages/home.dart' as _i2;
import 'package:diplome_dima/ui/pages/login.dart' as _i1;
import 'package:flutter/material.dart' as _i10;

class AppRouter extends _i9.RootStackRouter {
  AppRouter({
    _i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
    required this.checkIfUserLoggedIn,
  }) : super(navigatorKey);

  final _i11.CheckIfUserLoggedIn checkIfUserLoggedIn;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    CarsEditPageRoute.name: (routeData) {
      final args = routeData.argsAs<CarsEditPageRouteArgs>(
          orElse: () => const CarsEditPageRouteArgs());
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.CarsEditPage(
          key: args.key,
          car: args.car,
        ),
      );
    },
    CarDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<CarDetailsPageRouteArgs>(
          orElse: () => const CarDetailsPageRouteArgs());
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.CarDetailsPage(
          key: args.key,
          car: args.car,
        ),
      );
    },
    CatalogPageRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.CatalogPage(),
      );
    },
    CarsFragmentRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.CarsFragment(),
      );
    },
    TestDrivesFragmentRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.TestDrivesFragment(),
      );
    },
    OrdersFragmentRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.OrdersFragment(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i9.RouteConfig(
          LoginPageRoute.name,
          path: '/login',
          guards: [checkIfUserLoggedIn],
        ),
        _i9.RouteConfig(
          HomePageRoute.name,
          path: '',
          guards: [checkIfUserLoggedIn],
          children: [
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'cars',
              fullMatch: true,
            ),
            _i9.RouteConfig(
              CarsFragmentRoute.name,
              path: 'cars',
              parent: HomePageRoute.name,
              guards: [checkIfUserLoggedIn],
            ),
            _i9.RouteConfig(
              TestDrivesFragmentRoute.name,
              path: 'testDrives',
              parent: HomePageRoute.name,
              guards: [checkIfUserLoggedIn],
            ),
            _i9.RouteConfig(
              OrdersFragmentRoute.name,
              path: 'orders',
              parent: HomePageRoute.name,
              guards: [checkIfUserLoggedIn],
            ),
          ],
        ),
        _i9.RouteConfig(
          CarsEditPageRoute.name,
          path: '/carInfo',
          guards: [checkIfUserLoggedIn],
        ),
        _i9.RouteConfig(
          CarDetailsPageRoute.name,
          path: '/details',
          guards: [checkIfUserLoggedIn],
        ),
        _i9.RouteConfig(
          CatalogPageRoute.name,
          path: '/catalog',
          guards: [checkIfUserLoggedIn],
        ),
        _i9.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i9.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomePageRoute extends _i9.PageRouteInfo<void> {
  const HomePageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i3.CarsEditPage]
class CarsEditPageRoute extends _i9.PageRouteInfo<CarsEditPageRouteArgs> {
  CarsEditPageRoute({
    _i10.Key? key,
    _i12.Car? car,
  }) : super(
          CarsEditPageRoute.name,
          path: '/carInfo',
          args: CarsEditPageRouteArgs(
            key: key,
            car: car,
          ),
        );

  static const String name = 'CarsEditPageRoute';
}

class CarsEditPageRouteArgs {
  const CarsEditPageRouteArgs({
    this.key,
    this.car,
  });

  final _i10.Key? key;

  final _i12.Car? car;

  @override
  String toString() {
    return 'CarsEditPageRouteArgs{key: $key, car: $car}';
  }
}

/// generated route for
/// [_i4.CarDetailsPage]
class CarDetailsPageRoute extends _i9.PageRouteInfo<CarDetailsPageRouteArgs> {
  CarDetailsPageRoute({
    _i10.Key? key,
    _i12.Car? car,
  }) : super(
          CarDetailsPageRoute.name,
          path: '/details',
          args: CarDetailsPageRouteArgs(
            key: key,
            car: car,
          ),
        );

  static const String name = 'CarDetailsPageRoute';
}

class CarDetailsPageRouteArgs {
  const CarDetailsPageRouteArgs({
    this.key,
    this.car,
  });

  final _i10.Key? key;

  final _i12.Car? car;

  @override
  String toString() {
    return 'CarDetailsPageRouteArgs{key: $key, car: $car}';
  }
}

/// generated route for
/// [_i5.CatalogPage]
class CatalogPageRoute extends _i9.PageRouteInfo<void> {
  const CatalogPageRoute()
      : super(
          CatalogPageRoute.name,
          path: '/catalog',
        );

  static const String name = 'CatalogPageRoute';
}

/// generated route for
/// [_i6.CarsFragment]
class CarsFragmentRoute extends _i9.PageRouteInfo<void> {
  const CarsFragmentRoute()
      : super(
          CarsFragmentRoute.name,
          path: 'cars',
        );

  static const String name = 'CarsFragmentRoute';
}

/// generated route for
/// [_i7.TestDrivesFragment]
class TestDrivesFragmentRoute extends _i9.PageRouteInfo<void> {
  const TestDrivesFragmentRoute()
      : super(
          TestDrivesFragmentRoute.name,
          path: 'testDrives',
        );

  static const String name = 'TestDrivesFragmentRoute';
}

/// generated route for
/// [_i8.OrdersFragment]
class OrdersFragmentRoute extends _i9.PageRouteInfo<void> {
  const OrdersFragmentRoute()
      : super(
          OrdersFragmentRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersFragmentRoute';
}
