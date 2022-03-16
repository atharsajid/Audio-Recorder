import 'package:flutter/material.dart';
import 'package:recording/Audio%20Recorder/audio_player.dart';
import 'package:recording/Audio%20Recorder/timer_controller.dart';
import 'Audio Recorder/controller.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final timecontroller = TimeController();
  SoundRecorder recorder = SoundRecorder();
  final audioPlayer = SoundPlyer();

  @override
  void initState() {
    super.initState();
    recorder.init();
    audioPlayer.init();
  }

  @override
  void dispose() {

    recorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/1.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
              width: double.infinity,
            ),
            StartTimer(
              controller: timecontroller,
            ),
            const SizedBox(
              height: 15,
            ),
            startRec(),
            const SizedBox(
              height: 10,
            ),
            startplaying()
          ],
        ),
      ),
    );
  }

  Widget startRec() {
    bool isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.mic : Icons.stop;
    String text = isRecording ? 'Start' : 'Stop';
    final primary = isRecording ? Colors.white : Colors.red;
    final onPrimary = isRecording ? Colors.red : Colors.white;

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(220, 50),
        backgroundColor: primary,
        side: const BorderSide(color: Colors.transparent, width: 2),
      ),
      onPressed: () async {
        recorder.togglerecording();
        final isRecording = recorder.isRecording;

        if (isRecording) {
          timecontroller.starttimer();
        } else {
          timecontroller.stoptimer();
        }
        setState(() {});
      },
      icon: Icon(
        icon,
        color: onPrimary,
        size: 28,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget startplaying() {
    final isPlaying = audioPlayer.isplaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    String text = isPlaying ? 'Stop' : 'Play';
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.white : Colors.red;

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(220, 50),
        backgroundColor: primary,
        side: const BorderSide(color: Colors.transparent, width: 2),
      ),
      onPressed: () async {
        await audioPlayer.toggleplayer(() {
          setState(() {});
        });
        setState(() {});
      },
      icon: Icon(
        icon,
        color: onPrimary,
        size: 28,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
