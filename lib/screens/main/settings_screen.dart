import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mulite/widgets/mini_player.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = true;
  int selectedLanguageIndex = 0;
  final List<String> languages = const ['УКР', 'ENG'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/mulite_minilogo.png', width: 40, height: 40),
            const Text('MuLite', style: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          IconButton(icon: const FaIcon(FontAwesomeIcons.gear, color: Colors.white, size: 20), onPressed: () {}),
          IconButton(icon: const FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 20), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/homepage_background.png'), fit: BoxFit.cover, opacity: 0.5),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SettingsItem(
                    icon: FontAwesomeIcons.adjust,
                    title: 'Тема застосунуку',
                    control: Switch(
                      value: isDarkTheme,
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.grey,
                      onChanged: (value) => setState(() => isDarkTheme = value),
                    ),
                  ),
                  SettingsItem(
                    icon: FontAwesomeIcons.globe,
                    title: 'Мова застосунуку',
                    control: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: languages
                          .asMap()
                          .entries
                          .map((entry) => LanguageButton(
                                language: entry.value,
                                isSelected: entry.key == selectedLanguageIndex,
                                onTap: () => setState(() => selectedLanguageIndex = entry.key),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageButton({required this.language, required this.isSelected, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade700 : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
          child: Text(language),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget control;

  const SettingsItem({required this.icon, required this.title, required this.control, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Row(
        children: [
          FaIcon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 16)),
          const Spacer(),
          control,
        ],
      ),
    );
  }
}