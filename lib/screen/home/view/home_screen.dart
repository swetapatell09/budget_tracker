import 'package:budget_tracker/screen/home/controller/home_controller.dart';
import 'package:budget_tracker/screen/transaction/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtname = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TransactionController tController = Get.put(TransactionController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tController.getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget tracker"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      Get.toNamed('add_category');
                    },
                    child: Text("ADD CATEGORY")),
              ];
            },
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  "${tController.l2[index].title!}\n\$git${tController.l2[index].amount}"),
              subtitle: tController.l2[index].status == 0
                  ? Text("Income")
                  : Text("Expense"),
              leading: Container(
                child: Text(tController.l2[index].category!),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.defaultDialog(title: "are you sure?", actions: [
                          ElevatedButton(
                            onPressed: () {
                              DBHelper.helper
                                  .deleteTransaction(tController.l2[index].id!);
                              tController.getTransaction();
                              Get.back();
                            },
                            child: Text("Yes"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No"),
                          ),
                        ]);
                      },
                      child: Icon(Icons.delete)),
                  TextButton(
                    onPressed: () {
                      txtname.text = tController.l2[index].title!;
                      Get.defaultDialog(
                        title: "are you sure",
                        content: TextField(
                          controller: txtname,
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              String title = txtname.text;
                              DBHelper.helper.updateTransaction(
                                  category: tController.l2[index].category!,
                                  title: title,
                                  amount: tController.l2[index].amount!,
                                  date: tController.l2[index].date!,
                                  time: tController.l2[index].time!,
                                  status: tController.l2[index].status!,
                                  id: tController.l2[index].id!);
                              tController.getTransaction();
                              Get.back();
                            },
                            child: Text("upadate"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("cancel"),
                          ),
                        ],
                      );
                    },
                    child: Icon(Icons.edit),
                  ),
                ],
              ),
            );
          },
          itemCount: tController.l2.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('transaction');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
