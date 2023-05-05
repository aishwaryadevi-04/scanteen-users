import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:scanteen_users/Users/ContractorList/c_food_details.dart';
import 'package:scanteen_users/Users/ContractorList/header.dart';
import 'package:scanteen_users/navbar.dart';

class C_list extends StatefulWidget {
  //Display list of contractors
  const C_list({super.key});

  @override
  State<C_list> createState() => _C_listState();
}

class _C_listState extends State<C_list> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> _filteredContractors = [];

  initState() {
    _filteredContractors = c_details;
    super.initState();
  }

  void _filterContractors(String input) {
    //Filter contractors based on search input
    List<Map<String, dynamic>> results = [];
    if (input.isEmpty) {
      results = c_details;
    } else {
      results = c_details
          .where((contractors) =>
              contractors["c_name"].toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredContractors = results;
      print('filtered contractors : $_filteredContractors');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292C35),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Header(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 26, 16, 33),
            child: Container(
              height: 34.0,
              child: TextFormField(
                style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 17),
                onChanged: (value) => _filterContractors(value),
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon:
                        Icon(Icons.search, color: const Color(0xFF757575)),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Color(0xFF757575), fontSize: 13)),
                    fillColor: const Color(0XFF17181D),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: const EdgeInsets.only(left: 50.0)),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              child: Scaffold(
                  backgroundColor: Color(0XFF17181D),
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    _filteredContractors.map((contractors) {
                                  String cname = contractors['c_name'];
                                  String category = contractors['category'];
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            print('Selected Contractor : $cname'),
                                            Navigator.pushNamed(
                                                context, '/u_food',
                                                arguments: cname)
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFE09145),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            minimumSize: const Size(110, 70),
                                          ),
                                          child: Text(
                                            'Order',
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                  color: Color(0XFF17181D),
                                                ),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10, bottom: 25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cname,
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                      color: Color(0xFFFCD9B8),
                                                    ),
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Text(
                                                  '$category * \$\$',
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                      color: Color(0xFF757575),
                                                    ),
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }).toList(),
                              )),
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: NavBar(
                      selectedIndex: _selectedIndex,
                      onTabChange: _onItemTapped)),
            ),
          ),
        ],
      ),
    );
  }
}
