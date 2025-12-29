import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/main_menu_screen.dart';
import 'package:pixel_adventure/pixel_adventure.dart'; // Import game mu

class PauseMenuOverlay extends StatelessWidget {
  final PixelAdventure game;
  const PauseMenuOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300, // Ukuran popup, sesuaikan kalo mau
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
                // Balik ke main menu pake Navigator, pushAndRemoveUntil biar clean stack
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainMenuScreen()),
                  (route) => false,
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
