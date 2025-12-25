// Kode lengkap untuk main.dart yang diperbarui
// Ini termasuk menu dengan background gambar, tombol dari aset, pemilihan karakter dengan preview sprite,
// dan dialog pengaturan untuk toggle sounds/controls.

import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String selectedCharacter = 'Mask Dude'; // Default
  bool showControls = false; // Default dari game
  bool playSounds = true; // Default dari game
  double soundVolume = 1.0; // Default dari game

  final List<Map<String, String>> characters = [
    {
      'name': 'Mask Dude',
      'preview': 'assets/images/Main Characters/Mask Dude/Idle (32x32).png',
    },
    {
      'name': 'Ninja Frog',
      'preview': 'assets/images/Main Characters/Ninja Frog/Idle (32x32).png',
    },
    {
      'name': 'Pink Man',
      'preview': 'assets/images/Main Characters/Pink Man/Idle (32x32).png',
    },
    {
      'name': 'Virtual Guy',
      'preview': 'assets/images/Main Characters/Virtual Guy/Idle (32x32).png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Background/Blue.png',
            ), // Gunakan background dari aset (ganti jika ingin yang lain seperti Purple.png)
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol Play
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: kDebugMode
                            ? PixelAdventure(character: selectedCharacter)
                            : PixelAdventure(character: selectedCharacter),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/Menu/Buttons/Play.png',
                  width: 150, // Ukuran tombol, sesuaikan
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Pengaturan
              GestureDetector(
                onTap: () => _showSettingsDialog(context),
                child: Image.asset(
                  'assets/images/Menu/Buttons/Settings.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 40),

              // Pemilihan Karakter
              const Text(
                'Pilih Karakter:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final char = characters[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCharacter = char['name']!;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedCharacter == char['name']
                                      ? Colors.yellow
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: Image.asset(
                                char['preview']!,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              char['name']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: selectedCharacter == char['name']
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pengaturan'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Tampilkan Kontrol'),
                    value: showControls,
                    onChanged: (value) {
                      setDialogState(() => showControls = value);
                      setState(
                        () => showControls = value,
                      ); // Update state utama
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Putar Suara'),
                    value: playSounds,
                    onChanged: (value) {
                      setDialogState(() => playSounds = value);
                      setState(() => playSounds = value);
                    },
                  ),
                  const Text('Volume Suara'),
                  Slider(
                    value: soundVolume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (value) {
                      setDialogState(() => soundVolume = value);
                      setState(() => soundVolume = value);
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
