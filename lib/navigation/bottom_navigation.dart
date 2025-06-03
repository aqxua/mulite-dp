import 'package:flutter/material.dart';
import '../screens/main/home_screen.dart';

// Ініціалізація
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // Індекс вибраного екрану
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[HomeScreen()];
  // Обробник натискання на елемент навігації
  void _onItemTapped(int index) {
    if (index < _screens.length) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: ''),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}