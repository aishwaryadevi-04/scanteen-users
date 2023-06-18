import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen_users/Users/ContractorList/header.dart';
import 'package:scanteen_users/Users/orders/header.dart';
import 'package:flutter_session/flutter_session.dart';
import '../../navbar.dart';
import 'dart:convert';

class CartItem extends StatefulWidget {
  List<Map<String, dynamic>> selectedItems;
  CartItem({
    Key? key,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> _orderedFoodListget = [];
  List<Map<String, dynamic>> orderedFoodListJson = [];

  void initState() {
    super.initState();
    List<Map<String, dynamic>> cartItems = widget.selectedItems;
    _saveOrderedFoodList(cartItems);
  }

  Future<void> _getOrderedFoodList() async {
    //Get food list from local storage
    final session = FlutterSession();
    final orderedFoodList = await session.get('ordered_food_list');
    String jstr = json.encode(orderedFoodList).toString();
    final parsedList =
        List<Map<String, dynamic>>.from(json.decode(jstr.toString()));
    setState(() {
      _orderedFoodListget = parsedList;
    });

    print('Food items from local storage:$_orderedFoodListget');
  }

  Future<void> _saveOrderedFoodList(
      List<Map<String, dynamic>> cartItems) async {
    //Save updated list to local storage
    final session = FlutterSession();
    final orderedFoodListSave = json.encode(cartItems);
    await session.set('ordered_food_list', orderedFoodListSave);
    _getOrderedFoodList();
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  int calculatePrice() {
    //Calculate total price
    int total = 0;
    for (int i = 0; i < _orderedFoodListget.length; i++) {
      int count = _orderedFoodListget[i]['count'] ?? 0;
      int price = _orderedFoodListget[i]['f_price'] ?? 0;
      total += count * price;
    }
    print('Total amount(cart) : $total');
    return total;
  }

  @override
  Widget build(BuildContext context) {
    void initState() {
      calculatePrice();
      super.initState();
    }

    return Scaffold(
      backgroundColor: const Color(0XFF17181D),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const OrderHeader(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _orderedFoodListget.map((orderedFood) {
                        String foodName = orderedFood['f_name'] ?? '';
                        int foodPrice = orderedFood['f_price'] ?? 0;
                        int foodCount = orderedFood['count'] ?? 0;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 65,
                                  child: Image.asset(
                                    'assets/food.jfif',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      left: 10,
                                      bottom: 25,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            foodName,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                color: Color(0xFFFCD9B8),
                                              ),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (orderedFood['count'] >
                                                          1)
                                                        orderedFood['count'] =
                                                            orderedFood[
                                                                    'count'] -
                                                                1;
                                                      print(
                                                          'Updated count,$_orderedFoodListget');
                                                      _saveOrderedFoodList(
                                                          _orderedFoodListget);
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
                                                            textAlign: TextAlign
                                                                .center,
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
                                                    Text(
                                                      orderedFood['count']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFCD9B8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      orderedFood['count'] =
                                                          orderedFood['count'] +
                                                              1;
                                                      print(
                                                          'Updated count,$_orderedFoodListget');
                                                      _saveOrderedFoodList(
                                                          _orderedFoodListget);
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
                                                  right: 20.0),
                                              child: Text(
                                                'Rs. $foodPrice',
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                    color: Color(0xFF757575),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: const Color(0xFFBDBDBD).withOpacity(0.1),
                              thickness: 1.0,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Total Amount',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Color(0xFFFCD9BB),
                        ),
                        fontSize: 18.0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Rs ${calculatePrice()}',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Color(0xFFE09145),
                        ),
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE09145),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(300, 50),
                    ),
                    child: Text(
                      "Next",
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
    );
  }
}
