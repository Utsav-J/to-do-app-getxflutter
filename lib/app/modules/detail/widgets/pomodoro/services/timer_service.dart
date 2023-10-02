import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TimerService extends ChangeNotifier {
  Timer? timer;
  double currentDuration = 1500;
  double selectedTime = 1500;
  bool timerPlaying = false;
  int rounds = 0;
  String currentState = 'FOCUS';

  void startTimer() {
    timerPlaying = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration == 0) {
        handleNextRound();
      } else {
        // for every duration amount of time, this action will be done
        currentDuration -= 1;
        notifyListeners();
      }
    });
  }

  void pauseTimer() {
    timer!.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  void handleNextRound() {
    if (currentState == 'FOCUS') {
      currentState = "BREAK";
      currentDuration = 300;
      selectedTime = 300;
      rounds++;
    } else if (currentState == "BREAK") {
      currentState = 'FOCUS';
      currentDuration = 1500;
      selectedTime = 1500;
    } else if (currentState == 'FOCUS' && rounds == 3) {
      EasyLoading.showToast('Congrats on 3 rounds,\ntime for one last!');
      currentState = 'LASTBREAK';
      currentDuration = 420;
      selectedTime = 420;
      rounds = 4;
    } else if (currentState == 'LASTBREAK') {
      currentState = 'LASTFOCUS';
      currentDuration = 1500;
      selectedTime = 1500;
      rounds = 0;
    } else if (currentState == 'LASTFOCUS') {
      EasyLoading.showInfo("Congrats on this productive session");
      reset();
    }
    notifyListeners();
  }

  void reset() {
    timer!.cancel();
    currentState = 'FOCUS';
    currentDuration = selectedTime = 1500;
    rounds = 0;
    timerPlaying = false;
    notifyListeners();
  }

  void selectTime(double seconds) {
    selectedTime = seconds;
    currentDuration = seconds;
    notifyListeners();
  }
}
