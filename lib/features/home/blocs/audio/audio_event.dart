part of 'audio_bloc.dart';

sealed class AudioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AudioEventOnInitial extends AudioEvent {}

final class AudioEventOnChangeSelectedAudio extends AudioEvent {
  final AudioModel audio;

  AudioEventOnChangeSelectedAudio({required this.audio});

  @override
  List<Object> get props => [audio];
}


final class AudioEventOnPlayAudio extends AudioEvent {}

final class AudioEventOnStopAudio extends AudioEvent {}

final class AudioEventOnPauseAudio extends AudioEvent {}

final class AudioEventOnResumeAudio extends AudioEvent {}


