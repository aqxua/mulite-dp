import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulite/screens/login_screen.dart';
import 'package:mulite/screens/register_screen.dart';
import 'package:mulite/widgets/custom_page_route.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoOpacity;
  late Animation<double> _welcomeOpacity;
  late Animation<double> _buttonsOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0, 0.4, curve: Curves.easeIn)));
    _welcomeOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.7, curve: Curves.easeIn)));
    _buttonsOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1, curve: Curves.easeIn)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover))),
          Positioned(
            top: 50,
            left: 60,
            child: FadeTransition(opacity: _logoOpacity, child: Image.asset('assets/images/mulite_logo.png', width: 300, height: 300)),
          ),
          Positioned(
            top: 300,
            left: 85,
            child: FadeTransition(
              opacity: _welcomeOpacity,
              child: Text('Ласкаво просимо!', style: GoogleFonts.montserrat(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            bottom: 50,
            left: (screenWidth - 200) / 2,
            child: FadeTransition(
              opacity: _buttonsOpacity,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, CustomPageRoute(page: const LoginScreen())),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      child: Text('Увійти', style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, CustomPageRoute(page: const RegisterScreen())),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1C1C1C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      child: Text('Реєстрація', style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}