import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('Material auto_router', () {
    test(
      'Simple test',
      () async {
        return testGenerator(
          generatedFile: generatedFile,
          router: r'''
            import 'package:auto_route/annotations.dart';

            class HomeScreen {
              HomeScreen({
                @PathParam() required int id,
                @QueryParam() required String desc,
                // required String title
              });
            }

            @MaterialAutoRouter(
              routes: <AutoRoute>[
                AutoRoute<void>(page: HomeScreen, initial: true),
              ],
            )
            class $AppRouter {}
          ''',
        );
      },
    );
  });
}

const generatedFile =
    r'''// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import 'router.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => HomeScreenRouteArgs(
              id: pathParams.getInt('id'),
              desc: queryParams.getString('desc')));
      return _i2.MaterialPageX<void>(
          routeData: routeData,
          child: _i1.HomeScreen(id: args.id, desc: args.desc));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeScreenRoute.name,
            path: '/', requiredQueryParams: ['desc'])
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i2.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({required int id, required String desc})
      : super(HomeScreenRoute.name,
            path: '/',
            args: HomeScreenRouteArgs(id: id, desc: desc),
            rawPathParams: {'id': id},
            rawQueryParams: {'desc': desc});

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({required this.id, required this.desc});

  final int id;

  final String desc;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{id: $id, desc: $desc}';
  }
}
''';
