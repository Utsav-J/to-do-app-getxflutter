import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/data/modules/task.dart';
import 'package:to_do_list/app/modules/detail/view.dart';
import 'package:to_do_list/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);
  @override
  Widget build(context) {
    var squareWidth = Get.width - 12.0.wp;
    final currentColor = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: () {
        // setting the pressed task as the current task
        // so that it can be displayed on the details page
        // the controller will pass the data to the next page
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 7,
                offset: const Offset(0, 7)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep:
                  homeCtrl.isTodoEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
              padding: 0,
              size: 5,
              selectedGradientColor: LinearGradient(
                  colors: [currentColor.withOpacity(0.5), currentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              unselectedGradientColor: const LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            Icon(
              IconData(task.icon, fontFamily: 'MaterialIcons'),
              color: currentColor,
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Text(
                    '${task.todos?.length ?? 0} Tasks',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
