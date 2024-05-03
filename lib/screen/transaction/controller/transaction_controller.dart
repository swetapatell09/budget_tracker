import 'package:budget_tracker/screen/transaction/model/transaction_model.dart';
import 'package:budget_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  Rx<DateTime> date = DateTime.now().obs;
  Rxn<String> selectedValue = Rxn<String>();
  RxList<TransactionModel> l2 = <TransactionModel>[].obs;
  RxDouble income = 0.0.obs;
  RxDouble expense = 0.0.obs;

  Future<void> getTransaction() async {
    List<TransactionModel> l1 = await DBHelper.helper.readTransaction();
    l2.value = l1;
    getTotal();
  }

  void getTotal() {
    income.value = 0;
    expense.value = 0;
    for (var a in l2) {
      if (a.status == 0) {
        income.value = income.value + double.parse(a.amount!);
      } else {
        expense.value = expense.value + double.parse(a.amount!);
      }
    }
  }
}
