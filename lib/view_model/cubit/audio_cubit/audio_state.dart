abstract class AudioState{}

class AudioInitState extends AudioState{}

class AudioUrlLoadingState extends AudioState{}
class AudioUrlSuccessState extends AudioState{}

class AudioPlayLoadingState extends AudioState{}
class AudioPlaySuccessState extends AudioState{}

class AudioPauseLoadingState extends AudioState{}
class AudioPauseSuccessState extends AudioState{}

class AudioStopLoadingState extends AudioState{}
class AudioStopSuccessState extends AudioState{}

class UpdateAudioLoadingState extends AudioState{}