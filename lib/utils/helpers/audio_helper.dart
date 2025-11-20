import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_app/utils/helpers/file_helper.dart';

class AudioModel extends Equatable {
  final String title;
  final String assetPath;  // assets/audio/xxx.mp3 (để load UI)
  final String playPath;   // audio/xxx.mp3 (play)
  final String fileName;   // xxx.mp3

  const AudioModel({
    required this.title,
    required this.assetPath,
    required this.playPath,
    required this.fileName,
  });

  factory AudioModel.fromAsset(String assetPath) {
    // assetPath: assets/audio/xxx.mp3
    final fileName = assetPath.split('/').last;        // xxx.mp3
    final title = fileName.replaceAll(".mp3", "");     // xxx
    final playPath = assetPath.replaceFirst("assets/", ""); // audio/xxx.mp3

    return AudioModel(
      title: title,
      assetPath: assetPath,
      playPath: playPath,
      fileName: fileName,
    );
  }
  
  @override
  List<Object?> get props => [title, assetPath, playPath, fileName];
}


class AudioHelper {
  static final AudioHelper _instance = AudioHelper._internal();
  AudioHelper._internal();
  factory AudioHelper() => _instance;

  final player = AudioPlayer();
  final List<AudioModel> _audios = [];

  Future<void> init() async {
    final files = await FileHelper.getAllAssetFiles("assets/audio");

    _audios.clear();
    _audios.addAll(files.map((path) => AudioModel.fromAsset(path)));
  }

  /// Lấy danh sách audio
  List<AudioModel> get audios => _audios;

  /// Play từ AudioModel
  Future<void> play({
    required AudioModel audio,
    Duration? duration,
    bool loop = false,
  }) async {
    await player.stop();

    // set loop
    await player.setReleaseMode(
      loop ? ReleaseMode.loop : ReleaseMode.stop,
    );

    await player.play(
      AssetSource(audio.playPath),
    );

    if (duration != null) {
      Future.delayed(duration, () {
        player.stop();
      });
    }
  }



  /// Các controls khác
  Future<void> pause() => player.pause();
  Future<void> resume() => player.resume();
  Future<void> stop() => player.stop();
  Future<void> setVolume(double v) => player.setVolume(v);
}
