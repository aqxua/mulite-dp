import 'package:flutter/material.dart';
import 'package:mulite/models/track_model.dart';

class MusicCard extends StatelessWidget {
  final Track track;
  final VoidCallback? onTap;

  const MusicCard({required this.track, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          color: const Color(0xFF1C1C1C),
          child: Stack(
            children: [
              Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(track.image, fit: BoxFit.cover))),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(track.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(track.artist, style: const TextStyle(fontSize: 14, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}