// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String userName = "Loading...";
//   String userEmail = "Loading...";

//   @override
//   void initState() {
//     super.initState();
//     _getUserDetails();
//   }

//   Future<void> _getUserDetails() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         if (userDoc.exists) {
//           setState(() {
//             userName = userDoc['username'] ?? "No Name";
//             userEmail = userDoc['email'] ?? "No Email";
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home Page")),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(userName),
//               accountEmail: Text(userEmail),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text("Logout"),
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "👤 Name: $userName",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "📧 Email: $userEmail",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//               child: Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
