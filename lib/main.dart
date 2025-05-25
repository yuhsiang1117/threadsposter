import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:threadsposter/services/post_query_provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NavigationService>(create: (context) => NavigationService()),
        ChangeNotifierProvider<PostQueryProvider>(
          create: (context) => PostQueryProvider(),
        ),
      ],
      child: const App(),
    ),
    
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      restorationScopeId: 'app',
      title: 'Threads Poster',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
