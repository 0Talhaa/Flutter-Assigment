// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BottomNavBar(),
//     );
//   }
// }

// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;

//   static List<Widget> _pages = <Widget>[
//     HomeScreen(),
//     Center(child: Text('Cart Screen', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Message Screen', style: TextStyle(fontSize: 24))),
//     Center(child: Text('User Screen', style: TextStyle(fontSize: 24))),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'User',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'SHOPIN',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.purple,
//                   ),
//                 ),
//                 Icon(Icons.shopping_bag, size: 30, color: Colors.black),
//               ],
//             ),
//             SizedBox(height: 16),
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'Search',
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.purple,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Introducing Air Max 2090',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Buy Now'),
//                       ),
//                     ],
//                   ),
//                   Image.network(
//                     'https://via.placeholder.com/100',
//                     width: 100,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _categoryIcon(Icons.category, 'Category'),
//                 _categoryIcon(Icons.compare, 'Compare'),
//                 _categoryIcon(Icons.local_offer, 'Offers'),
//                 _categoryIcon(Icons.event, 'Sales'),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'New Arrivals',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(onPressed: () {}, child: Text('View All')),
//               ],
//             ),
//             SizedBox(height: 8),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   _productCard('Nike Air Max 2090', '\$150'),
//                   _productCard('Nike React Vision', '\$140'),
//                   _productCard('Nike Air Zoom', '\$160'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _categoryIcon(IconData icon, String label) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 25,
//           backgroundColor: Colors.purple.withOpacity(0.2),
//           child: Icon(icon, color: Colors.purple),
//         ),
//         SizedBox(height: 4),
//         Text(label, style: TextStyle(fontSize: 12)),
//       ],
//     );
//   }

//   Widget _productCard(String title, String price) {
//     return Container(
//       width: 120,
//       margin: EdgeInsets.only(right: 16),
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Image.network('https://via.placeholder.com/80'),
//           SizedBox(height: 8),
//           Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//           Text(price, style: TextStyle(fontSize: 12, color: Colors.green)),
//         ],
//       ),
//     );
//   }
// }
