// lib/screens/game_play_screen.dart
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/game_end_overlay.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class GamePlayScreen extends StatelessWidget {
  final String character;
  final bool showControls;
  final bool playSounds;
  final double soundVolume;

  const GamePlayScreen({
    super.key,
    required this.character,
    this.showControls = false,
    this.playSounds = true,
    this.soundVolume = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final game = PixelAdventure(
      character: character,
      showControls: showControls,
      playSounds: playSounds,
      soundVolume: soundVolume,
    );

    return GameWidget.controlled(
      gameFactory: () => game,
      overlayBuilderMap: {
        'gameEnd': (context, game) =>
            GameEndOverlay(game: game as PixelAdventure),
      },
      initialActiveOverlays:
          const [], // kalo mau langsung pause menu bisa di sini
    );
  }
}
