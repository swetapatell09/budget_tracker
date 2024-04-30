import 'package:budget_tracker/screen/home/controller/home_controller.dart';
import 'package:budget_tracker/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtName = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Category"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Category is required";
                  }
                  return null;
                },
                controller: txtCategory,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    String name = txtCategory.text;
                    DBHelper.helper.insertCategory(name);
                    controller.getCategory();
                  }
                },
                child: Text("ADD CATEGORY")),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.l2.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text("${controller.l2[index].id}"),
                      title: Text("${controller.l2[index].name}"),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
