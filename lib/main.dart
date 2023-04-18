import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/providers/street_casino_game_provider.dart';
import 'package:street_casino/screens/game_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(
            create: (_) => StreetCasinoGameProvider())],
            child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Game',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: const GameScreen(),
    );
  }
}
