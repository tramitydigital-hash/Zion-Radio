import 'package:just_audio/just_audio.dart';

class RadioService {
  final AudioPlayer player = AudioPlayer();

  Future<void> initialize() async {
    try {
      await player.setAutomaticallyWaitsToMinimizeStalling(false);
    } catch (e) {
      print("INIT ERROR: $e");
    }
  }

  Future<void> play(String url) async {
    try {
      await player.stop();

      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          headers: {
            "User-Agent": "Mozilla/5.0",
            "Accept": "*/*",
            "Icy-MetaData": "1",
          },
        ),
      );

      await player.play();

    } catch (e) {
      print("PLAY ERROR: $e");
    }
  }

  Future<void> pause() async {
    try {
      await player.pause();
    } catch (e) {
      print("PAUSE ERROR: $e");
    }
  }

  Future<void> stop() async {
    try {
      await player.stop();
    } catch (e) {
      print("STOP ERROR: $e");
    }
  }

  Future<void> dispose() async {
    try {
      await player.dispose();
    } catch (e) {
      print("DISPOSE ERROR: $e");
    }
  }
}