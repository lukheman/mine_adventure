import 'package:flutter/material.dart';
import 'package:pixel_adventure/main.dart';
import 'package:pixel_adventure/pixel_adventure.dart'; // Import game lu

class PauseMenuOverlay extends StatelessWidget {
  final PixelAdventure game;

  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300, // Ukuran popup, sesuaikan
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8), // Background semi-transparan
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Paused',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('pauseMenu'); // Hilangin popup
                game.resumeEngine(); // Lanjut game
              },
              child: const Text('Resume'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('pauseMenu'); // Hilangin popup
                // Balik ke main menu pake Navigator
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainMenu()),
                );
              },
              child: const Text('Back to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
