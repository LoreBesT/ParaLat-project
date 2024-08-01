import 'package:assets_audio_player/assets_audio_player.dart';

class Music {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  void togglePlayPause({required String audioPath}) {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.open(
        Audio(audioPath),
        autoStart: true,
        showNotification: true,
      );
    }
    _isPlaying = !_isPlaying;
  }
}

