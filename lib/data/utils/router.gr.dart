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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:diplome_dima/data/model/car.dart' as _i9;
import 'package:diplome_dima/data/utils/guards.dart' as _i8;
import 'package:diplome_dima/ui/fragments/cars.dart' as _i4;
import 'package:diplome_dima/ui/fragments/orders.dart' as _i5;
import 'package:diplome_dima/ui/pages/cars_edit.dart' as _i3;
import 'package:diplome_dima/ui/pages/home.dart' as _i2;
import 'package:diplome_dima/ui/pages/login.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.checkIfUserLoggedIn,
  }) : super(navigatorKey);

  final _i8.CheckIfUserLoggedIn checkIfUserLoggedIn;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    CarsEditPageRoute.name: (routeData) {
      final args = routeData.argsAs<CarsEditPageRouteArgs>(
          orElse: () => const CarsEditPageRouteArgs());
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.CarsEditPage(
          key: args.key,
          car: args.car,
        ),
      );
    },
    CarsFragmentRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.CarsFragment(),
      );
    },
    OrdersFragmentRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.OrdersFragment(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          LoginPageRoute.name,
          path: '/login',
          guards: [checkIfUserLoggedIn],
        ),
        _i6.RouteConfig(
          HomePageRoute.name,
          path: '',
          guards: [checkIfUserLoggedIn],
          children: [
            _i6.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'cars',
              fullMatch: true,
            ),
            _i6.RouteConfig(
              CarsFragmentRoute.name,
              path: 'cars',
              parent: HomePageRoute.name,
              guards: [checkIfUserLoggedIn],
            ),
            _i6.RouteConfig(
              OrdersFragmentRoute.name,
              path: 'orders',
              parent: HomePageRoute.name,
              guards: [checkIfUserLoggedIn],
            ),
          ],
        ),
        _i6.RouteConfig(
          CarsEditPageRoute.name,
          path: '/carInfo',
          guards: [checkIfUserLoggedIn],
        ),
        _i6.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i6.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomePageRoute extends _i6.PageRouteInfo<void> {
  const HomePageRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i3.CarsEditPage]
class CarsEditPageRoute extends _i6.PageRouteInfo<CarsEditPageRouteArgs> {
  CarsEditPageRoute({
    _i7.Key? key,
    _i9.Car? car,
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

  final _i7.Key? key;

  final _i9.Car? car;

  @override
  String toString() {
    return 'CarsEditPageRouteArgs{key: $key, car: $car}';
  }
}

/// generated route for
/// [_i4.CarsFragment]
class CarsFragmentRoute extends _i6.PageRouteInfo<void> {
  const CarsFragmentRoute()
      : super(
          CarsFragmentRoute.name,
          path: 'cars',
        );

  static const String name = 'CarsFragmentRoute';
}

/// generated route for
/// [_i5.OrdersFragment]
class OrdersFragmentRoute extends _i6.PageRouteInfo<void> {
  const OrdersFragmentRoute()
      : super(
          OrdersFragmentRoute.name,
          path: 'orders',
        );

  static const String name = 'OrdersFragmentRoute';
}
