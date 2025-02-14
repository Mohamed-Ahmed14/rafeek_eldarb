
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState>{

  AudioCubit() : super(AudioInitState());

  static AudioCubit get(context) =>BlocProvider.of<AudioCubit>(context);



  final player = AudioPlayer();
  int surahIndex = -1;
  bool isPause = true;
  //for slider indicating

  Duration duration = Duration.zero; // Total duration of the audio
  Duration position = Duration.zero; // Current position of the audio

void clearAudioSurah(){
  surahIndex = -1;
  isPause = true;
}

  Future<void> audioPlay(String url,int index) async{
    emit(AudioPlayLoadingState());
    if(surahIndex != index){
      await player.setUrl(url);
      duration = player.duration ?? Duration.zero;
      surahIndex = index;
      emit(AudioUrlSuccessState());
    }
    isPause = false;
    await player.play();
    emit(AudioPlaySuccessState());
  }



  Future<void> audioResume(int index) async{
    emit(AudioPauseLoadingState());
    if(index == surahIndex){
      isPause = true;
      await player.pause();
    }
    emit(AudioPauseSuccessState());
  }

  Future<void> audioStop(String url,int index) async{
    emit(AudioStopLoadingState());
    if(index == surahIndex)
      {
        await player.stop();
        isPause = true;
        surahIndex = -1;
      }
    emit(AudioStopSuccessState());
  }
bool isPlaying(int index){

    if(index == surahIndex){
      return true;
    }
    return false;
}

  //Audio Player with Slider


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

//Check internet connectivity

  bool isConnected = false;
  void startListening() {
    Connectivity().onConnectivityChanged.listen((result) {
      for(var i in result){
        if (i == ConnectivityResult.none) {
          isConnected = false;
        } else {
          isConnected = true;
        }
      }
    });
  }

  bool isLoading = false;
  void updateLoading() async{
      isLoading = true;
      await Future.delayed(Duration(seconds: 5),() => isLoading = false,);
      emit(UpdateAudioLoadingState());
  }

}