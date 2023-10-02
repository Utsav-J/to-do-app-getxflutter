// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/lists/doing_list.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/timer_service.dart';
import 'package:to_do_list/app/modules/home/controller.dart';

class TimerTaskProgress extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  TimerTaskProgress({super.key});
  @override
  Widget build(context) {
    final provider = Provider.of<TimerService>(context);
    return AbsorbPointer(
      absorbing: provider.timerPlaying,
      child: Opacity(
        opacity: provider.timerPlaying ? 0.2 : 1,
        child: Column(
          children: [
            Text(
              'Pending Tasks: ',
              style: GoogleFonts.lato(
                fontSize: 14.0.sp,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
            SizedBox(
              height: 5.0.wp,
            ),
            Card(
              margin:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
              color: Colors.white.withOpacity(0.75),
              child: SingleChildScrollView(child: DoingList()),
            )
          ],
        ),
      ),
    );
  }
}
