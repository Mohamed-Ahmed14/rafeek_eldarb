
import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/main.dart';
import 'package:rafeek_eldarb/view_model/utils/audio_handler.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState>{

  AudioCubit() : super(AudioInitState());

  static AudioCubit get(context) =>BlocProvider.of<AudioCubit>(context);

  //This Part from main



  // Future<void> initAudioHandler()async{
  //   if(audioHandler != null){
  //     audioHandler = null;
  //   }
  //   audioHandler  = await AudioService.init(
  //     builder: () => AudioPlayerHandler(),
  //     config: const AudioServiceConfig(
  //       androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
  //       androidNotificationChannelName: 'Audio Playback',
  //       androidNotificationIcon: 'mipmap/icon_transparent', // Request focus
  //       androidNotificationOngoing: true,
  //     ),
  //   );
  // }
   //late AudioPlayerHandler audioHandler;
   //AudioPlayerHandler audioPlayerHandler = AudioPlayerHandler();



  //final player = AudioPlayer();
  int surahIndex = -1;
  bool isPause = true;
  //for slider indicating

  Duration duration = Duration.zero; // Total duration of the audio
  Duration position = Duration.zero; // Current position of the audio


  bool isLoading = false;
  Future<void> updateLoading() async{
    isLoading = true;
    //await Future.delayed(Duration(seconds: 3));
    emit(UpdateAudioLoadingState());
  }


  Future<void> audioPlay(String url,int index) async{
    if(audioHandler == null){
      await initAudioHandler();
    }
    emit(AudioPlayLoadingState());
    try{
      if(surahIndex != index){
        if((audioHandler as AudioPlayerHandler).getPlayer().playing){
          if(audioHandler == null)return;
          await audioHandler?.stop();
        }
        //await (audioHandler as AudioPlayerHandler).getPlayer().setUrl('22');
        await (audioHandler as AudioPlayerHandler).getPlayer().setUrl(
            "https://github.com/The-Quran-Project/Quran-Audio-Chapters/raw/refs/heads/main/Data/1/$index.mp3");
        duration =  ((audioHandler as AudioPlayerHandler).getPlayer().duration )??Duration.zero;
        await setItem(url,index);
        surahIndex = index;
        emit(AudioUrlSuccessState());
      }
      isPause = false;
      if(audioHandler == null)return;
      isLoading = false;
      await audioHandler?.play();
      emit(AudioPlaySuccessState());
    }catch(e){
      isLoading = false;
      emit(AudioPLayErrorState());
      rethrow;
    }
  }


  Future<void> setItem(String url,int index) async{
    await (audioHandler as AudioPlayerHandler).setMediaItem(
      "",
      "        ${getSurahNameArabic(index)}",
      duration.inMilliseconds,
    );

  }


  Future<void> audioResume(int index) async{
    emit(AudioPauseLoadingState());
    if(index == surahIndex){
      isPause = true;
      if(audioHandler == null)return;
      await audioHandler?.pause();
    }
    emit(AudioPauseSuccessState());
  }

  Future<void> audioStop(String url,int index) async{
    emit(AudioStopLoadingState());
    if(index == surahIndex)
      {
        if(audioHandler == null)return;
        await audioHandler?.stop();
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


  @override
  Future<void> close() async {
    await (audioHandler as AudioPlayerHandler).getPlayer().dispose();
    super.close();
  }
}