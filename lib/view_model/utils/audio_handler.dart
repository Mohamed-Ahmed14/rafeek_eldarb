
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';


class AudioPlayerHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
 final  AudioPlayer _player = AudioPlayer();


  AudioPlayerHandler(){
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // Load the player.
   // player.setAudioSource(AudioSource.uri(Uri.parse(url)));
   //  player.setAudioSource(AudioSource.uri(Uri.parse(url)));
   //  print("objectddddddddddddddddd");
  }



  //   static Future<void> loadUrl(String url)async{
  //   //AudioPlayerHandler(url);
  //  // await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
  //   // Set the audio source using the dynamic URL.
  //   //await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
  //
  //     //await player.setAudioSource(); // Reset the audio source
  //     await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
  //
  // }
  @override
  Future<void> play() async{
      await _player.play();
  }

  @override
  Future<void> pause() async{
    await _player.pause();
  }


  @override
  Future<void> stop() async{

    await _player.stop();
    //await player.dispose();
  }

 // static Future<void> disposePlayer() async {
 //   if (_player != null) {
 //     print("Disposing existing AudioPlayer...");
 //     await _player!.dispose();
 //     _player = null;
 //   }
 // }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  AudioPlayer getPlayer()=> _player;

 Future<String> getImageFileFromAssets(String assetPath) async {
   final byteData = await rootBundle.load(assetPath);
   final file = File('${(await getTemporaryDirectory()).path}/mosque.jpg');
   await file.writeAsBytes(byteData.buffer.asUint8List());
   return file.path;
 }
 /// Function to set media item and update the queue
 Future<void> setMediaItem(String url, String title,int time) async {
   final filePath = await getImageFileFromAssets("assets/images/mosque.jpg"); // Convert asset to file
   final item = MediaItem(
     id: url,
     album: "El-Quran",
     title: title,
     artist: "    الشيخ مشاري راشد العفاسي              ",
     duration: Duration(milliseconds: time),
     artUri: Uri.file(filePath), // Thumbnail
   );
   mediaItem.add(item);
 }


  // Transform the playback state for background controls (lock screen)
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      playing: _player.playing,
      //processingState: AudioProcessingState.ready,
      controls: [
        MediaControl.play,
        MediaControl.pause,
        MediaControl.stop,
      ],
          // androidCompactActionIndices: const [0, 1, 2],
          processingState: const {
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
          queueIndex: event.currentIndex,
    );
  }
}
