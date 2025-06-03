import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ДОДАНО
import 'package:mulite/screens/main/home_screen.dart';
import 'package:mulite/screens/main/playlist_screen.dart';
import 'package:mulite/screens/main/search_screen.dart';
import 'package:mulite/screens/main/settings_screen.dart';
import 'package:mulite/widgets/mini_player.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _pageController = PageController();
  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
    _loadLastIndex();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadLastIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('last_tab_index') ?? 0;
    setState(() {
      _currentIndex = savedIndex;
      _pageController.jumpToPage(savedIndex);
    });
  }

  Future<void> _saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('last_tab_index', _currentIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    _saveCurrentIndex(); // Збереження індексу
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Натисніть ще раз, щоб вийти'),
        duration: Duration(seconds: 2),
      ));
      return false;
    }
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C1C1C),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset('assets/images/mulite_minilogo.png',
                  width: 40, height: 40),
              const Text(
                'MuLite',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.gear,
                  color: Colors.white, size: 20),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.user,
                  color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: const [HomeScreen(), SearchScreen(), PLScreen()],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MiniPlayer(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFF1C1C1C),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house, color: Colors.white),
              activeIcon:
                  FaIcon(FontAwesomeIcons.house, color: Color(0xFF3C3C3C)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white),
              activeIcon: FaIcon(FontAwesomeIcons.magnifyingGlass,
                  color: Color(0xFF3C3C3C)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.play, color: Colors.white),
              activeIcon:
                  FaIcon(FontAwesomeIcons.play, color: Color(0xFF3C3C3C)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
