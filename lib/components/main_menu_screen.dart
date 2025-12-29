// lib/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/game_play_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  String selectedCharacter = 'Mask Dude';
  bool showControls = true;
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
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Cave/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GamePlayScreen(
                              character: selectedCharacter,
                              showControls: showControls,
                              playSounds: playSounds,
                              soundVolume: soundVolume,
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
                            onTap: () => setState(
                              () => selectedCharacter = char['name']!,
                            ),
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
      builder: (_) => AlertDialog(
        title: const Text('Pengaturan'),
        content: StatefulBuilder(
          builder: (_, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Tampilkan Kontrol'),
                value: showControls,
                onChanged: (v) {
                  setDialogState(() => showControls = v);
                  setState(() => showControls = v);
                },
              ),
              SwitchListTile(
                title: const Text('Putar Suara'),
                value: playSounds,
                onChanged: (v) {
                  setDialogState(() => playSounds = v);
                  setState(() => playSounds = v);
                },
              ),
              const Text('Volume Suara'),
              Slider(
                value: soundVolume,
                min: 0,
                max: 1,
                onChanged: (v) {
                  setDialogState(() => soundVolume = v);
                  setState(() => soundVolume = v);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
