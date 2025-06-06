import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/widgets/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const WindowsInitializationSettings windowsSettings =
      WindowsInitializationSettings(
        appName: 'threadsposter',
        appUserModelId: 'threadsposter',
        guid: '85320a7d-2ba7-4fb9-b39f-9573a42a3c37'
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    windows: windowsSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> requestPermissions() async {
  
    await Permission.notification.request();
  }

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          // ✅ 這裡登入後再初始化 Provider
          return MultiProvider(
            providers: [
              Provider<NavigationService>(create: (_) => NavigationService()),
              ChangeNotifierProvider<ToneProvider>(create: (_) => ToneProvider()),
              ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
            ],
            child: MaterialApp.router(
              routerConfig: routerConfig,
              restorationScopeId: 'app',
              title: 'Threads Poster',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
            )
          );
        } else {
          // 👤 未登入，直接去登入頁面
          return LoginPage();
        }
      },
    );
  }
}




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[main] 初始化開始');
  try {
    await initializeNotifications().timeout(const Duration(seconds: 5));
    debugPrint('[main] 通知初始化完成');
  } catch (e) {
    debugPrint('[main] 通知初始化失敗: $e');
  }
  try {
    await requestPermissions().timeout(const Duration(seconds: 5));
    debugPrint('[main] 權限請求完成');
  } catch (e) {
    debugPrint('[main] 權限請求失敗: $e');
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 5));
    debugPrint('[main] Firebase 初始化完成');
  } catch (e) {
    debugPrint('[main] Firebase 初始化失敗: $e');
  }
  debugPrint('[main] Firebase 初始化完成');
  runApp(
    App()
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Threads Poster',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(), // 讓 AuthGate 成為首頁，裡面再決定顯示什麼頁面
    );
  }
}
