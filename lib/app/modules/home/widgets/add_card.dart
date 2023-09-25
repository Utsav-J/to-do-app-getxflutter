import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';
import 'package:to_do_list/app/core/values/colors.dart';
import 'package:to_do_list/app/data/modules/task.dart';
import 'package:to_do_list/app/modules/home/controller.dart';
import 'package:to_do_list/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2, // bc there will be two in each row
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.fromLTRB(0, 5.0.wp, 0, 0.0.wp),
              radius: 5,
              title: 'Create Task',
              titleStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 16.0.sp),
              content: Form(
                key: homeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 0),
                      child: TextFormField(
                        controller: homeCtrl.editController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 2.0.wp),
                          labelText: 'Title',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12.0.sp),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Invalid Title';
                          }
                          // return '';
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3.0.wp, 0, 1.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(
                                  () {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey.shade200,
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeCtrl.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homeCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          int itemIcon =
                              icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String itemColor =
                              icons[homeCtrl.chipIndex.value].color!.toHex();
                          var itemTask = Task(
                              title: homeCtrl.editController.text,
                              icon: itemIcon,
                              color: itemColor);
                          Get.back();
                          homeCtrl.addTask(itemTask)
                              ? EasyLoading.showSuccess('Task Created')
                              : EasyLoading.showError('Duplicate Task');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(150, 40)),
                      child: const Text('Confirm'),
                    )
                  ],
                ),
              ));
          homeCtrl.editController.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey.shade400,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
