import 'package:audioplayers/audioplayers.dart';
import 'package:calco/services/audio_service.dart';
import 'package:flutter/widgets.dart';

class AudioProvider extends ChangeNotifier {
  final AudioService _audioService;

  AudioProvider(this._audioService) {
    _init();
  }

  String? _currentAudio;
  String? get currentAudio => _currentAudio;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;

  bool get isPlaying => _currentAudio != null;

  void _init() {
    _audioService.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioService.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    _audioService.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        notifyListeners();
      }
    });
  }

  Future<void> playAudio(String assetPath) async {
    if (_currentAudio == assetPath) {
      await _audioService.stop();
    }

    _currentAudio = assetPath;
    await _audioService.play(assetPath);
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _audioService.stop();
    _currentAudio = null;
    notifyListeners();
  }

  Future<void> seekAudio(Duration position) async {
    await _audioService.seek(position);
    _currentPosition = position;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
