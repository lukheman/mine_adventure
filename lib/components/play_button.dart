import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class PlayButton extends SpriteComponent
    with TapCallbacks, HasGameReference<PixelAdventure> {
  PlayButton({super.position, super.size});

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache('Menu/Buttons/Play.png'),
    ); // Ganti gambar kalo perlu, misal jadi pause icon
    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    game.pauseEngine(); // Pause game dulu
    game.overlays.add('pauseMenu'); // Tampilin popup overlay
  }
}
