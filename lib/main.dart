import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipto_assignment/controllers/voucher_controller.dart';
import 'package:recipto_assignment/data/voucher_repository.dart';
import 'package:recipto_assignment/screens/voucher_screen.dart';

void main() {
  Get.put(VoucherController(repository: VoucherRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: VoucherScreen(),
    );
  }
}
