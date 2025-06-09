import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threadsposter/widgets/setting/edit_profile.dart';
import 'package:threadsposter/widgets/widgets.dart';
import 'package:threadsposter/services/api.dart';
import 'package:threadsposter/widgets/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:threadsposter/models/query_history.dart';

final routerConfig = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: Home()
      ),
    ),
    GoRoute(
      path: '/post',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: Post()
      ),
      routes: <RouteBase>[
        GoRoute(
          path: 'result',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: PostResult()
          ),
        )
      ]
    ),
    GoRoute(
      path: '/setting',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: Setting()
      ),
      routes: <RouteBase>[
        GoRoute(
          path: 'edit_profile',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: EditProfilePage()
          ),
        ),
        GoRoute(
          path: 'favorites',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: SavedPostPage()
          ),
        ),
        GoRoute(
          path: 'history',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: HistoryPage()
          ),
        ),
        GoRoute(
          path: 'notification',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: NotificationPage()
          ),
        ),
        GoRoute(
          path: 'API_test',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: ApiTestPage()
          ),
        ),
        GoRoute(
          path: 'api_setting',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: APIConfigPage()
          ),
        )
      ]
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: LoginPage()
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: RegisterPage()
      ),
    ),
   GoRoute(
      path: '/firstlogin',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: FirstLoginPage()
      ),
    ),
  ],
  redirect: (context, state) {
    final currentPath = state.uri.path;
    if (currentPath == '/') {
      return '/home';
    }
    //login
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final bool goingToLoginPage = ((state.uri.path == '/login_check' || state.uri.path == '/login') || state.uri.path == '/register');
    if (currentUser == null && !goingToLoginPage) {
    // User is not logged in and trying to access a route
      return '/login';
    }
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);

class NavigationService {
  NavigationService();

  String getCurrentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }

  void goHome() {
    routerConfig.go('/home');
  }

  void goPost({
    required String toneID,
    String specific_user = 'custom',
    bool fromHistory = false, 
    QueryHistory? query,
  }) {
    currentTone = toneID;
    if (specific_user != 'custom') {
      currentToneDisplay = specific_user;
    }
    if (fromHistory && query != null) {
      queryFromHistory = QueryHistory(
        title: query.title,
        tag: query.tag,
        style: query.style,
        size: query.size,
        specific_user: query.specific_user,
        toneID: toneID
      );
    }
    routerConfig.go('/post');
  }

  void goSetting() {
    routerConfig.go('/setting');
  }

  void goPostResult(List<GeneratedPost> postResult, String title, String style) {
    routerConfig.go('/post/result');
    currentResult = postResult;
    currentTitle = title;
    currentStyle = style;
  }

  void goEditProflie() {
    routerConfig.go('/setting/edit_profile');
  }

  void goSavedPosts() {
    routerConfig.go('/setting/favorites');
  }

  void goHistory() {
    routerConfig.go('/setting/history');
  }

  void goNotification() {
    routerConfig.go('/setting/notification');
  }

  void goApiTest() {
    routerConfig.go('/setting/API_test');
  }

  void goApisetting() {
    routerConfig.go('/setting/api_setting');
  }
  
  void goFirstLogin() {
    routerConfig.go('/firstlogin');
  }
  
  void goRegister() {
    routerConfig.go('/register');
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

  // void goMealDetailsOnFavorites({required String mealId}) {
  //   _router.go('/favorites/$mealId');
  // }
}
