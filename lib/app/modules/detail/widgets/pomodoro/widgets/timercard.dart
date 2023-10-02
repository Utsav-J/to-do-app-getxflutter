import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/timer_service.dart';
import 'package:to_do_list/app/modules/home/controller.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  TimerCard({super.key});
  @override
  Widget build(context) {
    final provider = Provider.of<TimerService>(context);
    final currSeconds = provider.currentDuration % 60;
    return Column(
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.0.wp,
              height: 50.0.wp,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  (provider.currentDuration ~/ 60).toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.lato(
                fontSize: 24.0.wp,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0.wp),
              width: 30.0.wp,
              height: 50.0.wp,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  currSeconds == 0
                      ? '${currSeconds.round()}0'
                      : currSeconds.round().toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
