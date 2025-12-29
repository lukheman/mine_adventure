import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/pixel_adventure.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class ControlsOverlay extends StatelessWidget {
  final PixelAdventure game;
  const ControlsOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Joystick kiri bawah
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width:
                  130.0, // Ubah ini untuk mengatur ukuran joystick (misal 120, 150, 200)
              height:
                  130.0, // Harus sama dengan width untuk bentuk lingkaran sempurna
              child: Joystick(
                mode: JoystickMode.horizontal,
                period: const Duration(milliseconds: 50),
                listener: (details) {
                  final double x = details.x;
                  if (x < -0.2) {
                    game.player.horizontalMovement = -1;
                  } else if (x > 0.2) {
                    game.player.horizontalMovement = 1;
                  } else {
                    game.player.horizontalMovement = 0;
                  }
                },
                // Parameter lain jika ada
              ),
            ),
          ),
        ),

        // Jump button kanan bawah (tetap sama)
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 100.0, // Ubah ini untuk ukuran tombol (misal 80, 100, 120)
              height:
                  100.0, // Harus sama dengan width agar tetap bulat sempurna
              child: FloatingActionButton(
                onPressed: () {
                  game.player.hasJumped = true;
                },
                backgroundColor:
                    Colors.blue, // Opsional: ubah warna agar lebih kelihatan
                child: const Icon(
                  Icons.arrow_upward,
                  size:
                      50.0, // Ukuran icon agar proporsional (opsional, bisa lebih besar)
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
