import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/pages/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}