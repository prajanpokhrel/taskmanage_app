import 'package:flutter/material.dart';

import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/features/profile/presentation/view/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      type: BottomNavigationBarType.fixed,

      backgroundColor: const Color.fromARGB(255, 73, 72, 72),
      unselectedItemColor: const Color.fromARGB(255, 177, 174, 174),
      selectedItemColor: Colors.white,
      showSelectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home_sharp),
          icon: Icon(Icons.home_sharp, size: 28),
          label: "HOME",
        ),

        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person),
          icon: Icon(Icons.person, size: 28),
          label: "Profile",
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
        }
      },
    );
  }
}
