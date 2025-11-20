import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
