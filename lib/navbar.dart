import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen_users/Users/ContractorList/header.dart';
import 'package:scanteen_users/Users/orders/header.dart';
import 'package:flutter_session/flutter_session.dart';
import '../../navbar.dart';
import 'dart:convert';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Map<String, dynamic>> _orderedFoodListget = [];
  Future<void> _getOrderedFood() async {//Get food list 
  final session = FlutterSession();
  final orderedFoodList = await session.get('ordered_food_list');

  if (orderedFoodList != null) {
    String jstr = json.encode(orderedFoodList).toString();
    final parsedList = List<Map<String, dynamic>>.from(json.decode(jstr.toString()));
    setState(() {
      _orderedFoodListget = parsedList;
    });
  } else {
    setState(() {
      _orderedFoodListget = [];
    });
  }
}


  @override
  initState() {
    super.initState();
    _getOrderedFood();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        height: 42,
        child: GNav(
          selectedIndex: widget.selectedIndex,
          onTabChange: (index) async {
            widget.onTabChange(index);
            switch (index) {
              case 0:
                Navigator.of(context).pushNamed('/');
                break;
              case 1:
                await _getOrderedFood();
                Navigator.of(context)
                    .pushNamed('/o_food', arguments: _orderedFoodListget);
                break;
              case 2:
                // Navigator.pushNamed(context, '');
                break;
            }
          },
          backgroundColor: const Color(0xFF17181D),
          color: Colors.white,
          activeColor: Color(0XFF17181D),
          tabBackgroundColor: Color(0xFFFCD9B8),
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
