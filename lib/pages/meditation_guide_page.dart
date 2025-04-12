import 'package:calco/style/colors/calco_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/audio_provider.dart';
import '../static/navigation_route.dart';
import '../widgets/custom_button.dart';

class MeditationGuidePage extends StatefulWidget {
  const MeditationGuidePage({super.key});

  @override
  State<MeditationGuidePage> createState() => _MeditationGuidePageState();
}

class _MeditationGuidePageState extends State<MeditationGuidePage> {
  @override
  void initState() {
    super.initState();

    // Autoplay audio ketika masuk halaman
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final audioProvider = Provider.of<AudioProvider>(context, listen: false);
      audioProvider.playAudio('sounds/sound_relax.mp3');
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CalcoColors.blueBackground.color,
      body: Stack(
        children: [
          // Ombak di bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/image_wave_bg.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Konten lainnya di atas ombak
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Image.asset(
                  "assets/images/images_dolphin.png",
                  width: 240,
                ),
              ),
              //todo: ada spectrum audio/progress audio yang terputar dari file sounds di folder assets
              Consumer<AudioProvider>(
                builder: (context, audioProvider, child) {
                  final position = audioProvider.currentPosition;
                  final duration = audioProvider.totalDuration;

                  // Handle biar gak error saat durasi masih 0
                  final progress = duration.inMilliseconds > 0
                      ? position.inMilliseconds / duration.inMilliseconds
                      : 0.0;

                  return Column(
                    children: [
                      Slider(
                        value: progress.clamp(0.0, 1.0),
                        onChanged: (value) {
                          final newPosition = Duration(
                            milliseconds:
                                (duration.inMilliseconds * value).toInt(),
                          );
                          audioProvider.seekAudio(newPosition);
                        },
                      ),
                      Text(
                        "${_formatDuration(position)} / ${_formatDuration(duration)}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                title: "Selesai",
                color: CalcoColors.primaryBlue.color,
                onPressed: () {
                  final audioProvider =
                      Provider.of<AudioProvider>(context, listen: false);

                  audioProvider.stopAudio();
                  Navigator.pushNamed(
                      context, NavigationRoute.meditationReviewRoute.name);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
