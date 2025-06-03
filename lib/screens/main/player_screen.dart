import 'package:flutter/material.dart';
import 'package:mulite/widgets/player_widget.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Закриття плеєру
        leading: IconButton(icon: const Icon(Icons.arrow_downward, color: Colors.white), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.download, color: Colors.white), onPressed: () {})],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/homepage_background.png', fit: BoxFit.cover)),
          SafeArea(child: PlayerWidget()),
        ],
      ),
    );
  }
}