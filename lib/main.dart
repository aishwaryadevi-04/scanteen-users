import 'package:flutter/material.dart';
import 'package:scanteen_users/Users/u_food.dart';
import 'package:scanteen_users/Users/c_list.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const C_list(),
        '/u_food': (context) => const u_food(),
        
      },
    );
  }
}