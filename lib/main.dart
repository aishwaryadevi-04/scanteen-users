

import 'package:flutter/material.dart';
import 'package:scanteen_users/Users/ContractorList/c_list.dart';
import 'package:scanteen_users/route_generator.dart';

void main() {
  runApp(const MaterialApp(
    home:C_list(),
    onGenerateRoute:RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

