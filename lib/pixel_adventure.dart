import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/controls_overlay.dart';
import 'package:pixel_adventure/components/game_end_overlay.dart';
import 'package:pixel_adventure/components/pause_menu_overlay.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  PixelAdventure({
    String character = 'Mask Dude',
    this.showControls = false,
    this.playSounds = true,
    this.soundVolume = 1.0,
  }) : player = Player(character: character);

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late CameraComponent cam;
  final Player player;
  bool showControls = false;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = [
    'Level-01',
    'Level-02',
    'Level-03',
    'Level-04',
    'Level-05',
    'Level-06',
    'Level-07',
    'Level-08',
    'Level-09',
  ];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    overlays.addEntry(
      'pauseMenu',
      (context, game) => PauseMenuOverlay(game: game as PixelAdventure),
    );
    overlays.addEntry(
      'gameEnd',
      (context, game) => GameEndOverlay(game: game as PixelAdventure),
    );
    overlays.addEntry(
      'controls',
      (context, game) => ControlsOverlay(game: game as PixelAdventure),
    );
    // load all images into cache
    await images.loadAllImages();
    loadLevel();
    if (showControls) {
      overlays.add('controls'); // Aktifkan overlay
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void loadNextLevel() {
    removeWhere(
      (component) => component is Level || component is CameraComponent,
    );
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      loadLevel();
    } else {
      // Game selesai → tampilkan overlay
      overlays.add('gameEnd');
      pauseEngine();
    }
  }

  void loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );
      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 360,
      );
      cam.viewfinder.anchor = Anchor.topLeft;
      addAll([cam, world]);
    });
  }
}
