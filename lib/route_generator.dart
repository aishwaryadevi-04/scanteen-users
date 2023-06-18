import 'package:flutter/material.dart';
import 'package:scanteen_users/Users/ContractorList/c_list.dart';
import 'package:scanteen_users/Users/UserFood/u_food.dart';
import 'package:scanteen_users/Users/orders/orders.dart';
import 'package:scanteen_users/Users/UserFood/u_food.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => C_list());

      case '/u_food':
        final args = settings.arguments as String;//contractor name
        return MaterialPageRoute(
          builder: (_) => UserFood(data: args),
        );

      case '/o_food':
        final args = settings.arguments as List<Map<String, dynamic>>;
        List<Map<String, dynamic>> selectedFoodItems() {//Find the selected items using count
          List<Map<String, dynamic>> selectedFood = [];
          if (args == null) return [];
          for (var item in args) {
            if (item['count'] > 0) {
              selectedFood.add(item);
            }
          }
          return selectedFood;
        }
        return MaterialPageRoute(
            builder: (_) => CartItem(selectedItems: selectedFoodItems()));
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
