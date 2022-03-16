import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

const pathToReadAudio = 'audio_example.aac';

class SoundPlyer {
  FlutterSoundPlayer? _audioplayer;
  bool get isplaying => _audioplayer!.isPlaying;
  Future init() async {
    _audioplayer = FlutterSoundPlayer();
    await _audioplayer!.openAudioSession();
  }

  Future dispose() async {
    _audioplayer!.closeAudioSession();
    _audioplayer = null;
  }

  Future _play(VoidCallback whenfinished) async {
    await _audioplayer!
        .startPlayer(fromURI: pathToReadAudio, whenFinished: whenfinished);
  }

  Future _stop() async {
    await _audioplayer!.stopPlayer();
  }

  Future toggleplayer(VoidCallback whenfinished) async {
    if (_audioplayer!.isStopped) {
      await _play(whenfinished);
    } else {
      await _stop();
    }
  }
}
