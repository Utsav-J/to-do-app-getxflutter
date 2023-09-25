import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:to_do_list/app/data/services/storage/services.dart';
import 'package:to_do_list/app/modules/home/binding.dart';
import 'package:to_do_list/app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list/app/core/utils/extensions.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
        textTheme: TextTheme(
            titleLarge:
                TextStyle(fontSize: 32.0.sp, fontWeight: FontWeight.bold),
            titleMedium:
                TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
            titleSmall:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0.sp),
            bodyMedium:
                TextStyle(fontSize: 10.0.sp, fontWeight: FontWeight.w300)),
      ),
      title: "ToDo List",
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
