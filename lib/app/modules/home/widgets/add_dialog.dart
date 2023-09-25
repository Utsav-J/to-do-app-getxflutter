import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog(Key? key) : super(key: key);
  @override
  Widget build(context) {
    return Scaffold(
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
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(CupertinoIcons.back),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Select the task type');
                          } else if (homeCtrl.editController.text
                              .trim()
                              .isEmpty) {
                            EasyLoading.showError('Enter the task name');
                          } else {
                            // todo implement this function
                            var success = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.editController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess('ToDo item added');
                              Get.back();
                              homeCtrl.editController.clear();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('ToDo item already exists');
                            }
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.green),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Text(
                'New Task',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 24.0.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                cursorColor: Colors.black54,
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  labelText: '',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Invalid Task Name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0.wp, left: 5.0.wp),
              child: Text(
                'Add to: ',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    color: const Color.fromARGB(255, 124, 124, 124)),
              ),
            ),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () {
                          homeCtrl.changeTask(element);
                        },
                        borderRadius: BorderRadius.circular(10),
                        splashColor:
                            HexColor.fromHex(element.color).withOpacity(0.5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              SizedBox(
                                width: 5.0.wp,
                              ),
                              Text(
                                element.title,
                                style: TextStyle(
                                    fontSize: 13.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              if (homeCtrl.task.value == element)
                                const Icon(
                                  CupertinoIcons.checkmark_square_fill,
                                  color: Colors.grey,
                                )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
