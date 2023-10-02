import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/detail/widgets/lists/doing_list.dart';
import 'package:to_do_list/app/modules/detail/widgets/lists/done_list.dart';
import 'package:to_do_list/app/modules/home/controller.dart';
import 'package:to_do_list/app/modules/detail/widgets/pomodoro/widgets/pomodoro_timer.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    var currentTask = homeCtrl.task.value!;
    var currentColor = HexColor.fromHex(currentTask.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(1.5.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.chevron_back),
                      onPressed: () {
                        // we need to set the current task back to null before the details page
                        // this way we are eliminatin the risk of any data conflicts
                        Get.back();
                        // first update the todos inside the task
                        homeCtrl.updateTodos();
                        // then deselect the chosen task
                        homeCtrl.changeTask(null);
                        // and finally clear the input
                        homeCtrl.editController.clear();
                      },
                    ),
                    PopupMenuButton(
                      padding: const EdgeInsets.all(0),
                      elevation: 2,
                      splashRadius: null,
                      enableFeedback: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              Get.to(() => PomodoroTimerScreen(),
                                  transition: Transition.fadeIn);
                            },
                            child: Text(
                              "Pomodoro 30:5",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          PopupMenuItem(
                            child: Text("Pomodoro 30:5",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                          PopupMenuItem(
                            child: Text("Pomodoro 30:5",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ];
                      },
                      child: Text(
                        'Start ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        currentTask.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: currentColor,
                    ),
                    SizedBox(
                      width: 1.5.wp,
                    ),
                    Text(
                      currentTask.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.wp, right: 16.0.wp, top: 3.0.wp),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                      ),
                      SizedBox(width: 3.0.wp),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeCtrl.doneTodos.length,
                          size: 5.0,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                              colors: [
                                currentColor.withOpacity(0.5),
                                currentColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          unselectedGradientColor: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade200
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      prefixIcon:
                          const Icon(CupertinoIcons.square, color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (homeCtrl.formKey.currentState!.validate()) {
                            var success =
                                homeCtrl.addTodo(homeCtrl.editController.text);
                            if (success) {
                              EasyLoading.showSuccess('ToDo Added');
                            } else {
                              EasyLoading.showError('Failed to Add ToDo');
                            }
                            homeCtrl.editController.clear();
                          }
                        },
                        icon: const Icon(CupertinoIcons.check_mark,
                            color: Colors.grey),
                      )),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Invalid to-do name';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ], // ListView chldren
          ),
        ),
      ),
    );
  }
}
