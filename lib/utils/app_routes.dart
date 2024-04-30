import 'package:budget_tracker/screen/add_category/view/add_category_screen.dart';
import 'package:budget_tracker/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> app_routs = {
  "/": (context) => HomeScreen(),
  "add_category": (context) => AddCategoryScreen(),
};
