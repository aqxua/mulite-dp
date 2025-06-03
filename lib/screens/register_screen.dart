import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulite/screens/login_screen.dart';
import '../widgets/custom_page_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover))),
          Positioned(top: 50, left: 60, child: Image.asset('assets/images/mulite_logo.png', width: 300, height: 300)),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ласкаво просимо!\nСтворіть свій обліковий запис',
                      textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  _buildTextField(_usernameController, 'Ім\'я користувача', FontAwesomeIcons.user),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, 'Електронна пошта', FontAwesomeIcons.envelope),
                  const SizedBox(height: 20),
                  _buildTextField(_passwordController, 'Пароль', FontAwesomeIcons.lock, obscureText: true),
                  const SizedBox(height: 20),
                  _buildTextField(_confirmPasswordController, 'Підтвердження пароля', FontAwesomeIcons.lock, obscureText: true),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                    child: Text('Зареєструватися', style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, CustomPageRoute(page: const LoginScreen())),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1C1C1C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                    child: Text('Увійти', style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          prefixIcon: Icon(icon, color: Colors.white60, size: 20),
        ),
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}