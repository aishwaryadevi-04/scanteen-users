import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen_users/Users/UserFood/food_category.dart';
import 'package:scanteen_users/Users/UserFood/u_food_list.dart';
import 'package:scanteen_users/navbar.dart';

import 'package:flutter_session/flutter_session.dart';

import 'dart:convert';

class UserFood extends StatefulWidget {
  //Selected food item of users

  final data;

  const UserFood({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<UserFood> createState() => UserFoodState();
}

class UserFoodState extends State<UserFood> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> _filteredFood = [];

  initState() {
    _filteredFood = u_food;
    _updateCount();
    super.initState();
  }

  void _filterFood(String input) {
    //Filter food based on search input
    List<Map<String, dynamic>> results = [];
    if (input.isEmpty) {
      results = u_food;
    } else {
      results = u_food
          .where((food) =>
              food["f_name"].toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredFood = results;
      print('Filtered food : $_filteredFood');
    });
  }

  int calculatePrice() {
    //Calculate total price
    int total = 0;
    for (int i = 0; i < u_food.length; i++) {
      int count = u_food[i]['count'] ?? 0;
      int price = u_food[i]['f_price'] ?? 0;
      total += count * price;
    }
    print('Total amount : $total');
    return total;
  }

  List<Map<String, dynamic>> selectedFoodItems() {
    List<Map<String, dynamic>> selectedFood = [];
    for (var item in u_food) {
      if (item['count'] > 0) {
        selectedFood.add(item);
      }
    }
    return selectedFood;
  }

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> _orderedFoodListget = [];
  List<Map<String, dynamic>> orderedFoodListJson = [];

  Future<void> _updateCount() async {
    //Update count of selected items
    final session = FlutterSession();

    final orderedFoodList = await session.get('ordered_food_list');
    if (orderedFoodList == null) {
      return;
    }

    String jstr = json.encode(orderedFoodList).toString();
    final parsedList =
        List<Map<String, dynamic>>.from(json.decode(jstr.toString()));
    for (int i = 0; i < parsedList.length; i++) {
      Map<String, dynamic> cartItem = parsedList[i];
      String itemName = cartItem['f_name'];
      int itemCount = cartItem['count'];

      for (int j = 0; j < u_food.length; j++) {
        Map<String, dynamic> orderedItem = u_food[j];
        if (orderedItem['f_name'] == itemName) {
          orderedItem['count'] = itemCount;
        }
      }
    }
    print('count updated from local storage $u_food');
    setState(() {});
  }

//Save fooditems to local storage
  Future<void> _saveOrderedFoodList(List<Map<String, dynamic>> u_food) async {
    final session = FlutterSession();
    final orderedFoodListSave = json.encode(u_food);
    await session.set('ordered_food_list', orderedFoodListSave);
  }

  @override
  Widget build(BuildContext context) {
   
    //To display selected contractor name
    String selectedCname = widget.data;
    return Scaffold(
      backgroundColor: const Color(0xFF17181D),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 77),
              AppBar(
                backgroundColor: const Color(0xFF17181D),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFFFCD9B8),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    selectedCname,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xFFFCD9B8),
                      ),
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(
                        color: const Color(0xFFBDBDBD).withOpacity(0.1),
                        thickness: 1.0,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 16, 33),
                child: Column(
                  children: [
                    //Search button
                    Container(
                      height: 34,
                      child: TextField(
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        onChanged: (value) => _filterFood(value),
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.search,
                                color: const Color(0xFF757575)),
                            hintText: 'Search',
                            hintStyle: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Color(0xFF757575), fontSize: 13)),
                            fillColor: const Color(0XFF2B2B2B),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            contentPadding: const EdgeInsets.only(left: 50.0)),
                      ),
                    ),
                    const SizedBox(height: 17.0),
                    const FoodCategory(),
                    const SizedBox(height: 17),
                    Row(
                      //Total amount
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Total : Rs ${calculatePrice()}',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0XFF757575),
                              fontSize: 20,
                            ))),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context).pushNamed('/o_food',
                                arguments: selectedFoodItems()),
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE09145),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(64, 30),
                          ),
                          child: Text(
                            'Proceed',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: Color(0XFF17181D),
                              ),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 44),

                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: _filteredFood.map((food) {
                          String foodName = food['f_name'];
                          int foodPrice = food['f_price'];
                          int count = food['count'];
                          File? foodImage = food['f_image'] ?? null;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 10, bottom: 33),
                            child: Container(
                              width: 361.0,
                              height: 243.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0XFF292C35),
                              ),
                              padding: EdgeInsets.only(top: 0, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 361.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0XFF757575),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60,
                                            right: 60.0,
                                            top: 0,
                                            bottom: 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 243.0,
                                          child: foodImage == null
                                              ? Image.asset('assets/food.jfif',
                                                  fit: BoxFit.fitWidth)
                                              : Image.file(foodImage,
                                                  fit: BoxFit.fitWidth),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, top: 6.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            foodName,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xFFFCD9B8),
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    food['count'] =
                                                        food['count'] - 1;
                                                    print(
                                                        'Updated count,$u_food');
                                                    _saveOrderedFoodList(
                                                        u_food);
                                                  });
                                                },
                                                child: Container(
                                                  width: 30.0,
                                                  height: 15.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color(0XFFBDBDBD),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text('-',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF17181D),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(food['count'].toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFCD9B8),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    food['count'] =
                                                        food['count'] + 1;
                                                    print(
                                                        'Updated count,$u_food');
                                                    _saveOrderedFoodList(
                                                        u_food);
                                                  });
                                                },
                                                child: Container(
                                                  width: 30.0,
                                                  height: 15.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color(0xFFE09145),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text('+',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF17181D),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Rs. $foodPrice/-',
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                    color: Color(0xFF757575),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          NavBar(selectedIndex: _selectedIndex, onTabChange: _onItemTapped),
    );
  }
}
