import 'package:budget_tracker/screen/home/controller/home_controller.dart';
import 'package:budget_tracker/screen/transaction/controller/transaction_controller.dart';
import 'package:budget_tracker/screen/transaction/model/transaction_model.dart';
import 'package:budget_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  HomeController controller = Get.put(HomeController());
  TransactionController tController = Get.put(TransactionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD INCOME/EXPENSE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: txtTitle,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: txtAmount,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Amount"),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2050));
                      tController.date.value = date!;
                    },
                    icon: const Icon(Icons.calendar_month)),
                Obx(
                  () => Text(
                      "${tController.date.value.day}/${tController.date.value.month}/${tController.date.value.year}"),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: tController.time.value.hour,
                              minute: tController.time.value.minute));
                      tController.time.value = time!;
                    },
                    icon: const Icon(Icons.watch_later)),
                Obx(
                  () => Text(
                      "${tController.time.value.hour}:${tController.time.value.minute}"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    TransactionModel model = TransactionModel(
                        title: txtTitle.text,
                        amount: txtAmount.text,
                        date:
                            "${tController.date.value.day}/${tController.date.value.month}/${tController.date.value.year}",
                        time:
                            "${tController.time.value.hour}:${tController.time.value.minute}",
                        status: 0);
                    DBHelper.helper.insertTransaction(model);
                  },
                  child: Text("Income"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
                ElevatedButton(
                  onPressed: () {
                    TransactionModel model = TransactionModel(
                        title: txtTitle.text,
                        amount: txtAmount.text,
                        date:
                            "${tController.date.value.day}/${tController.date.value.month}/${tController.date.value.year}",
                        time:
                            "${tController.time.value.hour}:${tController.time.value.minute}",
                        status: 1);
                    DBHelper.helper.insertTransaction(model);
                  },
                  child: Text("Expense"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
