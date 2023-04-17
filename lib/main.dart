import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_casino/providers/game_provider.dart';
import 'package:street_casino/screens/game_screen.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(
            create: (_) => GameProvider())],
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: const GameScreen(),
    );
  }
}
