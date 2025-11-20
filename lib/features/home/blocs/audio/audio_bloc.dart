import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_app/utils/const/global.dart';
import 'package:focus_app/utils/helpers/audio_helper.dart';
import 'package:focus_app/utils/storages/share_preference/share_preference_storage_abstract.dart';
import 'package:focus_app/utils/storages/share_preference/share_preference_storage_keys.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final SharePreferenceStorageAbstract _storage;
  final AudioHelper _audio;

  AudioBloc({
    required SharePreferenceStorageAbstract storage,
    required AudioHelper audio
  }) : 
    _storage = storage,
    _audio = audio,

    super(AudioState()) {
      on<AudioEventOnInitial>(_onInitial);
      on<AudioEventOnChangeSelectedAudio>(_onChangeSelectedAudio);
      on<AudioEventOnPlayAudio>(_onPlayAudio);
      on<AudioEventOnStopAudio>(_onStopAudio);
      on<AudioEventOnPauseAudio>(_onPauseAudio);
      on<AudioEventOnResumeAudio>(_onResumeAudio);
      on<AudioEventOnPlayAudioInBreakTime>(_onPlayAudioInBreakTime);
  }

  void _onInitial(AudioEventOnInitial event, Emitter emit) async {
    await _audio.init();
    final audios = _audio.audios;

    final audioPath = _storage.get(SharePreferenceStorageKeys.audio);
    print(audioPath);
    final selectedAudio = audioPath != null ? AudioModel.fromAsset(audioPath.toString()) : null;
    emit(state.copyWith(
      audios: audios,
      selectedAudio: selectedAudio
    ));

    print(state.toString());
  }

  void _onChangeSelectedAudio(AudioEventOnChangeSelectedAudio event, Emitter emit) async {
    await _storage.set(SharePreferenceStorageKeys.audio, event.audio.assetPath);
    final audioPath = _storage.get(SharePreferenceStorageKeys.audio);
    print(event.audio.toString());
    print(audioPath);

    emit(state.copyWith(
      selectedAudio: event.audio
    ));
  }

  void _onPlayAudio(AudioEventOnPlayAudio event, Emitter emit) async {
    AudioModel audioUsed;

    //- Không có audio nào trong asset
    if(state.audios.isEmpty) return;

    //- Chưa chọn audio mặc định => chạy audio đầu tiên
    if(state.selectedAudio == null) {
      audioUsed = state.audios.first;
    } else {
      audioUsed = state.selectedAudio!;
    }
    await _audio.play(audio: audioUsed, loop: true);
  }

  void _onPlayAudioInBreakTime(AudioEventOnPlayAudioInBreakTime event, Emitter emit) async {
    AudioModel audioBreakTime = AudioModel.fromAsset(Globals.assetPathInBreakTime);

    await _audio.play(audio: audioBreakTime, duration: Duration(
      seconds: Globals.notifyBreakTimeByAudioInSeconds
    ));
  }

  void _onStopAudio(AudioEventOnStopAudio event, Emitter emit) async {
    await _audio.stop();
  }

  void _onPauseAudio(AudioEventOnPauseAudio event, Emitter emit) async {
    await _audio.pause();
  }

  void _onResumeAudio(AudioEventOnResumeAudio event, Emitter emit) async {
    await _audio.resume();
  }
}
