import 'package:budget_tracker/screen/transaction/model/transaction_model.dart';
import 'package:budget_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  Rx<DateTime> date = DateTime.now().obs;
  Rxn<String> selectedValue = Rxn<String>();
  RxList<TransactionModel> l2 = <TransactionModel>[].obs;

  Future<void> getTransaction() async {
    List<TransactionModel> l1 = await DBHelper.helper.readTransaction();
    l2.value = l1;
  }
}
