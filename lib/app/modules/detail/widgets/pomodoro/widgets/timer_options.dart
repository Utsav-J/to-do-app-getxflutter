import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/timer_service.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/utils-times.dart';

class TimerOptions extends StatelessWidget {
  // const TimerOptions({super.key});
  double selectedTime = 1500;
  @override
  Widget build(context) {
    final provider = Provider.of<TimerService>(context);
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 155),
      scrollDirection: Axis.horizontal,
      child: AbsorbPointer(
        absorbing: provider.timerPlaying,
        child: Row(
          children: selectableTimes
              .map(
                (e) => Opacity(
                  opacity: provider.timerPlaying ? 0.2 : 1,
                  child: GestureDetector(
                    onTap: () => provider.selectTime(double.parse(e)),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
                      height: 15.0.wp,
                      width: 20.0.wp,
                      decoration: int.parse(e) == provider.selectedTime
                          ? BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              border: Border.all(
                                  width: 3,
                                  color: Colors.white.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(5))
                          : BoxDecoration(
                              border: Border.all(
                                  width: 3,
                                  color: Colors.white.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          (int.parse(e) ~/ 60).toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: int.parse(e) == provider.selectedTime
                                      ? Colors.black
                                      : Colors.white.withOpacity(0.3)),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
