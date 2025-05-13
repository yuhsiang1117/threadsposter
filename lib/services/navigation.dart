import 'package:flutter/material.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
          child: HomePage(selectedTab: HomeTab.home)),
    ),
    GoRoute(
      path: '/post',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
          child: HomePage(selectedTab: HomeTab.post)),
    ),
    GoRoute(
      path: '/setting',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
          child: HomePage(selectedTab: HomeTab.setting)),
    ),
  ],
  initialLocation: '/home',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final currentPath = state.uri.path;
    if (currentPath == '/') {
      return '/home';
    }
    // No redirection needed for other routes
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);

class NavigationService {
  late final GoRouter _router;

  NavigationService() {
    _router = routerConfig;
  }

  String _currentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }

  void goHome({required HomeTab tab}) {
    _router.go('/${tab.name}');
  }

  // To work with the web browser history, do not use Navigator.push() or pop() directly
  // void pushFiltersOnHome({required BuildContext context}) {
  //   var path = _currentPath(context);
  //   switch (path) {
  //     case '/categories':
  //       _router.go('/categories/filters');
  //       return;
  //     case '/favorites':
  //       _router.go('/favorites/filters');
  //       return;
  //   }
  //   throw Exception('Cannot push filters on the path: $path');
  // }

  // void goMealsOnCategory({required String categoryId}) {
  //   _router.go('/categories/$categoryId/meals');
  // }

  void goPost() {
    _router.go('/post');
  }

  // void goMealDetailsOnFavorites({required String mealId}) {
  //   _router.go('/favorites/$mealId');
  // }
}
