// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scanteen_users/Users/orders/header.dart';

// import '../../navbar.dart';

// class UserOrder extends StatefulWidget {
//   const UserOrder({super.key});

//   @override
//   State<UserOrder> createState() => _UserOrderState();
// }

// class _UserOrderState extends State<UserOrder> {
 

   
//   int _selectedIndex = 1;

//   void _onItemTapped(int index) {
//     //Selected index in navbar
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

// List<Map<String, dynamic>>o_details = [
    
//   ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF292C35),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const OrderHeader(),
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30.0),
//                   topRight: Radius.circular(30.0)),
//               child: Scaffold(
//                   backgroundColor: Color(0XFF17181D),
//                   body: Column(
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Padding(
//                               padding: const EdgeInsets.only(left: 25.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children:
//                                     o_details.map((orders) {
//                                   String cname = orders['c_name'];
//                                   String category = orders['category'];
//                                   return Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 0,
//                                         child: ElevatedButton(
//                                           onPressed: () => {
                                            
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 const Color(0xFFE09145),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                             ),
//                                             minimumSize: const Size(110, 70),
//                                           ),
//                                           child: Text(
//                                             'Order',
//                                             style: GoogleFonts.inter(
//                                                 textStyle: const TextStyle(
//                                                   color: Color(0XFF17181D),
//                                                 ),
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 20, left: 10, bottom: 25),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   cname,
//                                                   style: GoogleFonts.inter(
//                                                     textStyle: const TextStyle(
//                                                       color: Color(0xFFFCD9B8),
//                                                     ),
//                                                     fontSize: 24,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '$category * \$\$',
//                                                   style: GoogleFonts.inter(
//                                                     textStyle: const TextStyle(
//                                                       color: Color(0xFF757575),
//                                                     ),
//                                                     fontSize: 17,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 }).toList(),
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                   bottomNavigationBar: NavBar(
//                       selectedIndex: _selectedIndex,
//                       onTabChange: _onItemTapped)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

 