import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/data/modules/task.dart';
import 'package:to_do_list/app/modules/home/widgets/add_card.dart';
import 'package:to_do_list/app/modules/home/controller.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/home/task_card.dart';
import 'package:to_do_list/app/modules/home/widgets/add_dialog.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.wp),
              child: Text(
                'My List',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap:
                    true, // will only use the space that it needs, if false, it would use the total avl space of the parent
                physics:
                    const ClampingScrollPhysics(), // this ensures the user doesnt scroll beyond limits of the list
                children: [
                  // TaskCard(
                  //     task: Task(
                  //         title: 'My Task',
                  //         icon: getIcons()[0].icon!.codePoint,
                  //         color: "#FF2B60E6")),
                  ...controller.tasks
                      .map(
                        (element) => LongPressDraggable(
                          data: element,
                          hapticFeedbackOnStart: true,
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          onDragEnd: (_) => controller.changeDeleting(false),
                          feedback: Opacity(
                            opacity: 0.6,
                            child: TaskCard(task: element),
                          ),
                          child: TaskCard(task: element),
                        ),
                      )
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(key),
                      transition: Transition.rightToLeftWithFade);
                } else {
                  EasyLoading.showInfo('Please create a task category first');
                }
              },
              backgroundColor: (controller.deleting.value == true)
                  ? Colors.red
                  : Colors.black,
              child: (controller.deleting.value == true)
                  ? const Icon(
                      CupertinoIcons.delete_solid,
                    )
                  : const Icon(CupertinoIcons.add),
            ),
          );
        },
        onAccept: (Task taskData) {
          controller.deleteTask(taskData);
          EasyLoading.showSuccess('Deleted Task');
        },
      ),
    );
  }
}
