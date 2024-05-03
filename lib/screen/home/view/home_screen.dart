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
        title: const Text("Budget tracker"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      Get.toNamed('add_category');
                    },
                    child: const Text("ADD CATEGORY")),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Income",
                      style: TextStyle(fontSize: 20),
                    ),
                    Obx(() => Text(
                          "\$${tController.income}",
                          style: TextStyle(fontSize: 30),
                        ))
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Expense",
                      style: TextStyle(fontSize: 20),
                    ),
                    Obx(() => Text(
                          "\$${tController.expense}",
                          style: TextStyle(fontSize: 30),
                        ))
                  ],
                ),
              )),
            ],
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tController.l2[index].id}"),
                    title: Text(
                      "${tController.l2[index].title}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "\$${tController.l2[index].amount}",
                      style: TextStyle(
                          fontSize: 18,
                          color: tController.l2[index].status == 0
                              ? Colors.green
                              : Colors.red),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "are you sure?",
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        DBHelper.helper.deleteTransaction(
                                            tController.l2[index].id!);
                                        tController.getTransaction();
                                        Get.back();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("No"),
                                    ),
                                  ]);
                            },
                            child: const Icon(Icons.delete)),
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
                                        category:
                                            tController.l2[index].category!,
                                        title: title,
                                        amount: tController.l2[index].amount!,
                                        date: tController.l2[index].date!,
                                        time: tController.l2[index].time!,
                                        status: tController.l2[index].status!,
                                        id: tController.l2[index].id!);
                                    tController.getTransaction();
                                    Get.back();
                                  },
                                  child: const Text("upadate"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("cancel"),
                                ),
                              ],
                            );
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: tController.l2.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('transaction');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
