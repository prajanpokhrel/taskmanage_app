import 'package:flutter/material.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/features/profile/presentation/view/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // final appScreens = [
  //   const Homescreen(),
  //   const OffersScreen(),
  //   const MyloyaltyScreen(),
  //   const ProfileScreen(),
  // ];

  // int _selectedItem = 0;
  // // ignore: avoid_types_as_parameter_names
  // void _ontappedItem(int index) {
  //   setState(() {
  //     _selectedItem = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.red,
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
          activeIcon: Icon(Icons.percent),
          icon: Icon(Icons.percent, size: 28),
          label: "OFFERS",
        ),

        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person),
          icon: Icon(Icons.person, size: 28),
          label: "LOGIN",
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
          case 2:
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ),
            // );
            break;
          case 3:
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
