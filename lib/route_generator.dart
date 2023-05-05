import 'package:flutter/material.dart';
import 'package:scanteen_users/Users/ContractorList/c_list.dart';
import 'package:scanteen_users/Users/UserFood/u_food.dart';
import 'package:scanteen_users/Users/orders/orders.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as String;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => C_list());

      case '/u_food':
        return MaterialPageRoute(
          builder: (_) => UserFood(data: args),
        );
        //case '/o_food':
        //return MaterialPageRoute(builder: (_) => UserOrder());
    }
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('Error'),
      ),
    );
  });
}
