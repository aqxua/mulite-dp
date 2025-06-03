import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/homepage_background.png',
            fit: BoxFit.cover,
          ),
        ),
        // Add search-specific content here as needed
      ],
    );
  }
}