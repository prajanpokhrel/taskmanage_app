import 'package:flutter/material.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class AnimatedBottomBar extends StatefulWidget {
  const AnimatedBottomBar({super.key});

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      elevation: 10.0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.search, "Search", 1),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(Icons.calendar_month, "Calendar", 2),
            _buildNavItem(Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 250),
        tween: ColorTween(
          begin: Colors.grey,
          end: isActive ? AppconstColor.PrimaryColor : Colors.grey,
        ),
        builder: (context, Color? color, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                tween: Tween<double>(begin: 24, end: isActive ? 28 : 24),
                builder: (context, size, _) {
                  return Icon(icon, color: color, size: size);
                },
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  color: color,
                  fontSize: isActive ? 13 : 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
                child: Text(label),
              ),
            ],
          );
        },
      ),
    );
  }
}
