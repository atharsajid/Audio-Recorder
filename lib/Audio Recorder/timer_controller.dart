import 'dart:async';
import 'package:flutter/material.dart';

class TimeController extends ValueNotifier<bool> {
  TimeController({bool isPlaying = false}) : super(isPlaying);

  void starttimer() => value = true;
  void stoptimer() => value = false;
}

class StartTimer extends StatefulWidget {
  final TimeController controller;
  const StartTimer({Key? key, required this.controller}) : super(key: key);

  @override
  State<StartTimer> createState() => _StartTimerState();
}

class _StartTimerState extends State<StartTimer> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.value) {
        starttimer();
      } else {
        stoptimer();
      }
    });
  }

  void reset() {
    setState(() {
      duration = const Duration();
    });
  }

  void addtime() {
    const addsecond = 1;
    setState(() {
      final seconds = duration.inSeconds + addsecond;
      duration = Duration(seconds: seconds);
    });
  }

  void starttimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addtime());
  }

  void stoptimer() {
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildtime();
  }

  Widget buildtime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        builditem(
          seconds: hours,
          Header: "Hours",
        ),
        const SizedBox(
          width: 7,
        ),
        builditem(
          seconds: minutes,
          Header: "Minutes",
        ),
        const SizedBox(
          width: 7,
        ),
        builditem(
          seconds: seconds,
          Header: "Seconds",
        ),
      ],
    );
  }
}

class builditem extends StatelessWidget {
  const builditem({
    Key? key,
    required this.seconds,
    required this.Header,
  }) : super(key: key);

  final String seconds;
  final String Header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            seconds,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(Header,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
      ],
    );
  }
}
