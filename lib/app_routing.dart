
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter_nevigation/views/home.dart';
import 'package:gorouter_nevigation/views/home_list.dart';
import 'package:gorouter_nevigation/views/music_player.dart';
import 'package:gorouter_nevigation/views/navigator.dart';
import 'package:gorouter_nevigation/views/setting.dart';
import 'package:gorouter_nevigation/views/setting_list.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = '/Home';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: "shellHome");
  static final _shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: "shellSetting");

  static final GoRouter router = GoRouter(
      initialLocation: initial,
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      routes: [
        //Home
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapper(
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            /// Brach Home
            StatefulShellBranch(
                navigatorKey: _shellNavigatorHome,
                routes: <RouteBase>[
                  GoRoute(
                      path: "/home",
                      name: "Home",
                      builder: (BuildContext context, GoRouterState state) =>
                          const HomeView(),
                      routes: [
                        GoRoute(
                            path: 'subHome',
                            name: 'subHome',
                            pageBuilder: (context, state) {
                              return CustomTransitionPage(
                                key: state.pageKey,
                                child: const SubHomeView(),
                                transitionsBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) =>
                                    FadeTransition(
                                        opacity: animation, child: child),
                              );
                            })
                      ])
                ]),

            /// Brach Setting
            StatefulShellBranch(
              navigatorKey: _shellNavigatorSettings,
              routes: <RouteBase>[
                GoRoute(
                  path: "/settings",
                  name: "Settings",
                  builder: (BuildContext context, GoRouterState state) =>
                      const SettingsView(),
                  routes: [
                    GoRoute(
                      path: "subSetting",
                      name: "subSetting",
                      pageBuilder: (context, state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const SubSettingsView(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/player',
          name: "Player",
          builder: (context, state) => PlayerView(
            key: state.pageKey,
          ),
        )
      ]);

// GoRouter configuration
}
