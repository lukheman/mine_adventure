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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String selectedCharacter = 'Mask Dude';
  bool showControls = false;
  bool playSounds = true;
  double soundVolume = 1.0;

  final List<Map<String, String>> characters = [
    {
      'name': 'Mask Dude',
      'preview': 'assets/images/Main Characters/Mask Dude/preview.png',
    },
    {
      'name': 'Ninja Frog',
      'preview': 'assets/images/Main Characters/Ninja Frog/preview.png',
    },
    {
      'name': 'Pink Man',
      'preview': 'assets/images/Main Characters/Pink Man/preview.png',
    },
    {
      'name': 'Virtual Guy',
      'preview': 'assets/images/Main Characters/Virtual Guy/preview.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ===== BACKGROUND STATIS FULL SCREEN =====
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Cave/background.png'),
                  fit: BoxFit.cover, // FULL layar, tidak terputus
                ),
              ),
            ),
          ),

          // ===== OPTIONAL OVERLAY (biar teks jelas) =====
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // ===== KONTEN UTAMA =====
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tombol kiri
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameWidget(
                              game: kDebugMode
                                  ? PixelAdventure(character: selectedCharacter)
                                  : PixelAdventure(
                                      character: selectedCharacter,
                                    ),
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.brown[300]!.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Mulai',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => _showSettingsDialog(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.brown[300]!.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Pengaturan',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== PILIH KARAKTER =====
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pilih Karakter:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: characters.map((char) {
                          final isSelected = selectedCharacter == char['name'];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCharacter = char['name']!;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.yellow
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: Image.asset(
                                      char['preview']!,
                                      width: 90,
                                      height: 90,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    char['name']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Pengaturan'),
          content: StatefulBuilder(
            builder: (_, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Tampilkan Kontrol'),
                    value: showControls,
                    onChanged: (value) {
                      setDialogState(() => showControls = value);
                      setState(() => showControls = value);
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
                    min: 0,
                    max: 1,
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
