
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart';
import 'package:rafeek_eldarb/view_model/cubit/audio_cubit/audio_state.dart';
import 'package:rafeek_eldarb/view_model/cubit/quran_cubit/quran_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_cubit.dart';
import 'package:rafeek_eldarb/view_model/cubit/settings_cubit/settings_state.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_helper.dart';
import 'package:rafeek_eldarb/view_model/data/local/shared_keys.dart';
import 'package:rafeek_eldarb/view_model/utils/app_colors.dart';


import '../../main.dart';
import '../../view_model/cubit/audio_cubit/audio_cubit.dart';
import '../../view_model/utils/audio_handler.dart';

class AudioSurahScreen extends StatefulWidget {
  final Map surahModel;
  const AudioSurahScreen({required this.surahModel, super.key});

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //AudioCubit.get(context).player.positionStream.listen((position) {
    (audioHandler as AudioPlayerHandler).getPlayer().positionStream.listen((position) {
      if(mounted)
        {
          setState(() {
            if(AudioCubit.get(context).surahIndex == widget.surahModel["surahNumber"]){
              AudioCubit.get(context).position = position; ///set position to current audio time
            }

          });
        }
    });
    AudioCubit.get(context).startListening();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60.r),
                        bottomLeft: Radius.circular(60.r)),
                  ),
                  child: Image.asset(
                    'assets/images/mosque.jpg',
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_rounded,color: Colors.black,size: 80.sp,)),
              ],
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height/1.2,
                padding: EdgeInsetsDirectional.all(30.sp),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  //borderRadius: BorderRadius.only(topRight: Radius.circular(60.r),topLeft: Radius.circular(60.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'سورة ${widget.surahModel["surahNameArabic"]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('آياتها ${QuranCubit.get(context).convertToArabicNumbers(widget.surahModel["totalAyah"].toString())}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الشيخ مشاري راشد العفاسي',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.headphones_rounded,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Slider(
                        min: 0,
                        max: AudioCubit.get(context).duration.inSeconds.toDouble(),
                        value:AudioCubit.get(context).isPlaying(widget.surahModel["surahNumber"])? AudioCubit.get(context).position.inSeconds.toDouble().clamp(0,
                            AudioCubit.get(context).duration.inSeconds.toDouble()):0,
                        onChanged: (value) {
                         // AudioCubit.get(context).player.seek(Duration(seconds: value.toInt()));
                          (audioHandler as AudioPlayerHandler).getPlayer().seek(Duration(seconds: value.toInt()));
                        },
                        thumbColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey[600],
                      ),
                    ),
                    // Time indicators
                    Visibility(visible: AudioCubit.get(context).surahIndex == widget.surahModel["surahNumber"],
                      replacement: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("00:00:00",style: TextStyle(
                                color: Colors.blue[900]
                            ),), // Current position
                            Text("00:00:00"), // Total duration
                          ],
                        ),
                      ),
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AudioCubit.get(context).formatDuration(AudioCubit.get(context).position),style: TextStyle(
                              color: Colors.blue[900]
                          ),), // Current position
                          Text(AudioCubit.get(context).formatDuration(AudioCubit.get(context).duration)), // Total duration
                        ],
                      ),
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              AudioCubit.get(context).audioStop(
                                  getAudioURLBySurah(
                                      widget.surahModel["surahNumber"]),
                                  widget.surahModel["surahNumber"]);
                            },
                            icon: Icon(
                              Icons.stop,
                              color: Colors.red[700],size: 80.r,
                            )),
                        BlocConsumer<AudioCubit, AudioState>(
                          listener: (context, state) {
                           if(state is AudioPLayErrorState)
                             {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: SizedBox(height: 100.h,
                                 child: Text('حدثت مشكلة يرجي الحاولة لاحقا',style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 50.sp,
                                     fontWeight: FontWeight.w600
                                 ),
                                   textAlign: TextAlign.center,),),
                                 duration: Duration(seconds: 2),padding: EdgeInsetsDirectional.all(0),));
                             }
                          },
                          builder: (context, state) {
                            var cubit = AudioCubit.get(context);
                            return IconButton(
                                onPressed: () {
                                  if(AudioCubit.get(context).isConnected == false && cubit.isPause == true){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: SizedBox(height: 100.h,
                                    child: Text('لا يوجد إتصال بالإنترنت',style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                      textAlign: TextAlign.center,),),
                                      duration: Duration(seconds: 2),padding: EdgeInsetsDirectional.all(0),));
                                  }
                                  if(!cubit.isPlaying(widget.surahModel["surahNumber"])){
                                   ///When enter new screen and press play
                                    AudioCubit.get(context).audioPlay(getAudioURLBySurah(
                                        widget.surahModel["surahNumber"]),
                                        widget.surahModel["surahNumber"]);
                                    AudioCubit.get(context).updateLoading();
                                  }
                                  else if (cubit.isPause) {
                                    ///when press play after pause 
                                    AudioCubit.get(context).audioPlay(getAudioURLBySurah(
                                        widget.surahModel["surahNumber"]),
                                        widget.surahModel["surahNumber"]);
                                  } else {
                                    ///when press pause
                                    AudioCubit.get(context).audioResume(
                                        widget.surahModel["surahNumber"]);
                                  }
                                },
                                icon: StreamBuilder<bool>(
                                  //stream: cubit.player.playingStream,
                                  stream: (audioHandler as AudioPlayerHandler).getPlayer().playingStream,
                                  builder: (context, snapshot) {
                                    if(cubit.position.inSeconds.toDouble() == cubit.duration.inSeconds.toDouble()){
                                      cubit.audioStop(getAudioURLBySurah(widget.surahModel["surahNumber"]), widget.surahModel["surahNumber"]); //return surah index -> -1 to can start again
                                    }
                                    return cubit.isLoading == false?Icon(
                                        (snapshot.data == false || !cubit.isPlaying(widget.surahModel["surahNumber"]) || cubit.surahIndex == -1)
                                          ? Icons.play_arrow_rounded
                                          : Icons.pause,size: 100.r,
                                      color: Colors.blue[900],
                                    ):SizedBox(height: 50.h,width: 50.w,
                                        child: CircularProgressIndicator(color: Colors.blue[900],));
                                  },

                                ));
                          },
                        ),
                        BlocBuilder<SettingsCubit,SettingsState>(
                          builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              SettingsCubit.get(context).saveSurahAudio(widget.surahModel['surahNumber']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: SizedBox(height: 80.h,
                                  child: Text('تم حفظ السورة',style: TextStyle(
                                    color: Colors.white,
                                  ),textAlign: TextAlign.center,),
                                ),duration: Duration(seconds: 2),
                                  backgroundColor: Colors.blueGrey[700],
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  padding: EdgeInsetsDirectional.all(0),),
                              );
                            },
                            icon: SettingsCubit.get(context).isAudioSaved &&
                                (SharedHelper.get(key: SharedKeys.audioNumber) == widget.surahModel['surahNumber'])?
                            Icon(
                              Icons.bookmark_rounded,
                              color: Colors.blueGrey[900],size: 80.r
                            ):Icon(
                              Icons.bookmark_border_rounded,
                              color: AppColor.black,size: 80.r
                            ),
                          );
                        },)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
