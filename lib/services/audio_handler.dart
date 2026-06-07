import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class RadioAudioHandler extends BaseAudioHandler {
  final AudioPlayer player = AudioPlayer();

  Future<void> startRadio(String url) async {

    mediaItem.add(
      const MediaItem(
        id: "zion_radio",
        title: "Zion Radio",
        artist: "En Vivo",
        album: "Zion Radio",
      ),
    );

    await player.setUrl(url);
    await player.play();
  }

  @override
  Future<void> play() async {
    await player.play();
  }

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> stop() async {
    await player.stop();
  }
}
