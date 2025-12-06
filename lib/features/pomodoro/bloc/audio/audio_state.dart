part of 'audio_bloc.dart';

final class AudioState extends Equatable {
  final List<AudioModel> audios;
  final AudioModel? selectedAudio;

  const AudioState({
    this.audios =  const [], 
    this.selectedAudio, 
  });

  AudioState copyWith({
    List<AudioModel>? audios,
    AudioModel? selectedAudio
  }) {
    return AudioState(
      audios: audios ?? this.audios,
      selectedAudio: selectedAudio ?? this.selectedAudio
    );
  }
  
  @override
  List<Object?> get props => [selectedAudio, audios];
}
