import 'package:budget_tracker/screen/add_category/view/add_category_screen.dart';
import 'package:budget_tracker/screen/home/view/home_screen.dart';
import 'package:budget_tracker/screen/transaction/view/transaction_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> app_routs = {
  "/": (context) => const HomeScreen(),
  "add_category": (context) => const AddCategoryScreen(),
  "transaction": (context) => TransactionScreen(),
};
