import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:threadsposter/theme/none_theme.dart' as none_theme;
import 'package:threadsposter/theme/boss_theme.dart' as boss_theme;
import 'package:threadsposter/theme/simp_theme.dart' as simp_theme;
import 'package:threadsposter/theme/custom_theme.dart' as custom_theme;

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
    return MultiProvider(
        providers: [
          Provider<NavigationService>(create: (_) => NavigationService()),
          ChangeNotifierProvider<ToneProvider>(create: (_) => ToneProvider()),
          ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
        ],
        child: Consumer<ToneProvider>(
        builder: (context, toneProvider, child) {
          final tones = toneProvider.tones.isNotEmpty ? toneProvider.tones : defaultToneOptions;
          final currentPage = toneProvider.currentPage;
          final currentTone = tones.isNotEmpty && currentPage < tones.length ? tones[currentPage].id : 'none';
          ThemeData theme;
          switch (currentTone) {
            case 'simp':
              theme = simp_theme.MaterialTheme(ThemeData.light().textTheme).light();
              break;
            case 'boss':
              theme = boss_theme.MaterialTheme(ThemeData.light().textTheme).light();
              break;
            case 'custom':
              theme = custom_theme.MaterialTheme(ThemeData.light().textTheme).light();
              break;
            case 'none':
              theme = none_theme.MaterialTheme(ThemeData.light().textTheme).light();
              break;
            default:
              theme = none_theme.MaterialTheme(ThemeData.light().textTheme).light();
              break;
          }
          return MaterialApp.router(
            routerConfig: routerConfig,
            restorationScopeId: 'app',
            title: 'Threads Poster',
            theme: theme,
          );
        })
      );

  }
}
