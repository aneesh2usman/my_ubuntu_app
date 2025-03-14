// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.teal, brightness: Brightness.dark),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int currentIndex =0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("flutter"),
//           centerTitle: true,
//           backgroundColor: Colors.teal,
//         ),
//         body:_buildBody(),
        
//         bottomNavigationBar: NavigationBar(
//           destinations: [
//             NavigationDestination(icon: Icon(Icons.home), label: "Home"),
//             NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
//           ],
//           onDestinationSelected: (int value) {
//             print(value);
//             setState(() {
//               currentIndex = value;
//             });
//           },
//           selectedIndex: currentIndex,
//         ),
//       );
//   }
//   Widget _buildBody() {
//     switch (currentIndex) {
//       case 0:
//         return const Center(child: Text('Home Page'));
//       case 1:
//         return const Center(child: Text('Profile Page'));
//       default:
//         return const Center(child: Text('Unknown Page'));
//     }
//   }
// }