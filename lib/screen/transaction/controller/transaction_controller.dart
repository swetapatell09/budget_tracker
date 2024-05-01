import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  Rx<DateTime> date = DateTime.now().obs;
}
