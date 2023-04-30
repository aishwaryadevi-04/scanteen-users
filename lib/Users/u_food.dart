import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanteen_users/navbar.dart';

class u_food extends StatefulWidget {
  //Selected food item of users
  const u_food({super.key});

  @override
  State<u_food> createState() => _u_foodState();
}

class _u_foodState extends State<u_food> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    //Selected index in navbar
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> u_food = [
    {'f_name': 'Chicken Sandwich', 'f_price': 75, 'count': 1},
    {'f_name': 'Veg Burger', 'f_price': 50, 'count': 1},
    {'f_name': 'Pizza', 'f_price': 100, 'count': 1},
    {'f_name': 'Icecream', 'f_price': 45, 'count': 1},
  ];
  List<Map<String, dynamic>> _filteredFood = [];

  initState() {
    _filteredFood = u_food;
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
    return total;
  }

  List<String> types = ['Snacks', 'Drinks', 'Lunch', 'Icecream'];

  @override
  Widget build(BuildContext context) {
    //To display selected contractor name
    String? selectedCname =
        ModalRoute.of(context)!.settings.arguments as String;
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
                    Container(
                      height: 34,
                      child: TextField(
                        style: TextStyle(color: Color(0xFFFCD9B8)),
                        onChanged: (value) => _filterFood(value),
                        decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.search,color: const Color(0xFF757575)),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: types.map((entry) {
                          String key = entry;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE09145),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: const Size(90, 30),
                                ),
                                child: Text(
                                  key,
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      color: Color(0XFF17181D),
                                    ),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15)
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Total : Rs ${calculatePrice()}',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0XFF757575),
                              fontSize: 20,
                            ))),
                        ElevatedButton(
                          onPressed: () => {},
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
                    Column(
                      children: _filteredFood.map((food) {
                        String key = food['f_name'];
                        int value = food['f_price'];
                        int count = food['count'];
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
                                          key,
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
                                                  if (count > 1) {
                                                    food['count'] = count - 1;
                                                  }
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
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text('-',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF17181D),
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
                                                Text(count.toString(),
                                                    style: TextStyle(
                                                      color: Color(0xFFFCD9B8),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  food['count'] = count + 1;
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
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text('+',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF17181D),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'Rs. $value/-',
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
