import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/timer_service.dart';

class TimeController extends StatefulWidget {
  @override
  _TimeControllerState createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(context) {
    final provider = Provider.of<TimerService>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20.0.wp,
          height: 20.0.wp,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
          child: IconButton(
            icon: Icon(
              provider.timerPlaying
                  ? CupertinoIcons.pause_fill
                  : CupertinoIcons.play_fill,
            ),
            iconSize: 10.0.wp,
            onPressed: () {
              provider.timerPlaying
                  ? provider.pauseTimer()
                  : provider.startTimer();
            },
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        SizedBox(width: 4.0.wp),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
          height: 15.0.wp,
          width: 15.0.wp,
          child: Center(
            child: Text(
              "${provider.rounds}/4",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ),
      ],
    );
  }
}
