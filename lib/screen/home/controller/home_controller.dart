import 'package:budget_tracker/screen/home/model/home_model.dart';
import 'package:budget_tracker/utils/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<HomeModel> l2 = <HomeModel>[].obs;

  Future<void> getCategory() async {
    List<HomeModel> l1 = await DBHelper.helper.readCategory();
    l2.value = l1;
  }
}
