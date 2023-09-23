import 'package:flutter/material.dart';
import 'firebase_list_screen.dart';
import 'api_list_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0; // Current index for BottomNavigationBar

  final List<Widget> _pages = [
    const ApiListScreen(),
    const FirebaseListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Movies',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list), // Replace with your first icon
            label: 'API Product List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp), // Replace with your second icon
            label: 'Firebase Product List',
          ),
        ],
      ),
    );
  }
}
