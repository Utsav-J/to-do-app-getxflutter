import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/services/time_controller.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/widgets/timer_options.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/widgets/timer_task_progress.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/widgets/timercard.dart';
import 'package:to_do_list/app/modules/home/controller.dart';

class PomodoroTimerScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  PomodoroTimerScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          CupertinoIcons.clock,
          color: Colors.white.withOpacity(0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          homeCtrl.task.value!.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white.withOpacity(0.6)),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 16.0.wp),
              TimerCard(),
              SizedBox(height: 10.0.wp),
              TimerOptions(),
              SizedBox(height: 15.0.wp),
              TimeController(),
              SizedBox(height: 15.0.wp),
              TimerTaskProgress(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(12, 12, 12, 1),
    );
  }
}
